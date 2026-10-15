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
