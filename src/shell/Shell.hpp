#ifndef Shell_hpp
#define Shell_hpp

#include <string>
#include <vector>

class iTFShell {
public:
    iTFShell() = default;
    ~iTFShell() = default;

    /**
     * The main entry point for the CLI logic.
     * Takes a raw string from the Swift UI and returns the output.
     */
    std::string executeCommand(std::string input);

private:
    /**
     * Internal helper to split the input string into a command and its arguments.
     */
    std::vector<std::string> tokenize(const std::string& input);

    // Placeholder for your ported surgical tools
    std::string handlePeek(const std::vector<std::string>& args);
    std::string handleSys();
};

#endif