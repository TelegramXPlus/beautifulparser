# beautifulparser
beautifulparser is a (very) simple library for parsing HTML documents inspired by beautifulsoup4

## Getting Started
```
nimble install beautifulparser

```

## Usage
```nim
import std/htmlparser # to use loadHtml/parseHtml procedures
import std/xmltree # to get typing for XmlNode
import beautifulparser


let html = loadHtml("input.html") # or parseHtml("<h1>Your html</h1>")

for i in html.findAllNodes("span", {"class": "my-custom-class"}):
  echo i.text

```

### Using tables
You can also use tables instead of arrays of tuples of strings (lol)
```nim
import std/htmlparser
import std/xmltree
import beautifulparser


let html = loadHtml("input.html")

for i in html.findAllNodes("span", {"class": "my-custom-class"}.toTable()):
  echo i.text
```


### Get the first element
```nim
import std/htmlparser
import std/options
import beautifulparser


let html = loadHtml("input.html")

let mySpan = html.findNode("span", {"class", "my-custom-class"})

if mySpan.isSome():
  # implement your logic
```