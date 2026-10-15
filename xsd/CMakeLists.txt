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

file(GLOB_RECURSE XSD_SOURCES CONFIGURE_DEPENDS
    "${CMAKE_CURRENT_SOURCE_DIR}/xsd/*.cxx"
)

add_executable(xsd
    ${XSD_SOURCES}
)

target_include_directories(xsd
    PRIVATE
         "${CMAKE_CURRENT_SOURCE_DIR}"
         "${CMAKE_CURRENT_BINARY_DIR}/xsd"
         "${CMAKE_CURRENT_SOURCE_DIR}/xsd"
         "${CMAKE_CURRENT_SOURCE_DIR}/xsd/xsd"
         "${CMAKE_PROJECT_SOURCE_DIR}/lib"
)

target_link_libraries(xsd
     PRIVATE
        xsd-frontend
        cutl
        xerces-c
)