cmake_minimum_required(VERSION 3.10)

project(QuantumNative VERSION 0.0.1 LANGUAGES C CXX)


set(CMAKE_CXX_STANDARD 17)
set(CXX_STANDARD_REQUIRED)


include(FetchContent)

FetchContent_Declare(simple
        GIT_REPOSITORY https://github.com/wangfenjin/simple.git
        GIT_TAG v0.2.2)
FetchContent_MakeAvailable(simple)

#FetchContent_GetProperties(simple)
#if(NOT simple_POPULATED)
#    # Fetch the content using previously declared details
#    FetchContent_Populate(simple)
#    add_subdirectory(${simple_SOURCE_DIR} ${simple_BINARY_DIR})
#endif()
message("simple2 ${simple_SOURCE_DIR} ${simple_BINARY_DIR}")

add_library(QuantumNative SHARED
        quantum.cc
        quantum.h
        #  database/database.cpp
        test.cc
        test.h
        )

target_link_libraries(QuantumNative PRIVATE simple)
target_link_libraries(QuantumNative PRIVATE SQLite3)

if (APPLE)
    message("configure for Apple")
    set_target_properties(QuantumNative PROPERTIES
            FRAMEWORK TRUE
            FRAMEWORK_VERSION A
            MACOSX_FRAMEWORK_IDENTIFIER direct.multiverse.QuantumNative
            VERSION 0.0.1
            SOVERSION 0.0.1
            PUBLIC_HEADER "quantum.h"
            XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "iPhone Developer"
            MACOSX_BUNDLE TRUE
            # RESOURCE "${RESOURCE_FILES}"
            )
endif()

set_target_properties(QuantumNative PROPERTIES
        PUBLIC_HEADER quantum.h
        OUTPUT_NAME "QuantumNative"
        )

target_compile_definitions(QuantumNative PUBLIC DART_SHARED_LIB)
