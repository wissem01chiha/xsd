
set(XSD_VERSION_MAJOR "${PROJECT_VERSION_MAJOR}")
set(XSD_VERSION_MINOR "${PROJECT_VERSION_MINOR}")
set(XSD_VERSION_PATCH "${PROJECT_VERSION_PATCH}")

set(XSD_VERSION_STR  "${PROJECT_VERSION}")
set(XSD_VERSION_ID   "${PROJECT_VERSION}")
set(XSD_VERSION_FULL "${PROJECT_VERSION}")

# Populate the version variables expected by the generated *.hxx templates.
set(xsd.version.project "${PROJECT_VERSION}")
set(xsd.version.project_id "${PROJECT_VERSION}")
set(xsd.version "${PROJECT_VERSION}")
set(xsd.version.major "${PROJECT_VERSION_MAJOR}")
set(xsd.version.minor "${PROJECT_VERSION_MINOR}")
set(xsd.version.patch "${PROJECT_VERSION_PATCH}")
set(xsd.version.pre_release 0)
set(xsd.version.snapshot 0)
set(xsd.version.snapshot_id "")
set(xsd.version.snapshot_sn 0)

# Final release.
set(XSD_PRE_RELEASE 0)
set(XSD_SNAPSHOT 0)
set(XSD_SNAPSHOT_ID "")

# Numeric version:
#
# AAAAA BBBBB CCCCC DDDE
#
math(EXPR XSD_VERSION_NUMBER "${XSD_VERSION_MAJOR} * 10000000000000")
math(EXPR XSD_VERSION_NUMBER "${XSD_VERSION_NUMBER} + ${XSD_VERSION_MINOR} * 100000000")
math(EXPR XSD_VERSION_NUMBER "${XSD_VERSION_NUMBER} + ${XSD_VERSION_PATCH} * 1000")
set(xsd.version.project_number "${XSD_VERSION_NUMBER}")

# Keep the legacy variable names for compatibility with older code.
set(libxsd.version "${PROJECT_VERSION}")
set(libxsd.version.project "${PROJECT_VERSION}")
set(libxsd.version.project_id "${PROJECT_VERSION}")
set(libxsd.version.major "${PROJECT_VERSION_MAJOR}")
set(libxsd.version.minor "${PROJECT_VERSION_MINOR}")
set(libxsd.version.patch "${PROJECT_VERSION_PATCH}")
set(libxsd.version.pre_release 0)
set(libxsd.version.snapshot 0)
set(libxsd.version.snapshot_id "")
set(libxsd.version.snapshot_sn 0)
set(libxsd.version.project_number "${XSD_VERSION_NUMBER}")

set(libxsd_frontend.version "${PROJECT_VERSION}")
set(libxsd_frontend.version.project "${PROJECT_VERSION}")
set(libxsd_frontend.version.project_id "${PROJECT_VERSION}")
set(libxsd_frontend.version.major "${PROJECT_VERSION_MAJOR}")
set(libxsd_frontend.version.minor "${PROJECT_VERSION_MINOR}")
set(libxsd_frontend.version.patch "${PROJECT_VERSION_PATCH}")
set(libxsd_frontend.version.pre_release 0)
set(libxsd_frontend.version.snapshot 0)
set(libxsd_frontend.version.snapshot_id "")
set(libxsd_frontend.version.snapshot_sn 0)
set(libxsd_frontend.version.project_number "${XSD_VERSION_NUMBER}")