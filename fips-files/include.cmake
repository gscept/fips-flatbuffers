#-------------------------------------------------------------------------------
#   Wrap flatc code generation
#

if(FIPS_LINUX)
    set(folder linux)
elseif(FIPS_MACOS)
    set(folder osx)
else()
    set(folder win32)
endif()

FIND_PROGRAM(FLATC
       NAMES flatc.exe flatc
       PATHS ${FIPS_PROJECT_DIR}/../fips-flatbuffers/tools/${folder}
       NO_DEFAULT_PATH
       )


macro(flatc)
    #fips_generate(TYPE FlatC FROM ${fbs} OUT_OF_SOURCE)    
    foreach(fb ${ARGN})
        set(target_has_flatc 1)
        get_filename_component(f_abs ${CurDir}${fb} ABSOLUTE)
        get_filename_component(f_dir ${f_abs} PATH)        
        STRING(REPLACE ".fbs" ".h" out_header ${fb})
        STRING(FIND "${CMAKE_CURRENT_SOURCE_DIR}"  "/" last REVERSE)
        STRING(SUBSTRING "${CMAKE_CURRENT_SOURCE_DIR}" ${last}+1 -1 folder)
        set(abs_output_folder "${CMAKE_BINARY_DIR}/flatbuffer/${CurTargetName}/${CurDir}")
        
        set(output ${abs_output_folder}/${out_header})
        
        add_custom_command(OUTPUT ${output}
                PRE_BUILD COMMAND ${FLATC} -c --gen-object-api --gen-compare --scoped-enums --gen-mutable --cpp-str-flex-ctor --cpp-str-type Util::String --filename-suffix "" -o "${abs_output_folder}" "${f_abs}" 
                MAIN_DEPENDENCY ${f_abs}
                DEPENDS ${FLATC}
                WORKING_DIRECTORY ${FIPS_PROJECT_DIR}
                COMMENT "Compiling ${fb} flatbuffer"
                VERBATIM
                )
        fips_files(${fb})
        
        SOURCE_GROUP("${CurGroup}\\Generated" FILES "${output}")
        source_group("${CurGroup}" FILES ${f_abs})
        list(APPEND CurSources "${output}")
    endforeach()
endmacro()