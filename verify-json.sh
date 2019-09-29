#!/bin/bash
# This script is for Continuous Integration, it triggers a complaint
# if ANY files are changed in the repo by earlier steps, so is not intended to be ran by devs

if ! git diff --quiet HEAD --; then
    git status
    echo
    echo Has a new target been added? please update target-configs.json
    exit 1
fi
