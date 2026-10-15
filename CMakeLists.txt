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

cmake_minimum_required(VERSION 3.16 FATAL_ERROR)

project(xsd VERSION 4.2.0 LANGUAGES CXX)

option(BUILD_SHARED_LIBS "Build as shared library" OFF)
option(BUILD_XSD_EXAMPLES "Build examples scripts" OFF)
option(BUILD_XSD_TESTS "Build test scripts" OFF)
option(BUILD_XSD_FRONTEND "Build compiler frontend" ON)

include(GNUInstallDirs)

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")

# Dependencies
include(extern/xercesc)
include(extern/libcutl)
if(BUILD_XSD_FRONTEND)
    add_subdirectory(frontend)
endif()

 
# Version
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

add_subdirectory(lib)
add_subdirectory(xsd)


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
