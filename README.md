# Knight Moves

A simple ruby script which when provided with a starting position and ending position (eg, start=a1 and end=d4) prints out the results on to the console.

- Standard 8x8 chessboard, and this simple notation for squares:
http://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/SCD_algebraic_notation.svg/242px-SCD_algebraic_notation.svg.png

- Standard rules of movement for the Knight piece as outlined on Wikipedia:
http://en.wikipedia.org/wiki/Knight_(chess)#Movement

## DEPENDENCY

Requires ruby version 1.9 or higher.

## Usage

Run script in bin/ following two squares' coordinates (first as start and second as target):
```
bin/knight_moves.rb a1 c6
```

Or run script, and enter coordinates in the next line as STDIN:
```
bin/knight_moves.rb
a1 c6
```

## Test

Run:
```
bundle install
bundle exec rspec
```
