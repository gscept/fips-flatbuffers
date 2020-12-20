#
# project: fips-flatbuffers
#

if (NOT FIPS_IMPORT)
    cmake_minimum_required(VERSION 3.12)
    get_filename_component(FIPS_ROOT_DIR "../fips" ABSOLUTE)
    include("${FIPS_ROOT_DIR}/cmake/fips.cmake")
    fips_setup()
    fips_project(fips-flatbuffers)
endif()

fips_begin_lib(flatbuffers)
    fips_dir(flatbuffers GROUP .)
    fips_files(src/code_generators.cpp
               src/idl_gen_fbs.cpp
               src/idl_gen_text.cpp
               src/idl_parser.cpp
               src/reflection.cpp
               src/util.cpp
    )

fips_end_lib()

if (NOT FIPS_IMPORT)
    fips_finish()
endif()


