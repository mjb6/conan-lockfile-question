#!/bin/bash

set -x

## Clean old builds
#conan remove -f "*"
rm -f locks/*

## Prepare environment
# 1) Build comp-a and create lockfile
cd comp-a
conan create . mjb6/testing -o my_option=value1
cd -

# 2) Build comp-b and create lockfile
cd comp-b
conan create . mjb6/testing -o my_option=value1
cd -

# 3) Integrate 1) and 2) into our "integration" project
cd integration
conan create . mjb6/testing -o *:my_option=value1
conan lock create conanfile.py --user=mjb6 --channel=testing --lockfile-out=../locks/integration_value1.lock -o *:my_option=value1
cd -
read -p "Preparation done. Press enter to continue"


## Example 1: Create new version of comp-a and comp-b. Integrate the update of comp-b but keep old version of comp-a
#  1) Create new version of comp-a
cd comp-a
cp conanfile.py conanfile.py.bak
cp conanfile2.py conanfile.py   # this just updates the version from 1.0.0 to 1.1.0
conan create . mjb6/testing -o my_option=value1
mv conanfile.py.bak conanfile.py
conan search "comp-a/*"
cd -

#2  1) Create new package of comp-b
cd comp-b
cp conanfile.py conanfile.py.bak
cp conanfile2.py conanfile.py   # this just updates the version from 2.0.0 to 2.1.0
conan create . mjb6/testing -o my_option=value1
mv conanfile.py.bak conanfile.py
conan search "comp-b/*"
cd -

# 3) Re-Create "integration" package. It should still use comp-a/1.0.0 and not comp-a/1.1.0, but comp-b/2.1.0
cd integration
#??? conan lock create . mjb6/testing --lockfile=???? --lockfile-out=../locks/integration_value1_new.lock - how to just update comp-b, but keep all other fixed versions from integration? 
#??? conan create . mjb6/testing --build=comp-b --lockfile=../locks/integration_value1_new.lock
cd -
