#
# project: fips-flatbuffers
#

cmake_minimum_required(VERSION 3.21)

if (NOT FIPS_IMPORT)
    project(fips-flatbuffers)

    get_filename_component(FIPS_ROOT_DIR "../fips" ABSOLUTE)
    include("${FIPS_ROOT_DIR}/cmake/fips.cmake")
    fips_setup()
    include_directories(flatbuffers/include)
    include_directories(flatbuffers)
    add_subdirectory(flatc)
endif()

fips_begin_lib(flatbuffers)
    fips_dir(flatbuffers GROUP .)
    fips_files(src/code_generators.cpp
               src/idl_gen_fbs.cpp
               src/idl_gen_binary.cpp
               src/idl_gen_text.cpp
               src/idl_parser.cpp
               src/reflection.cpp
               src/util.cpp
               src/file_manager.cpp
    )
    include_directories(flatbuffers/include)
    include_directories(flatbuffers)

fips_end_lib()

