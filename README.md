# Action-black

[![Test](https://github.com/rickstaa/action-black/workflows/Test/badge.svg)](https://github.com/rickstaa/action-black/actions?query=workflow%3ATest)
[![release](https://github.com/rickstaa/action-black/workflows/release/badge.svg)](https://github.com/rickstaa/action-black/actions?query=workflow%3Arelease)
[![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/rickstaa/action-black?logo=github\&sort=semver)](https://github.com/rickstaa/action-black/releases)
[![action-bumpr supported](https://img.shields.io/badge/bumpr-supported-ff69b4?logo=github\&link=https://github.com/haya14busa/action-bumpr)](https://github.com/haya14busa/action-bumpr)

This action runs the [black formatter](https://github.com/psf/black) on push or pull requests to improve code review experience.

## Inputs

### `black_flags`

**optional**: Black input arguments. Defaults to `. --check --diff`.

### `fail_on_error`

**optional**: Exit code when black formatting errors are found \[true, false]. Defaults to 'false'.

## Outputs

### `is_formatted`

Boolean specifying whether any files were formatted using the black formatter.

## Basic usage

In it's simplest form this action can be used to check/format your code using the black formatter.

```yaml
name: reviewdo
on: [pull_request]
jobs:
  linter_name:
    name: runner / black formatter
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: reviewdog/action-black@v1
        with:
          black_args: "."
```

## Advanced use cases

### Annotate changes

This action can be combined with [reviewdog/action-suggester](https://github.com/reviewdog/action-suggester) to also annotate any possible changes.

```yaml
name: reviewdog
on: [push, pull_request]
jobs:
  name: runner / black
  runs-on: ubuntu-latest
  steps:
    - uses: actions/checkout@v2
    - name: Check files using black formatter
      uses: rickstaa/action-black@v1
    - name: Create Pull Request
      if: failure()
      uses: peter-evans/create-pull-request@v3
      with:
        token: ${{ secrets.GITHUB_TOKEN }}
        title: "Format Python code with psf/black push"
        commit-message: ":art: Format Python code with psf/black"
        body: |
          There appear to be some python formatting errors in ${{ github.sha }}. This pull request
          uses the [psf/black](https://github.com/psf/black) formatter to fix these issues.
        branch: actions/black
```

### Commit changes or create pull request

This action can be combined with [peter-evans/create-pull-request](https://github.com/peter-evans/create-pull-request) or [stefanzweifel/git-auto-commit-action](https://github.com/stefanzweifel/git-auto-commit-action) to also apply the annotated changes to the repository.

#### Commit changes

```yaml
name: reviewdog
on: [pull_request]
jobs:
  name: runner / black
  runs-on: ubuntu-latest
  steps:
    - uses: actions/checkout@v2
      with:
        ref: ${{ github.head_ref }}
    - name: Check files using black formatter
      uses: reviewdog/action-black@v1
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        reporter: github-check
        level: error
        fail_on_error: true
        format: true
    - name: Commit black formatting results
      if: failure()
      uses: stefanzweifel/git-auto-commit-action@v4
      with:
        commit_message: ":art: Format Python code with psf/black push"
```

#### Create pull request

```yaml
name: reviewdog
on: [pull_request]
jobs:
  name: runner / black
  runs-on: ubuntu-latest
  steps:
    - uses: actions/checkout@v2
    - name: Check files using black formatter
      uses: reviewdog/action-black@v1
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        reporter: github-check
        level: error
        fail_on_error: true
        format: true
    - name: Create Pull Request
      if: failure()
      uses: peter-evans/create-pull-request@v3
      with:
        token: ${{ secrets.GITHUB_TOKEN }}
        title: "Format Python code with psf/black push"
        commit-message: ":art: Format Python code with psf/black"
        body: |
          There appear to be some python formatting errors in ${{ github.sha }}. This pull request
          uses the [psf/black](https://github.com/psf/black) formatter to fix these issues.
        branch: actions/black
```
