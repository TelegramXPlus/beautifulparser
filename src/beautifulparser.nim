import std/xmltree
import std/strtabs
import std/tables
import std/options

export xmltree
export options


proc getNodes(node: XmlNode, name: string, options: Table[string, string]): seq[XmlNode] =
  ## Find all child nodes with the given name and attributes matching the options.
  for childr in node.findAll(name):
    if len(options) == 0:
      result.add(childr)
      continue
    elif childr.attrsLen == 0:
      continue
    block iterOptions:
      for k, v in options.pairs():
        if not (childr.attrs.hasKey(k) and childr.attrs[k] == v):
          break iterOptions
      result.add(childr)


proc getNode(node: XmlNode, name: string, options: Table[string, string]): Option[XmlNode] =
  ## Find the first child node with the given name and attributes matching the options.
  for childr in node.findAll(name):
    if len(options) == 0:
      return some(childr)
    elif childr.attrsLen == 0:
      continue
    block iterOptions:
      for k, v in options.pairs():
        if not (childr.attrs.hasKey(k) and childr.attrs[k] == v):
          break iterOptions
      return some(childr)


proc findAllNodes*(node: XmlNode, name: string, options: openArray[(string, string)] = []): seq[XmlNode] =
  ## Find all child nodes with the given name and attributes matching the options.
  let optionsAsTable = toTable(options)
  result = getNodes(node, name, optionsAsTable)


proc findAllNodes*(node: XmlNode, name: string, options = Table[string, string]()): seq[XmlNode] =
  ## Find all child nodes with the given name and attributes matching the options.
  result = getNodes(node, name, options)


proc findNode*(node: XmlNode, name: string, options: openArray[(string, string)] = []): Option[XmlNode] =
  ## Find the first child node with the given name and attributes matching the options.
  let optionsAsTable = toTable(options)
  result = getNode(node, name, optionsAsTable)


proc findNode*(node: XmlNode, name: string, options = Table[string, string]()): Option[XmlNode] =
  ## Find the first child node with the given name and attributes matching the options.
  result = getNode(node, name, options)
