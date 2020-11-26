# Git Fetch, Pull, and Submodule Updates
## Git fetch and update submodules for all projects in this directory
find $WORKSPACE_ROOT -maxdepth 1 -type d -not -name ".*" -not -wholename "$WORKSPACE_ROOT" -print0 | \
xargs -0 -I% -P 8 bash -c \
'echo -e "\n\n" && cd % && pwd && \
git fetch --all --prune --tags && git submodule foreach git fetch --all --prune --tags'

## Git pull and update submodules for all projects in this directory
find $WORKSPACE_ROOT -maxdepth 1 -type d -not -name ".*" -not -wholename "$WORKSPACE_ROOT" -print0 | \
xargs -0 -I% -P 8 bash -c \
'echo -e "\n\n" && cd % && pwd && \
git pull && git submodule update --recursive --init'


# Python and Pipfiles
## Updating PipFile for everyone!
find ${WORKSPACE_ROOT} \( -name ".*" -o -path "*/vendor/*" -o -path "*/archived_projects/*" \) -prune -o -name Pipfile -print0 | \
xargs -0 -I% bash -c \
'echo -e "\n\n" && cd $(dirname %) && pwd && \
pipenv update --dev'

## Rebuilt venvs for everyone!
find ${WORKSPACE_ROOT} \( -name ".*" -o -path "*/vendor/*" -o -path "*/archived_projects/*" \) -prune -o -name Pipfile -print0 | \
xargs -0 -I% bash -c \
'echo -e "\n\n" && cd $(dirname %) && pwd && \
pipenv --rm && pipenv install --dev'

## commit all pipfile and pipfile.lock changes
find ${WORKSPACE_ROOT} \( -name ".*" -o -path "*/vendor/*" -o -path "*/archived_projects/*" \) -prune -o -name Pipfile -print0 | \
xargs -0 -I% bash -c \
'echo -e "\n\n" && cd $(dirname %) && pwd && \
git reset && git add Pipfile Pipfile.lock && git commit -m "bumping Pipfile and Pipfile.lock"'

## Porque no los dos?
find ${WORKSPACE_ROOT} \( -name ".*" -o -path "*/vendor/*" -o -path "*/archived_projects/*" \) -prune -o -name Pipfile -print0 | \
xargs -0 -I% bash -c \
'echo -e "\n\n" && cd $(dirname %) && pwd && \
pipenv update --dev && git reset && git add Pipfile Pipfile.lock && git commit -m "bumping Pipfile and Pipfile.lock"'


# Ansible and Molecule
## show the ansible role projects that have commits past a tag
ls -d $WORKSPACE_ROOT/ansible-* | \
xargs -I% bash -c \
'echo -e "\n\n" && cd % && pwd && \
git describe --tags'

## get all the ansible role projects' latest tags
ls -d $WORKSPACE_ROOT/ansible-* | \
xargs -I% bash -c \
'echo -e "\n\n" && cd % && pwd && \
git describe --abbrev=0 --tags'

## Reload everyone's galaxy dependencies
ls -d $WORKSPACE_ROOT/wopr-* | \
xargs -I% -P 8 bash -c \
'echo -e "\n\n" && cd % && pwd && \
rm -r roles/vendor/* && pipenv run ansible-galaxy install -r ansible_requirements.yml --force'

## Run all the molecule tests that we have
find ${WORKSPACE_ROOT} -type d -name molecule -not -path "*/roles/*" -not -name ".*" | \
xargs -I% bash -c \
'echo -e "\n\n" && cd % && pwd && \
cd .. && pipenv run molecule test'


# Homebrew
## List all installed brew packages, with their dependency list
brew list --formula | while read cask; do echo -n $fg[blue] $cask $fg[white]; brew deps $cask --installed | awk '{printf(" %s ", $0)}'; echo ""; done

# List all installed brew packages, and the packages that depend on them
`brew_dep_parse.py`


# Miscellaneous
Renaming branches:
```
git branch -m master main
git push -u origin main

# If the old branch name was the default branch in Github, go to github and change the default branch to the new branch name

git push origin --delete master
git fetch --all --prune --tags
```
