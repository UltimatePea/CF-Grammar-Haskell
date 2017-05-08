# CF Grammar Generator Haskell

## What is it?

This file can generate words in a language given a particular syntax, for example

```
$ cat grammar.txt

E->Id:+:E|E'
E'->Id:*:T|Id
T->Id:*:T|T'
T'->Id
Id->1|(:E:)

$ hscfggen grammar.txt 20

1: 1
2: 1+1
3: 1+1+1
4: (1)+1+1
5: (1)+1
6: 1*1
7: 1+1+1+1
8: 1+(1)+1+1
9: 1+(1)+1
10: 1+1*1
11: (1+1)+1+1+1
12: (1+1)+1+1
13: (1+1)+(1)+1+1
14: (1+1)+(1)+1
15: (1)+1+1+1
16: (1)+(1)+1+1
17: (1)+(1)+1
18: (1+1)+1*1
19: (1+1)+1
20: (1)+1*1

```

## Install

First clone this repository, and then run
```
cabal install
```

You can now use `hscfggen` program.

To install `cabal` on macOS, try `brew cask install haskell-platform`.

## Usage

```
$ hscfggen [grammar-file [num-tokens] ] 
```

The program accepts two optional arguments, grammar file name and number 
of words to display. 
If `grammar-file` is not specified, `stdin` is used as a grammar file.

## Format of Grammar file

See example `grammar.txt`

- Use `->` to specify left and right hand side.
- Use `|` to split multiple right hand sides.
- Use `:` to concatenate symbols together.
- Leave empty for epsilon rules, e.g. `S->` OR `S->S'|`

## Attention and Limitations

- `->` is not allowed in Variables
- Neither `|` or `:` is  not allowed in variables or terminals.
- There are currently no escape sequences.
- You can use multi-character variables, since strings are concatenated together using `:`


