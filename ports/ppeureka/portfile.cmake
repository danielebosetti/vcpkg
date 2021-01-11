# 	See additional helpful variables in /docs/maintainers/vcpkg_common_definitions.md

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/shadowxiali/ppeureka/archive/0.0.2.tar.gz"
    FILENAME "0.0.2.tar.gz"
    SHA512 8442215c40b953e86c8b3a730c363a7d25ba9975ac0be24a23a878b9a399b1def1e4397e2d9f0fd998ba735cf531cba59226b2813a1e00174d74f06386c2c6f2
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    # (Optional) A friendly name to use instead of the filename of the archive (e.g.: a version number or tag).
    # REF 1.0.0
    # (Optional) Read the docs for how to generate patches at:
    # https://github.com/Microsoft/vcpkg/blob/master/docs/examples/patching.md
    # PATCHES
    #   001_port_fixes.patch
    #   002_more_port_fixes.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    # OPTIONS -DUSE_THIS_IN_ALL_BUILDS=1 -DUSE_THIS_TOO=2
    # OPTIONS_RELEASE -DOPTIMIZE=1
    # OPTIONS_DEBUG -DDEBUGGABLE=1
)

vcpkg_install_cmake()

# # Moves all .cmake files from /debug/share/ppeureka/ to /share/ppeureka/
# # See /docs/maintainers/vcpkg_fixup_cmake_targets.md for more details
vcpkg_fixup_cmake_targets(CONFIG_PATH cmake TARGET_PATH share/ppeureka)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
# # Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE_1_0.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/ppeureka RENAME copyright)
