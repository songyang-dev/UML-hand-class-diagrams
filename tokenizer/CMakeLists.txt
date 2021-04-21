cmake_minimum_required(VERSION 3.18)

project(yuml_tokenizer)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -lfl")

add_executable(${PROJECT_NAME} 
    main.c 
    lex.yy.c 
    parser.tab.c 
    parser.tab.h 
    tree.h)