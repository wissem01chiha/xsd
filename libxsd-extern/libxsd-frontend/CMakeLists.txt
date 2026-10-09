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

add_library(libxsd-frontend STATIC 
    libxsd-frontend/types.cxx
    libxsd-frontend/parser.cxx
    libxsd-frontend/schema-dom-parser.cxx
)
target_include_directories(libxsd-frontend
    PUBLIC
        "${CMAKE_CURRENT_SOURCE_DIR}/libxsd-frontend"
)
target_link_libraries(libxsd-frontend PRIVATE
 cutl
 xerces-c
)