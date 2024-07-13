#!/usr/bin/env bash

set -euox pipefail

start=`date +%s`
script_dir=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
cd ${script_dir}

test -f ./composer.lock && composer validate --ansi --strict
composer check-platform-reqs --ansi
composer normalize --diff --dry-run --no-interaction
composer audit --ansi --no-interaction

cd -
end=`date +%s`
finished_in_seconds=$((end-start))
