#include "quantum.h"
//#include "database/database.h"
//#include "testC.h"
#include "test.h"
#include <iostream>

FFI_PLUGIN_EXPORT intptr_t sum(intptr_t a, intptr_t b) { return a + b; }

FFI_PLUGIN_EXPORT int open_database(const char* path) {
    //return open_database2(path);
    std::cerr << "收到了：" << path << std::endl;
    return open_test("");
    //return open_testC("");
}