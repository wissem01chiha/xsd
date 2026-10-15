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

configure_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/xsd/version.hxx.in"
    "${CMAKE_CURRENT_SOURCE_DIR}/xsd/version.hxx"
    @ONLY
)

set(XSD_PREGENERATED_DIR
    "${CMAKE_CURRENT_SOURCE_DIR}/xsd/pregenerated/xsd"
)

set(XSD_GENERATED_SOURCES
    "${XSD_PREGENERATED_DIR}/options.cxx"
    "${XSD_PREGENERATED_DIR}/cxx/options.cxx"
    "${XSD_PREGENERATED_DIR}/cxx/parser/options.cxx"
    "${XSD_PREGENERATED_DIR}/cxx/tree/options.cxx"
)

file(GLOB_RECURSE XSD_SOURCES CONFIGURE_DEPENDS
    "${CMAKE_CURRENT_SOURCE_DIR}/xsd/*.cxx"
)

if(BUILD_SHARED_LIBS)
    add_library(xsd SHARED 
        ${XSD_SOURCES} ${XSD_GENERATED_SOURCES})
else()
    add_library(xsd STATIC 
        ${XSD_SOURCES} ${XSD_GENERATED_SOURCES})
endif()

target_include_directories(xsd 
    PRIVATE
         "${CMAKE_CURRENT_SOURCE_DIR}"
         "${CMAKE_CURRENT_BINARY_DIR}/xsd"
         "${CMAKE_CURRENT_SOURCE_DIR}/xsd"
         "${CMAKE_CURRENT_SOURCE_DIR}/xsd/xsd"
         "${PROJECT_SOURCE_DIR}/lib"
         "${CMAKE_CURRENT_SOURCE_DIR}/xsd/pregenerated"
)

target_link_libraries(xsd PRIVATE
        xsd-frontend
        cutl
        xerces-c
)
add_dependencies(xsd xsd-frontend cutl xerces-c)

if(BUILD_XSD_FRONTEND)
  get_target_property(XSD_FRONTEND_INCLUDE_DIR xsd-frontend INCLUDE_DIRECTORIES) 
  target_include_directories(xsd PUBLIC ${XSD_FRONTEND_INCLUDE_DIR})
endif()

target_compile_features(xsd PRIVATE cxx_std_11)

set(XSD_COPYRIGHT
    "Copyright (c) 2005-2026 Code Synthesis Tools CC"
    CACHE STRING "XSD copyright notice"
)

target_compile_definitions(xsd
    PRIVATE XSD_COPYRIGHT="${XSD_COPYRIGHT}"
)

set_target_properties(xsd PROPERTIES OUTPUT_NAME xsdcxx)