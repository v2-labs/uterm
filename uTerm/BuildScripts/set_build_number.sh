#!/bin/sh

#  set_build_number.sh
#  uTerm
#
#  Created by Juvenal A. Silva Jr. on 01/11/16.
#  Copyright © 2016 v2-lab. All rights reserved.

git=$(sh /etc/profile; command -v git)
commit_hash=$(${git} rev-list --abbrev-commit --no-walk HEAD)
number_of_commits=$(${git} rev-list HEAD --count)
git_release_version=$(${git} describe --tags --always --abbrev=0)

target_plist="${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"
dsym_plist="${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Info.plist"

for plist in "${target_plist}" "${dsym_plist}"; do
    if [[ -f "${plist}" ]]; then
        /usr/libexec/PlistBuddy -c "Set :CFBundleVersion ${commit_hash}" "${plist}"
        /usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString ${git_release_version#*v}" "${plist}"
    fi
done

/usr/libexec/PlistBuddy -c "Add :LSUIElement bool true" "${plist}"
