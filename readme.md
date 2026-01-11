# msx-doom
POC for a very crude version of Doom, done circa September 2024.
There would be only objects (enemies, items, etc), not walls.
Gameplay would be just killing loads and loads of monsters and collecting ammo/health items. Pretty fun, I believe.

Using fixed point arithmetic (mostly 8.8) and abusing Look Up Tables for speed.
There is even a suite of automated unit tests for ensuring the math is correct.
The result was below the expectation, probably due to lack of precision on calculations.
Will try again someday with 8.16 fixed point numbers.
The good news is that there is plenty of CPU available, as can be seen on the colored bg to watch CPU use of each part of the main loop.

