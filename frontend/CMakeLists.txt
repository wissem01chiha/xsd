# CMake build for libxsd-frontend
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

set(generators_sources
    libxsd-frontend/generators/dependencies.cxx
)

set(sementic_graph_sources
    libxsd-frontend/semantic-graph/attribute.cxx
)

set(xsd_frontend_sources
    libxsd-frontend/types.cxx
    libxsd-frontend/parser.cxx
    libxsd-frontend/schema-dom-parser.cxx
)

configure_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/libxsd-frontend/version.hxx.in"
    "${CMAKE_CURRENT_SOURCE_DIR}/libxsd-frontend/version.hxx"
    @ONLY
)

if(BUILD_SHARED_LIBS)
    add_library(xsd-frontend SHARED 
        ${generators_sources}
        ${sementic_graph_sources}
        ${xsd_frontend_sources}
    )
else()
    add_library(xsd-frontend STATIC 
        ${generators_sources}
        ${sementic_graph_sources}
        ${xsd_frontend_sources}
    )
endif()

get_target_property(cutl_include_dirs cutl INCLUDE_DIRECTORIES)

target_include_directories(xsd-frontend
    PUBLIC
        "${CMAKE_CURRENT_SOURCE_DIR}/xsd-frontend"
        "${cutl_include_dirs}"
)
target_include_directories(xsd-frontend PRIVATE 
   ${CMAKE_CURRENT_SOURCE_DIR}
)    

target_link_libraries(xsd-frontend PRIVATE
    cutl
    xerces-c
)

add_dependencies(xsd-frontend cutl xerces-c)