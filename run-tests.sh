#!/bin/sh -l

test_script_directory="${INPUT_TEST-SCRIPT-DIRECTORY}"
skript_repo_ref="${INPUT_SKRIPT-REPO-REF}"
run_vanilla_tests="${INPUT_RUN-VANILLA-TESTS}"
skript_test_directory="/skript/src/test/skript/tests"

echo "Configuration:"
echo "  Test script directory: $test_script_directory"
echo "  Skript repo ref: $skript_repo_ref"
echo "  Run vanilla tests: $run_vanilla_tests"

git clone --recurse-submodules https://github.com/SkriptLang/Skript.git /skript
cd /skript || exit 1
if [ -n "$skript_repo_ref" ]; then
  git checkout -f "$skript_repo_ref"
fi
if [ "$run_vanilla_tests" = "false" ]; then
  rm -rf "${skript_test_directory:?}/*"
fi
cp -r "/github/workspace/$test_script_directory" "${skript_test_directory:?}/custom"
./gradlew quickTest
