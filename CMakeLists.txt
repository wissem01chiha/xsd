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

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")

include(version)
include(extern/xercesc)
include(extern/libcutl)
if(BUILD_XSD_FRONTEND)
    add_subdirectory(frontend)
endif()

add_subdirectory(lib)
add_subdirectory(xsd)
if(BUILD_XSD_TESTS)
    add_subdirectory(test)
endif()
if(BUILD_XSD_EXAMPLES)
    add_subdirectory(example)
endif()

include(libxsd-install)
