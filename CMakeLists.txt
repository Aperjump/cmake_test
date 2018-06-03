cmake_minimum_required (VERSION 2.6)
project(Tutorial)

# add version number
set(Tutorial_VERSION_MAJOR 1)
set(Tutorial_VERSION_MINOR 0)

# should we use our own math functions?
include (${CMAKE_ROOT}/Modules/CheckFunctionExists.cmake)
check_function_exists(log HAVE_LOG)
check_function_exists(exp HAVE_EXP)

# config header
configure_file (
    "${PROJECT_SOURCE_DIR}/TutorialConfig.h.in"
    "${PROJECT_BINARY_DIR}/TutorialConfig.h"
)

option (USE_MYMATH "Use tutorial provided math implementation" ON)

include_directories("${PROJECT_BINARY_DIR}")

# add binary tree to the search path for include files
if (USE_MYMATH)
    include_directories("${PROJECT_BINARY_DIR}")
    add_subdirectory(MathFunctions)
    set(EXTRA_LIBS ${EXTRA_LIBS} MathFunctions)
endif(USE_MYMATH)

# add the executable
add_executable(Tutorial tutorial.cxx)
target_link_libraries(Tutorial ${EXTRA_LIBS})

install (TARGETS Tutorial DESTINATION bin)
install (FILES "${PROJECT_BINARY_DIR}/TutorialConfig.h"
         DESTINATION include)

include(CTest)
# do the application run
add_test (TutorialRuns Tutorial 25)
# do sqrt(25)
add_test (TutorialComps25 Tutorial 25)

# build a CPack driven installer package
include (InstallRequiredSystemLibraries)
set (CPACK_RESOURCE_FILE_LICENSE
     "${CMAKE_CURRENT_SOURCE_DIR}/License.txt")
set (CPACK_PACKAGE_VERSION_MAJOR "${Tutorial_VERSION_MAJOR}")
set (CPACK_PACKAGE_VERSION_MINOR "${Tutorial_VERSION_MINOR}")
include (CPack)

