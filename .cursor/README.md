# Cursor Terminal Setup

This directory contains Cursor IDE settings for custom terminal profiles.

## Terminal Profiles Available

### 1. Git Bash
- **Path**: `/bin/bash`
- **Usage**: Standard bash shell with login environment
- **How to open**: 
  - Press `Cmd + Shift + P` and type "Terminal: Create New Terminal"
  - Select "Git Bash" from the dropdown

### 2. Python Terminal
- **Path**: `/Library/Frameworks/Python.framework/Versions/3.13/bin/python3`
- **Usage**: Interactive Python shell
- **How to open**:
  - Press `Cmd + Shift + P` and type "Terminal: Create New Terminal"
  - Select "Python" from the dropdown

### 3. R Terminal
- **Path**: `/usr/local/bin/R`
- **Usage**: Interactive R console
- **How to open**:
  - Press `Cmd + Shift + P` and type "Terminal: Create New Terminal"
  - Select "R" from the dropdown

## How to Use

1. **Open a new terminal**: `Cmd + Shift + P` → "Terminal: Create New Terminal"
2. **Switch terminal type**: Click the dropdown in the terminal panel and select your preferred terminal
3. **Default terminal**: Git Bash is set as the default

## Troubleshooting

If terminals don't work:
1. Check if Python and R are installed: `which python3` and `which R`
2. Verify paths in `.cursor/settings.json` match your system
3. Restart Cursor after making changes to settings

## Quick Commands

- **Git Bash**: `bash -l`
- **Python**: `python3 -i`
- **R**: `R --vanilla` 