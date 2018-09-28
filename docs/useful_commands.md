# Git Fetch, Pull, and Submodule Updates
## Git fetch and update submodules for all projects in this directory
find $WORKSPACE_ROOT -type d -depth 1 -not -name ".*" -exec bash -c "cd {} && pwd && git fetch --all --prune --tags && git submodule foreach git fetch --all --prune --tags" \;

## Git pull and update submodules for all projects in this directory
find $WORKSPACE_ROOT -type d -depth 1 -not -name ".*" -exec bash -c "cd {} && pwd && git pull && git submodule update --recursive --init" \;


# Python and Pipfiles
## Updating PipFile for everyone!
find $WORKSPACE_ROOT -name Pipfile -not -path "*/vendor/*" -exec bash -c 'cd $(dirname {}) && pwd && pipenv update' \;

## Rebuilt pipenv venvs for everyone!
find $WORKSPACE_ROOT -name Pipfile -not -path "*/vendor/*" -exec bash -c 'cd $(dirname {}) && pwd && pipenv --rm && pipenv update' \;


# Ansible and Molecule
## show the Ansible role projects that have commits past a tag
ls -d $WORKSPACE_ROOT/ansible-* | xargs -I {} bash -c "cd {} && pwd && git describe --tags"

## get all the ansible role projects' latest tags
ls -d $WORKSPACE_ROOT/ansible-* | xargs -I {} bash -c "cd {} && pwd && git describe --abbrev=0 --tags"

## Reload everyone's galaxy dependencies
ls -d $WORKSPACE_ROOT/wopr-* | xargs -I {} bash -c "cd {} && rm -r roles/vendor/* && pipenv run ansible-galaxy install -r ansible_requirements.yml --force"

## Run all the molecule tests that we have
find $WORKSPACE_ROOT -type d -name molecule -not -path "*/roles/*" | xargs -I {} bash -c "cd {} && cd .. && pipenv run molecule test"


# Homebrew
## List all installed brew packages, with their dependency list
brew list | while read cask; do echo -n $fg[blue] $cask $fg[white]; brew deps $cask --installed | awk '{printf(" %s ", $0)}'; echo ""; done

# List all installed brew packages, and the packages that depend on them
`brew_dep_parse.py`
