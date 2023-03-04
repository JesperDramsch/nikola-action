# Nikola Action: a GitHub Action for building a Nikola site and deploying it.

This builds off version: getnikola/nikola-action@v8

Current version of last commit is: JesperDramsch/nikola-action@latest

# Usage

Full tutorial on the Nikola blog: [Automating Nikola rebuilds with GitHub Actions](https://getnikola.com/blog/automating-nikola-rebuilds-with-github-actions.html)

Short version:

1. Create a repository with a Nikola site.
2. Configure [nikola github_deploy](https://getnikola.com/handbook.html#deploying-to-github). Build and deploy your site locally first.
3. Ensure the correct branch for deployment is set on GitHub (repository settings). Refer to [this guide](https://github.com/peaceiris/actions-gh-pages#%EF%B8%8F-first-deployment-with-github_token).
4. Create a `.github/workflows/main.yml` file with the Sample Workflow.

## Sample Workflow

```yml
on: [push]

jobs:
  nikola_build:
    runs-on: ubuntu-latest
    name: 'Deploy Nikola to GitHub Pages'
    steps:
    - name: Check out
      uses: actions/checkout@v2
    - name: Build and Deploy Nikola
      uses: JesperDramsch/nikola-action@latest
```

## Options

- `dry_run` - if set to `true` only page build is performed, deploy is skipped

## Extras

By default, the action will install the latest stable release of `Nikola[extras]`. If you want to use the bleeding-edge version from `master`, or want to install some extra dependencies, you can provide a `requirements.txt` file in the repository, then the last commit on getnikola/nikola will be installed.

## Disclaimer

This action relies on commits rather than releases of the getnikole/nikola repository. This might break your site. Use at your own risk.

## Caveats

According to the main package it says, the action will attempt to `import conf` before installing Nikola or your requirements. If your `conf.py` has any imports outside of stdlib, you need to wrap those with a `try-except` block. For example, if you want to use filters, your `conf.py` should have this:

```py
try:
    from nikola import filters
    FILTERS = {
        ".html": [filters.typogrify],
        ".js": [filters.closure_compiler],
        ".jpg": ["jpegoptim --strip-all -m75 -v %s"],
    }
except ImportError:
    FILTERS = {}
```
