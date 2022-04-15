#!/usr/bin/env bash

#set -euo pipefail

# $WORKSPACE is shared between steps
source $WORKSPACE/virtual/environment/bin/activate

cd pipeline/playbooks
ansible-playbook -i inventories build.yml -e app_repo=$APP_REPO -e app_branch=$BRANCH