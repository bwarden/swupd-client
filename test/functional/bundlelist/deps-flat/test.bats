#!/usr/bin/env bats

load "../../swupdlib"

setup() {
  clean_test_dir
  create_manifest_tar 10 MoM
  sign_manifest_mom 10
  create_manifest_tar 10 os-core
  create_manifest_tar 10 test-bundle
  create_manifest_tar 10 test-bundle2
  create_manifest_tar 10 test-bundle3
}

teardown() {
  clean_tars 10
}

@test "bundle-list list bundle deps with flat included bundles" {
  run sudo sh -c "$SWUPD bundle-list $SWUPD_OPTS --deps test-bundle"

  [ "$status" -eq 0 ]
  check_lines "$output"
}

# vi: ft=sh ts=8 sw=2 sts=2 et tw=80
