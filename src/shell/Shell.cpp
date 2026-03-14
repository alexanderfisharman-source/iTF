#include "Shell.hpp"
#include <sstream>
#include <vector>

std::string iTFShell::executeCommand(std::string input) {
    if (input.empty()) return "";

    // 1. Tokenize input
    std::stringstream ss(input);
    std::string cmd;
    std::vector<std::string> args;
    ss >> cmd;
    std::string arg;
    while (ss >> arg) args.push_back(arg);

    // 2. Surgical Command Logic
    if (cmd == "peek") {
        return "iTF: Binary Peek Logic -> [Surgical Port Success]";
    } else if (cmd == "sys") {
        return "iTF v1.0 | Mode: Bare Metal | Arch: Intel/ARM Hybrid";
    } else if (cmd == "clear") {
        return "SIGNAL_CLEAR"; // Swift will handle this
    }

    return "iTF: " + cmd + ": command not found";
}