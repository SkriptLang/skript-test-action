#!/bin/sh -l

test_script_directory="$1"
skript_repo_ref="$2"
run_vanilla_tests="$3"
skript_test_directory="src/test/skript/tests"

git clone --recurse-submodules https://github.com/SkriptLang/Skript.git
cd Skript || exit 1
if [ -n "$skript_repo_ref" ]; then
  git checkout -f "$skript_repo_ref"
fi
if [ "$run_vanilla_tests" = "false" ]; then
  rm -rf "${skript_test_directory:?}/*"
fi
cp -r "/github/workspace/$test_script_directory" "${skript_test_directory:?}/custom"
./gradlew quickTest
