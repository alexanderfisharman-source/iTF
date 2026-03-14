#ifndef Bridge_h
#define Bridge_h

#ifdef __cplusplus
extern "C" {
#endif

// Expose a simple C function that our C++ code implements
const char* run_itf_command(const char* input);

#ifdef __cplusplus
}
#endif

#endif