#!/usr/bin/env bash

set -eu

[[ -z "${DEBUG:-}" ]] || set -x

main() {
  local dir
  dir="$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd)"

  "${dir}/bootstrap.sh"
	# shellcheck disable=SC1090
  source "$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd)/.env"

  export UTTEST=true

  cd /home/travis/go/src/github.com/goharbor/harbor
  bash ./tests/travis/ut_install.sh
  bash ./tests/travis/ut_run.sh "$IP"
}

main
