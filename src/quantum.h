#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
//#include "database/database.h"

#if _WIN32
#include <windows.h>
#else
#include <pthread.h>
#include <unistd.h>
#endif

#if _WIN32
#define FFI_PLUGIN_EXPORT __declspec(dllexport)
#else
#define FFI_PLUGIN_EXPORT
#endif

#ifdef __cplusplus
extern "C" {
#endif

FFI_PLUGIN_EXPORT intptr_t sum(intptr_t a, intptr_t b);

FFI_PLUGIN_EXPORT int open_database(const char* path);

#ifdef __cplusplus
}
#endif
