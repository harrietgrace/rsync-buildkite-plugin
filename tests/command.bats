#!/usr/bin/env bats

load '/usr/local/lib/bats/load.bash'

# Uncomment to enable stub debug output:
# export BUILDKITE_AGENT_STUB_DEBUG=/dev/tty

@test "Pre-command downloads artifacts" {
  stub buildkite-agent \
    "artifact download *.log . : echo Downloading artifacts"

  export BUILDKITE_PLUGIN_ARTIFACTS_DOWNLOAD="*.log"
  run "$PWD/hooks/pre-command"

  assert_success
  assert_output --partial "Downloading artifacts"

  unstub buildkite-agent
  unset BUILDKITE_PLUGIN_ARTIFACTS_DOWNLOAD
}

@test "Pre-command downloads artifacts with step" {
  stub buildkite-agent \
    "artifact download --step 54321 *.log . : echo Downloading artifacts with args: --step 54321"

  export BUILDKITE_PLUGIN_ARTIFACTS_DOWNLOAD="*.log"
  export BUILDKITE_PLUGIN_ARTIFACTS_STEP="54321"
  run "$PWD/hooks/pre-command"

  assert_success
  assert_output --partial "Downloading artifacts with args: --step 54321"

  unstub buildkite-agent
  unset BUILDKITE_PLUGIN_ARTIFACTS_DOWNLOAD
  unset BUILDKITE_PLUGIN_ARTIFACTS_STEP
}

@test "Pre-command downloads artifacts with build" {
  stub buildkite-agent \
    "artifact download --build 12345 *.log . : echo Downloading artifacts with args: --build 12345"

  export BUILDKITE_PLUGIN_ARTIFACTS_DOWNLOAD="*.log"
  export BUILDKITE_PLUGIN_ARTIFACTS_BUILD="12345"
  run "$PWD/hooks/pre-command"

  assert_success
  assert_output --partial "Downloading artifacts with args: --build 12345"

  unstub buildkite-agent
  unset BUILDKITE_PLUGIN_ARTIFACTS_DOWNLOAD
  unset BUILDKITE_PLUGIN_ARTIFACTS_BUILD
}

@test "Post-command uploads artifacts with a single value for upload" {
  stub buildkite-agent \
    "artifact upload *.log : echo Uploading artifacts"

  export BUILDKITE_PLUGIN_ARTIFACTS_UPLOAD="*.log"
  run "$PWD/hooks/post-command"

  assert_success
  assert_output --partial "Uploading artifacts"

  unstub buildkite-agent
  unset BUILDKITE_PLUGIN_ARTIFACTS_UPLOAD
}

@test "Post-command uploads artifacts with a single value for upload and a job" {
  stub buildkite-agent \
    "artifact upload --job 12345 *.log : echo Uploading artifacts with args: --job 12345"

  export BUILDKITE_PLUGIN_ARTIFACTS_UPLOAD="*.log"
  export BUILDKITE_PLUGIN_ARTIFACTS_JOB="12345"
  run "$PWD/hooks/post-command"

  assert_success
  assert_output --partial "Uploading artifacts with args: --job 12345"

  unstub buildkite-agent
  unset BUILDKITE_PLUGIN_ARTIFACTS_UPLOAD
  unset BUILDKITE_PLUGIN_ARTIFACTS_JOB
}