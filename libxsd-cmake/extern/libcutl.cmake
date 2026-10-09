# CMake build for libcutl
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

file(DOWNLOAD
    https://codesynthesis.com/download/libcutl/1.10/libcutl-1.10.0.zip
    ${CMAKE_BINARY_DIR}/_deps/libcutl-src/libcutl-1.10.0.zip
    SHOW_PROGRESS
)

add_custom_command(
    OUTPUT ${CMAKE_BINARY_DIR}/_deps/libcutl-src/libcutl-1.10.0.zip
    COMMAND ${CMAKE_COMMAND} -E make_directory
            ${CMAKE_BINARY_DIR}/_deps/libcutl-src
    COMMAND ${CMAKE_COMMAND} -E tar xf ${CMAKE_BINARY_DIR}/_deps/libcutl-src/libcutl-1.10.0.zip
    COMMAND ${CMAKE_COMMAND} -E copy_directory
            ${CMAKE_BINARY_DIR}/_deps/libcutl-src/libcutl-1.10.0
            ${CMAKE_BINARY_DIR}/_deps/libcutl-src
    COMMAND ${CMAKE_COMMAND} -E remove_directory
        ${CMAKE_BINARY_DIR}/_deps/libcutl-src/libcutl-1.10.0
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/_deps/libcutl-src
)

add_custom_command(
    OUTPUT ${CMAKE_BINARY_DIR}/_deps/libcutl-build/libcutl.a
    DEPENDS ${CMAKE_BINARY_DIR}/_deps/libcutl-src/libcutl-1.10.0.zip 
    COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_BINARY_DIR}/_deps/libcutl-build
    COMMAND bash ./configure --prefix=${CMAKE_BINARY_DIR}/_deps/libcutl-build
    COMMAND D:/Github/xsd/make.bat
    COMMAND D:/Github/xsd/make.bat install
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/_deps/libcutl-src
)

add_custom_target(cutl ALL
    DEPENDS ${CMAKE_BINARY_DIR}/_deps/libcutl-build/libcutl.a
)