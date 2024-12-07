#!/usr/bin/env bash

TARGET_PATCH_FILE_LOCATION="tools/esp-matter/connectedhomeip/connectedhomeip/"
PATCH_FILE_NAME="empty_wifi_stack_init.patch"
PATCH_FILE_LOCATION="patches/"

# Remember the current working directory
CURRENT_DIR=$(pwd)

# Copy the patch file to the desired location
cp "$PATCH_FILE_LOCATION$PATCH_FILE_NAME" "$TARGET_PATCH_FILE_LOCATION"

# Check if the copy was successful
if [ $? -ne 0 ]; then
    echo "Failed to copy the patch file."
    exit 1
fi

# Change to the patch file location
cd $TARGET_PATCH_FILE_LOCATION

# Apply the patch
if patch -p1 < "$PATCH_FILE_NAME"; then
    echo "Patch applied successfully."
else
    echo "Failed to apply patch."
    exit 1
fi

# Remove the patch file after applying the patch
rm "$PATCH_FILE_NAME"

# Check if the removal was successful
if [ $? -ne 0 ]; then
    echo "Failed to remove the patch file."
    exit 1
fi

# Return to the original directory
cd "$CURRENT_DIR"

# Output the exit status of the last command
echo $?
