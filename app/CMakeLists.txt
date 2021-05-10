cmake_minimum_required(VERSION 3.4.1)

add_library(geckojni SHARED
  src/main/cpp/gecko.cpp)

target_link_libraries(geckojni
  GLESv2
  log)
