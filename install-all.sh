#!/bin/bash
#
# install-all.sh
# Wrapper to run both configuration and plugin installation scripts for the current user.
#

set -e

echo "Starting full installation to home directory..."

echo "=== Running install-config.sh ==="
./install-config.sh

echo "=== Running install-plugin.sh ==="
./install-plugin.sh

echo "=== All installations completed successfully! ==="