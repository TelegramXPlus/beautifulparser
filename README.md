# beautifulparser

[![Test](https://github.com/TelegramXPlus/beautifulparser/actions/workflows/test.yml/badge.svg)](https://github.com/TelegramXPlus/beautifulparser/actions/workflows/test.yml)

beautifulparser is a (very) simple library for parsing HTML documents inspired by beautifulsoup4

## Getting Started
```
nimble install beautifulparser
```

## Usage
```nim
import std/htmlparser # to use loadHtml/parseHtml procedures
import beautifulparser


let html = loadHtml("input.html") # or parseHtml("<h1>Your html</h1>")

for i in html.findAllNodes("span", {"class": "my-custom-class"}):
  echo i.innerText

```

### Using tables
You can also use tables instead of arrays of tuples of strings (lol)
```nim
import std/[htmlparser, tables]
import beautifulparser


let html = loadHtml("input.html")

for i in html.findAllNodes("span", {"class": "my-custom-class"}.toTable()):
  echo i.innerText
```


### Get the first element
```nim
import std/htmlparser
import beautifulparser


let html = loadHtml("input.html")

let mySpan = html.findNode("span", {"class", "my-custom-class"})

if mySpan.isSome():
  # implement your logic
```