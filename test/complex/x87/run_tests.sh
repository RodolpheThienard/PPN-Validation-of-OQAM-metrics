#!/usr/bin/env bash
# check that MAQAO sees the x87 isn

set -euo pipefail

function verbose() {
  echo -e "==> $@"
}

# testing with double and simple precision
for using_double in true false
do
  # compilation
  make -B --silent DOUBLE="$using_double"
  verbose "compiling with DOUBLE=$using_double\n"

  # checking all the binaries
  for case in $(make list)
  do
    verbose "testing: $case"

    if maqao cqa fct-body=_test conf=all "$case" | grep -q "Detected X87 INSTRUCTIONS"; then
      # found a x87 message, stopping
      verbose "$case failed (no x87 isn found)"
      exit 1
    fi
  done
done

verbose "All test OK"
