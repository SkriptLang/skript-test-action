import json
import os
import shutil
import subprocess
from pathlib import Path
from typing import TypedDict


def delete_contents_of_directory(directory: Path) -> None:
    for path in directory.iterdir():
        if path.is_file():
            path.unlink()
        elif path.is_dir():
            shutil.rmtree(path)


class EnvironmentResource(TypedDict):
    source: str
    target: str


github_workspace_directory = Path("/github/workspace")
test_script_directory = github_workspace_directory / os.environ['INPUT_TEST_SCRIPT_DIRECTORY']
skript_repo_ref = os.environ.get("INPUT_SKRIPT_REPO_REF", None)
run_vanilla_tests = os.environ.get("INPUT_RUN_VANILLA_TESTS", None) == "true"
skript_repo_git_url = "https://github.com/SkriptLang/Skript.git"
skript_repo_path = Path("/skript")
skript_test_directory = skript_repo_path / "src" / "test" / "skript" / "tests"
custom_test_directory = skript_test_directory / "custom"
extra_plugins_directory = None
extra_plugins_directory_string = os.environ.get("INPUT_EXTRA_PLUGINS_DIRECTORY", None)
if extra_plugins_directory_string is not None and extra_plugins_directory_string != "":
    extra_plugins_directory = github_workspace_directory / extra_plugins_directory_string

print("Configuration:")
print(f"  Test script directory: {test_script_directory}")
print(f"  Skript repo ref: {skript_repo_ref}")
print(f"  Run vanilla tests: {run_vanilla_tests}")
print(f"  Extra plugins directory: {extra_plugins_directory}")

subprocess.run(("git", "clone", "--recurse-submodules", skript_repo_git_url, str(skript_repo_path)))
os.chdir(skript_repo_path)
if skript_repo_ref is not None and not skript_repo_ref.isspace():
    subprocess.run(("git", "checkout", "-f", skript_repo_ref))
if not run_vanilla_tests:
    print("Deleting vanilla tests")
    delete_contents_of_directory(skript_test_directory)
if extra_plugins_directory is not None:
    environments_dir = skript_repo_path / "src" / "test" / "skript" / "environments"
    for environment_file_path in environments_dir.glob("**/*.json"):
        with open(environment_file_path, "r") as environment_file:
            environment = json.load(environment_file)
            if "resources" not in environment:
                environment["resources"] = []
            resources = environment["resources"]
            for plugin_path in extra_plugins_directory.iterdir():
                resources.append(EnvironmentResource(
                    source=str(plugin_path.absolute().resolve()),
                    target=f"plugins/{plugin_path.name}"
                ))
        with open(environment_file_path, "w") as environment_file:
            print(json.dumps(environment))
            json.dump(environment, environment_file)
shutil.rmtree(custom_test_directory, ignore_errors=True)
shutil.copytree(test_script_directory, custom_test_directory)
gradle_test_process = subprocess.run(("./gradlew", "quickTest"))
exit(gradle_test_process.returncode)
