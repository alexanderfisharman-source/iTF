#ifndef Bridge_h
#define Bridge_h

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

// The bridge function that Swift will call
const char* run_itf_command(const char* input);

#ifdef __cplusplus
}
#endif

#endif