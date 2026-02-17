#!/usr/bin/env bash

set -e

show_help() {
    echo "Usage:"
    echo "  $0 <arg1> <arg2>"
    echo
    echo "Options:"
    echo "  --help     Show this help message"
    echo
    echo "Example:"
    echo "  $0 <gitEmail> <gitName>"
}

# ======================
# Handle --help
# ======================
if [[ "$1" == "--help" ]]; then
    show_help
    exit 0
fi

# ======================
# Validate argument count
# ======================
if [[ $# -ne 2 ]]; then
    echo "Error: requires exactly 2 arguments."
    echo
    show_help
    exit 1
fi

# ======================
# Reject unknown options
# ======================
if [[ "$1" == -* || "$2" == -* ]]; then
    echo "Error: unknown option."
    echo
    show_help
    exit 1
fi

./install.sh $1 $2

echo "[✓] Done. Please restart the shell or relogin."
