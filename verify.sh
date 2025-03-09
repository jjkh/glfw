#!/usr/bin/env bash
set -euo pipefail

git diff upstream/master \
    --diff-filter=d \
    ':(exclude)README.md' \
    ':(exclude)build.zig' \
    ':(exclude)build.zig.zon' \
    ':(exclude)update.sh' \
    ':(exclude)verify.sh' \
    ':(exclude).github' \
    ':(exclude).gitattributes' \
    ':(exclude).gitignore'
