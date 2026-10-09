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

file(GLOB cutl_compiler_sources
    cutl/compiler/*.cxx
    cutl/compiler/*.ixx
    cutl/compiler/*.hxx
    cutl/compiler/*.txx
)

set(GLOB cutl_container_sources
    cutl/container/*.cxx
    cutl/container/*.ixx
    cutl/container/*.hxx
    cutl/container/*.txx
)

set(GLOB cutl_details_sources  
    cutl/details/*.cxx
    cutl/details/*.ixx
    cutl/details/*.hxx
    cutl/details/*.txx
)

set(GLOB cutl_fs_sources
    cutl/fs/*.cxx
    cutl/fs/*.ixx
    cutl/fs/*.hxx
    cutl/fs/*.txx
)

set(GLOB cutl_meta_sources
    cutl/meta/*.cxx
    cutl/meta/*.ixx
    cutl/meta/*.hxx
    cutl/meta/*.txx
)

set(GLOB cutl_re_sources
    cutl/re/*.cxx
    cutl/re/*.ixx
    cutl/re/*.hxx
    cutl/re/*.txx
)

set(GLOB cutl_shared_ptr_sources
    cutl/shared_ptr/*.cxx
    cutl/shared_ptr/*.ixx
    cutl/shared_ptr/*.hxx
    cutl/shared_ptr/*.txx
)

set(GLOB cutl_xml_sources  
    cutl/xml/*.cxx
    cutl/xml/*.ixx
    cutl/xml/*.hxx
    cutl/xml/*.txx
)
set(GLOB cutl_cutl_sources
    cutl/cutl/*.cxx
    cutl/cutl/*.hxx
)

set(cutl_sources
    ${cutl_compiler_sources}
    ${cutl_container_sources}
    ${cutl_details_sources}
    ${cutl_fs_sources}
    ${cutl_meta_sources}
    ${cutl_re_sources}
    ${cutl_shared_ptr_sources}
    ${cutl_xml_sources}
    ${cutl_cutl_sources}    
)

if(BUILD_SHARED_LIBS)
    add_library(cutl SHARED ${cutl_sources})
else()
    add_library(cutl STATIC ${cutl_sources})
endif()

target_include_directories(cutl
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
        $<INSTALL_INTERFACE:include>
)