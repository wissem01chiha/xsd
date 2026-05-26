# CMakeLists.txt for XSD/e Compiler
# Written by Wissem Chiha, Copyright (c) 2026 <chihawissem08@gmail.com>
# SPDX-License-Identifier: Copyright (c) 2005-2025 Code Synthesis. All rights reserved.
cmake_minimum_required(VERSION 3.18..3.24 FATAL_ERROR)

project(libxsde LANGUAGES C CXX)

# ============================================================================
# Properties
# ============================================================================
set(PROJECT_VERSION "4.2.0")
set(PROJECT_HOMEPAGE_URL "https://github.com/codesynthesis-com/xsd")
set(PROJECT_DESCRIPTION "XML Schema to C++ data binding compiler")

# ============================================================================
# CPack
# ============================================================================
set(CPACK_PACKAGE_VENDOR "Code-Synthesis")
set(CPACK_PACKAGE_DESCRIPTION_FILE ${CMAKE_SOURCE_DIR}/README.md)
set(CPACK_RESOURCE_FILE_LICENSE ${CMAKE_SOURCE_DIR}/LICENSE)
set(CPACK_RESOURCE_FILE_README ${CMAKE_SOURCE_DIR}/README.md)
set(CPACK_COMPONENTS_ALL Development Documentation Runtime)

# ============================================================================
# CTest
# ============================================================================
set(CTEST_OUTPUT_ON_FAILURE TRUE)

# ============================================================================
# CMake
# ============================================================================
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_C_VISIBILITY_PRESET hidden)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS ON)
set(CMAKE_C_STANDARD 17)

# ============================================================================
# Configuration
# ============================================================================
option(XSD_BUILD_TESTS "Build XSD unit tests" ON)
option(XSD_BUILD_EXAMPLES "Build XSD example applications" ON)
option(XSD_BUILD_SHARED_LIBS "Build XSD as a shared library" OFF)
option(XSD_BUILD_DOCUMENTATION "Build XSD documentation" OFF)
option(XSD_INSTALL_HEADERS "Install XSD header files" ON)

# ============================================================================
# Defaults
# ============================================================================
get_property(IS_MULTI GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)
if(NOT DEFINED CMAKE_BUILD_TYPE AND NOT IS_MULTI)
    message(STATUS "No CMAKE_BUILD_TYPE set -- using Release")
    set(CMAKE_BUILD_TYPE Release)
endif(NOT DEFINED CMAKE_BUILD_TYPE AND NOT IS_MULTI)
if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    set(CMAKE_INSTALL_PREFIX "${CMAKE_CURRENT_BINARY_DIR}/install" 
    CACHE PATH "Default install path" FORCE)
endif()


# ============================================================================
# Testing
# ============================================================================
if(XSD_BUILD_TESTS)
    include(CTest)
    enable_testing()
endif()

# ============================================================================
# Include Directories
# ============================================================================


# ============================================================================
# Source Files
# ============================================================================
set(xsd_sources
    xsd/xsd.cxx
    xsd/xsd/cxx/elements.cxx
    xsd/xsd/cxx/literal-map.cxx
    xsd/xsd/cxx/option-types.cxx
)

set(libxsd_sources

)

set(libxsd_headers

)

set(xsd_example_sources

)

set(xsd_test_sources
    xsd-tests/cxx/parser/built-in/driver.cxx
    xsd-tests/cxx/parser/enumeration/driver.cxx
)
# ============================================================================
# Libraries
# ============================================================================
