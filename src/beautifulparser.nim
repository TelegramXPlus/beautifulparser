import std/xmltree
import std/strtabs
import std/tables
import std/options


proc getNodes(node: XmlNode, name: string, options: Table[string, string]): seq[XmlNode] =
  for childr in node.findAll(name):
    block iterOptions:
      for k, v in options.pairs():
        if not (childr.attrs.hasKey(k) and childr.attrs[k] == v):
          break iterOptions
      result.add(childr)


proc getNode(node: XmlNode, name: string, options: Table[string, string]): Option[XmlNode] =
  for childr in node.findAll(name):
    block iterOptions:
      for k, v in options.pairs():
        if not (childr.attrs.hasKey(k) and childr.attrs[k] == v):
          break iterOptions
      return some(childr)


proc findAllNodes*(node: XmlNode, name: string, options: openArray[(string, string)] = []): seq[XmlNode] =
  let optionsAsTable = toTable(options)
  result = getNodes(node, name, optionsAsTable)


proc findAllNodes*(node: XmlNode, name: string, options = Table[string, string]()): seq[XmlNode] =
  result = getNodes(node, name, options)


proc findNode*(node: XmlNode, name: string, options: openArray[(string, string)] = []): Option[XmlNode] =
  let optionsAsTable = toTable(options)
  result = getNode(node, name, optionsAsTable)


proc findNode*(node: XmlNode, name: string, options = Table[string, string]()): Option[XmlNode] =
  result = getNode(node, name, options)
