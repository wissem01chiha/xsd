# CMake build for xsd
#
# Written by Wissem Chiha <chihawissem08@gmail.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

cmake_minimum_required(VERSION 3.16)

project(xsd
    VERSION 4.2.0
    LANGUAGES CXX
)

include(GNUInstallDirs)

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")

# ------------------------------------------------------------
# Dependencies
# ------------------------------------------------------------
include(extern/xercesc)
include(extern/libcutl)
add_subdirectory(libxsd-extern/libxsd-frontend)
 
# find_package(libcutl CONFIG REQUIRED)
# find_package(XercesC REQUIRED)

# ------------------------------------------------------------
# Version
# ------------------------------------------------------------

set(XSD_VERSION_MAJOR "${PROJECT_VERSION_MAJOR}")
set(XSD_VERSION_MINOR "${PROJECT_VERSION_MINOR}")
set(XSD_VERSION_PATCH "${PROJECT_VERSION_PATCH}")

set(XSD_VERSION_STR  "${PROJECT_VERSION}")
set(XSD_VERSION_ID   "${PROJECT_VERSION}")
set(XSD_VERSION_FULL "${PROJECT_VERSION}")

# Final release.
set(XSD_PRE_RELEASE 0)
set(XSD_SNAPSHOT 0)
set(XSD_SNAPSHOT_ID "")

# Numeric version:
#
# AAAAA BBBBB CCCCC DDDE
#
math(EXPR XSD_VERSION_NUMBER
    "${XSD_VERSION_MAJOR} * 10000000000000"
)

math(EXPR XSD_VERSION_NUMBER
    "${XSD_VERSION_NUMBER} + ${XSD_VERSION_MINOR} * 100000000"
)

math(EXPR XSD_VERSION_NUMBER
    "${XSD_VERSION_NUMBER} + ${XSD_VERSION_PATCH} * 1000"
)

set(XSD_VERSION_HEADER
"// file      : xsd/version.hxx
// license   : GNU GPL v2 + exceptions; see accompanying LICENSE file

#ifndef XSD_VERSION

#define XSD_VERSION       ${XSD_VERSION_NUMBER}ULL
#define XSD_VERSION_STR   \"${XSD_VERSION_STR}\"
#define XSD_VERSION_ID    \"${XSD_VERSION_ID}\"
#define XSD_VERSION_FULL  \"${XSD_VERSION_FULL}\"

#define XSD_VERSION_MAJOR ${XSD_VERSION_MAJOR}
#define XSD_VERSION_MINOR ${XSD_VERSION_MINOR}
#define XSD_VERSION_PATCH ${XSD_VERSION_PATCH}

#define XSD_PRE_RELEASE   ${XSD_PRE_RELEASE}

#define XSD_SNAPSHOT      ${XSD_SNAPSHOT}ULL
#define XSD_SNAPSHOT_ID   \"${XSD_SNAPSHOT_ID}\"

#include <xercesc/util/XercesVersion.hpp>
#include <libcutl/version.hxx>
#include <libxsd-frontend/version.hxx>

#endif // XSD_VERSION
")

file(GENERATE
    OUTPUT
        "${CMAKE_CURRENT_BINARY_DIR}/xsd/xsd/version.hxx"
    CONTENT
        "${XSD_VERSION_HEADER}"
)

# ------------------------------------------------------------
# Sources
# ------------------------------------------------------------

file(GLOB_RECURSE XSD_SOURCES CONFIGURE_DEPENDS
    "${CMAKE_CURRENT_SOURCE_DIR}/xsd/xsd/*.cxx"
)

# Don't compile the pregenerated files through the normal source
# glob. They are explicitly listed below.
list(FILTER XSD_SOURCES EXCLUDE REGEX
    "/pregenerated/"
)

# ------------------------------------------------------------
# Pregenerated CLI sources
# ------------------------------------------------------------

set(XSD_PREGENERATED_DIR
    "${CMAKE_CURRENT_SOURCE_DIR}/xsd/xsd/pregenerated/xsd"
)

set(XSD_GENERATED_SOURCES
    "${XSD_PREGENERATED_DIR}/options.cxx"
    "${XSD_PREGENERATED_DIR}/cxx/options.cxx"
    "${XSD_PREGENERATED_DIR}/cxx/parser/options.cxx"
    "${XSD_PREGENERATED_DIR}/cxx/tree/options.cxx"
)

# ------------------------------------------------------------
# Executable
# ------------------------------------------------------------

add_executable(xsd
    ${XSD_SOURCES}
    ${XSD_GENERATED_SOURCES}
)

target_include_directories(xsd
    PRIVATE
         "${CMAKE_CURRENT_BINARY_DIR}/xsd"
         "${CMAKE_CURRENT_SOURCE_DIR}/xsd"
         "${CMAKE_CURRENT_SOURCE_DIR}/xsd/xsd"
         "${CMAKE_CURRENT_SOURCE_DIR}/xsd/xsd/pregenerated"
)

target_link_libraries(xsd
     PRIVATE
         xsd-frontend
         cutl
         xerces-c
)

get_target_property(xsd-frontend-include-dirs xsd-frontend INCLUDE_DIRECTORIES)

target_include_directories(xsd PUBLIC 
    ${xsd-frontend-include-dirs}
)

target_compile_features(xsd
     PRIVATE
         cxx_std_11
)

set(XSD_COPYRIGHT
     "Copyright (c) 2005-2026 Code Synthesis Tools CC"
     CACHE STRING "XSD copyright notice"
)

target_compile_definitions(xsd
    PRIVATE
        XSD_COPYRIGHT="${XSD_COPYRIGHT}"
)

set_target_properties(xsd PROPERTIES
    OUTPUT_NAME xsdcxx
)


include(GNUInstallDirs)

#/usr/bin
install(TARGETS xsd
     RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

#/usr/include/xsd
install(
    DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/libxsd/xsd"
     DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
     FILES_MATCHING
        PATTERN "*.hxx"
        PATTERN "*.ixx"
        PATTERN "*.txx"
)
