#!/bin/sh -l

test_script_directory="${INPUT_TEST_SCRIPT_DIRECTORY}"
skript_repo_ref="${INPUT_SKRIPT_REPO_REF}"
run_vanilla_tests="${INPUT_RUN_VANILLA_TESTS}"
skript_test_directory="/skript/src/test/skript/tests"
custom_test_directory="${skript_test_directory:?}/custom"

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
  echo "Deleting vanilla tests"
  ls -la "${skript_test_directory}"
  rm -rfv "${skript_test_directory:?}/*"
fi
mkdir "$custom_test_directory" && cp -r "/github/workspace/$test_script_directory" "$custom_test_directory"
./gradlew quickTest
