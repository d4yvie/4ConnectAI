﻿# AI Connect Four

This is a fork of an existing python-implementation of Connect Four from https://github.com/EpocDotFr/connectfour

## Improvements & New Features:
- Added faster win-condition checking
- Optimized Python Code with Cython
- Added an AI which uses the stateful MinMax-Algorithm with a search depth of 5
- Added an AI which uses the MinMax-Algorithm by copying boards with a search depth of 5
- Added an optimized AI which uses the stateful MinMax-Algorithm with Alpha-Beta pruning and a search depth of 7
- Added an optimized AI which uses the MinMax-Algorithm by copying boards with Alpha-Beta pruning and a search depth of 7

## Features for the future:

- Parallelized copy mode with alpha beta pruning
- Trace mode which visualizes what the AI plans

## Prerequisites

- Python 3.6 https://www.anaconda.com/download/
- VC 2015 C++ Compiler if you are on windows. http://go.microsoft.com/fwlink/?LinkId=691126 (vcvarsall.bat + compiler, default options in installer are enough)
- Linux is fine with the gcc compiler which comes with nearly every Linux-distribution.

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
