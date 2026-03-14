#include "Bridge.h"
#include "Shell.hpp"

static iTFShell core;

extern "C" const char* run_itf_command(const char* input) {
    // We use a static string to return the result back to Swift safely
    static std::string result;
    result = core.executeCommand(std::string(input));
    return result.c_str();
}
