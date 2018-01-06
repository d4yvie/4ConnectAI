﻿# AI Connect Four

This is a fork of an existing python-implementation of Connect Four from https://github.com/EpocDotFr/connectfour

## Improvements:
- Added faster win-condition checking (does not check the whole board after one chip has been played)
- Added an AI which plays random turns
- Added an AI which uses the MinMax-Algorithm
- Added an optimized AI which uses the MinMax-Algorithm with Alpha-Beta pruning
- Optimized Python Code with Cython

## Prerequisites

Python 3.6

## Installation

Clone this repo, and install the required libraries for your python interpreter with: `pip install -r requirements.txt`.
Then run `bash cython_linux.sh` or `bash cython_windows.sh` dependant on your Operating System.
You can also start the game with python run.py --dev to start the cython_compiltation before starting
the game.

## Building

You can build Linux or Windows distributions with the build_linux.sh and build_windows.sh scripts.
The scripts use PyInstaller for the build-process.

## Configuration

Configurations like search depth can be configured in the settings.pyx. This requires a recompilation with cython afterwards.
The sound and music volume can be also configure in the connectfour.ini (which requires no recompilation).

## Usage

```
pip install -r requirements.txt
python run.py --dev # compile the game with cython and start it afterwards
```

## Controls

  - <kbd>ESC</kbd> quits to the menu or close the game when already on the menu
  - <kbd>←</kbd> and <kbd>→</kbd> moves the chip respectively to the left and to the right
  - <kbd>↓</kbd> drops the chip in the selected column
  - <kbd>↵</kbd> starts a new game when one is finished

##Distributions

compiled binaires can be downloaded at: https://gitlab.com/Dayvie/4Connect-dist