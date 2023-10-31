cmake_minimum_required(VERSION 3.10)

project(SimpleRESTAPI)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(httplib CONFIG REQUIRED)
find_package(nlohmann_json CONFIG REQUIRED)
find_package(OpenSSL REQUIRED)

add_executable(SimpleRESTAPI main.cpp)

target_link_libraries(SimpleRESTAPI PRIVATE httplib::httplib nlohmann_json::nlohmann_json OpenSSL::SSL OpenSSL::Crypto)

