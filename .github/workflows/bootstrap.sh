#!/bin/bash

./bin/rails s
trap './.github/workflows/bootstrap.sh' $?
