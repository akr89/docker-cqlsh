#!/bin/bash
set -e

case $1 in
cqlsh)
    shift
    exec gosu $GENERAL_USER cqlsh $@
  ;;
*)
    cmdline="$@"
    exec ${cmdline:-gosu $GENERAL_USER bash}
  ;;
esac
