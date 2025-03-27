#!/bin/bash

# This script modifies Gearmulator to support 16 and 32 buffer sizes
# Target repo: https://github.com/ismdevteam/gearmulator

# --- Patch 1: Update BUFFER_SIZES in Gearmulator.h ---
sed -i 's/static const std::vector<int> BUFFER_SIZES = {0, 1, 2, 4, 8};/static const std::vector<int> BUFFER_SIZES = {0, 1, 2, 4, 8, 16, 32};/' \
    "source/gearmulator/Gearmulator.h"

# --- Patch 2: Update AudioParameterChoice in PluginProcessor.cpp ---
sed -i 's/StringArray{ "0", "1", "2", "4", "8" },/StringArray{ "0", "1", "2", "4", "8", "16", "32" },/' \
    "source/osTIrusJucePlugin/PluginProcessor.cpp"

# --- Patch 3: Update ComboBox options in PluginEditor.cpp ---
# First, check if the ComboBox entries exist
if grep -q 'bufferSizeBox.addItem("0 (Zero Latency)", 1);' "source/osTIrusJucePlugin/PluginEditor.cpp"; then
    # Delete existing buffer size entries
    sed -i '/bufferSizeBox.addItem("0 (Zero Latency)", 1);/,/bufferSizeBox.addItem("8", 5);/d' \
        "source/osTIrusJucePlugin/PluginEditor.cpp"

    # Insert new entries
    sed -i '/void GearmulatorAudioEditor::resized()/a \
    bufferSizeBox.addItem("0 (Zero Latency)", 1);\
    bufferSizeBox.addItem("1", 2);\
    bufferSizeBox.addItem("2", 3);\
    bufferSizeBox.addItem("4", 4);\
    bufferSizeBox.addItem("8", 5);\
    bufferSizeBox.addItem("16", 6);\
    bufferSizeBox.addItem("32", 7);' \
        "source/osTIrusJucePlugin/PluginEditor.cpp"
else
    echo "Warning: Could not find ComboBox entries in PluginEditor.cpp. Manual review needed."
fi

echo "✅ Patch applied successfully! Rebuild the project to see changes."a
