#!/bin/bash

set -e

touch /tmp/test.txt # This is to test file creation

echo "This is a test to write into an image locally." > /tmp/test.txt

cat /tmp/test.txt
