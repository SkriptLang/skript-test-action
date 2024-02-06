# skript-test-action

skript-test-action is a GitHub Action that addon developers can use to utilize skript-test-action within their addons!
In addition to testing your own syntaxes, you can also run the vanilla Skript tests alongside your own to ensure that
your addon does not change any vanilla behavior!

### How to use
Using the action involves two pieces:
1. Configure a [GitHub Action](https://docs.github.com/en/actions/learn-github-actions) for your repository that builds
   your addon
2. Add skript-action-test as a step like so:
```yaml
      - name: Run tests
        uses: SkriptLang/skript-test-action@v1.0
        with:
          # the directory where your test scripts are located relative to the repo root
          test_script_directory: src/test/scripts
          # you can test against a specific skript version by specifying this tag
          # you can also not define it to use the latest master branch commit
          skript_repo_ref: 2.8.2
          # this should be where your addon jar is located relative to the repo root
          extra_plugins_directory: build/libs
```

A good minimal example of how to use skript-test-action can be found on the
[skript-reflect](https://github.com/SkriptLang/skript-reflect) repository. The action file is
[here](https://github.com/SkriptLang/skript-reflect/blob/feature/test-scripts/.github/workflows/gradle.yml) and the test scripts
directory is [here](https://github.com/SkriptLang/skript-reflect/tree/feature/test-scripts/src/test/scripts). There isn't
much documentation on how to write test scripts, but they are pretty simple. You can find plenty of examples on the
Skript repository [here](https://github.com/SkriptLang/Skript/tree/master/src/test/skript/tests).
