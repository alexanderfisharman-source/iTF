import SwiftUI


@main

struct iTFApp: App {
    var body: some Scene {
        WindowGroup {
            TerminalView()
                .preferredColorScheme(.dark)
        }
    }
}