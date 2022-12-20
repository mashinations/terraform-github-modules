#!/usr/bin/env bash

find ./modules -type d -name .terraform -prune -exec rm -rf {} +
find ./modules -type f -name .terraform.lock.hcl -exec rm -f {} +
find ./modules -type f -name .terraform.tfstate* -exec rm -f {} +
