cmake_minimum_required(VERSION 3.10)

set(PROJECT_NAME "quantum")
project(${PROJECT_NAME} LANGUAGES C CXX)

add_subdirectory("${CMAKE_CURRENT_SOURCE_DIR}/../src" "${CMAKE_CURRENT_BINARY_DIR}/lib")

set(SOURCE_FILES src/main.cc)

add_executable(quantum_example ${SOURCE_FILES})

#add_dependencies(quantum_example SQLite3)
#target_link_libraries(quantum_example PRIVATE SQLite3)
#message("yyy ${SQLite3_LIBRARIES}")
add_dependencies(quantum_example QuantumNative)
target_link_libraries(quantum_example PRIVATE QuantumNative)
target_include_directories(quantum_example PRIVATE ${QuantumNative_SOURCE_DIR})
message("xxx ${QuantumNative_LIBRARIES}")
#target_link_libraries(quantum_example PRIVATE "-framework QuantumNative")