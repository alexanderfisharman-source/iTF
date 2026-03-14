import SwiftUI

class TerminalViewModel: ObservableObject {
    @Published var history: String = "Welcome to iTF - iPhone Terminal Free\nType 'sys' to start.\n\n"
    
    func run(_ input: String) {
        // Call our C++ bridge (we'll implement the wrapper below)
        let result = String(cString: run_itf_command(input))
        
        if result == "SIGNAL_CLEAR" {
            history = ""
        } else {
            history += "iTF $ \(input)\n\(result)\n\n"
        }
    }
}

struct TerminalView: View {
    @StateObject var vm = TerminalViewModel()
    @State private var input: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView {
                Text(vm.history)
                    .font(.system(.body, design: .monospaced))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
            .background(Color.black)
            .foregroundColor(.green)
            
            HStack {
                Text("iTF $").foregroundColor(.green)
                TextField("", text: $input)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .foregroundColor(.white)
                    .onSubmit {
                        vm.run(input)
                        input = ""
                    }
            }
            .padding()
            .background(Color(white: 0.1))
        }
    }
}