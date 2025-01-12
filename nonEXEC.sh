#!/bin/bash

# Test script for git-helper.sh

# Define the script directory and test directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEST_DIR="$SCRIPT_DIR/testen"
mkdir -p "$TEST_DIR"

# Define the path to the git-helper script
GIT_HELPER_SCRIPT="$SCRIPT_DIR/git-helper.sh"

# Create a test Git repository
REPO_DIR="$TEST_DIR/test-repo"
mkdir -p "$REPO_DIR"
cd "$REPO_DIR"
git init

# Create some test files and commits
echo "Initial content" > file1.txt
git add file1.txt
git commit -m "Initial commit"

echo "Second content" > file2.txt
git add file2.txt
git commit -m "Second commit"

echo "Third content" > file1.txt
git commit -am "Update file1.txt"

# Go back to the script directory
cd "$SCRIPT_DIR"

# Run tests and save outputs
echo "Running tests..."

# Test check command
"$GIT_HELPER_SCRIPT" check > "$TEST_DIR/check_output.txt" 2>&1
"$GIT_HELPER_SCRIPT" check "$REPO_DIR" > "$TEST_DIR/check_repo_output.txt" 2>&1

# Test log command
"$GIT_HELPER_SCRIPT" log "$REPO_DIR" > "$TEST_DIR/log_output.txt" 2>&1
"$GIT_HELPER_SCRIPT" log "$REPO_DIR" name=Your_Name > "$TEST_DIR/log_filter_output.txt" 2>&1
"$GIT_HELPER_SCRIPT" log "$REPO_DIR" name=Your_Name asc > "$TEST_DIR/log_filter_asc_output.txt" 2>&1
"$GIT_HELPER_SCRIPT" log "$REPO_DIR" name=Your_Name desc > "$TEST_DIR/log_filter_desc_output.txt" 2>&1

# Test stats command
"$GIT_HELPER_SCRIPT" stats "$REPO_DIR" > "$TEST_DIR/stats_output.txt" 2>&1

# Test undo command
"$GIT_HELPER_SCRIPT" undo > "$TEST_DIR/undo_output.txt" 2>&1

# Test sync command
"$GIT_HELPER_SCRIPT" sync > "$TEST_DIR/sync_output.txt" 2>&1

# Test clean command
"$GIT_HELPER_SCRIPT" clean "$REPO_DIR" > "$TEST_DIR/clean_output.txt" 2>&1

# Test backup command
"$GIT_HELPER_SCRIPT" backup "$REPO_DIR" > "$TEST_DIR/backup_output.txt" 2>&1

# Test branch command
"$GIT_HELPER_SCRIPT" branch new-feature > "$TEST_DIR/branch_output.txt" 2>&1

# Test last command
"$GIT_HELPER_SCRIPT" last 5 "$REPO_DIR" > "$TEST_DIR/last_output.txt" 2>&1

# Test help command
"$GIT_HELPER_SCRIPT" help > "$TEST_DIR/help_output.txt" 2>&1

echo "Tests completed. Check the '$TEST_DIR' directory for output files."
