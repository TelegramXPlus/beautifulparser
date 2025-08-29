import std/xmltree
import std/strtabs
import std/tables
import std/options

export xmltree
export options


proc matches(child: XmlNode, options: Table[string, string]): bool =
  ## Check if the child node matches the given options.
  for k, v in options.pairs():
    if not (child.attrs.hasKey(k) and child.attrs[k] == v):
      return false
  return true


proc getNodes(node: XmlNode, name: string, options: Table[string, string]): seq[XmlNode] =
  ## Find all child nodes with the given name and attributes matching the options.
  if len(options) == 0:
    return node.findAll(name)

  for childr in node.findAll(name):
    if childr.attrsLen == 0:
      continue
    if matches(childr, options):
      result.add(childr)


proc getNode(node: XmlNode, name: string, options: Table[string, string]): Option[XmlNode] =
  ## Find the first child node with the given name and attributes matching the options.
  let nodes = node.findAll(name)

  if len(nodes) == 0:
    return none(XmlNode)

  if len(options) == 0:
    return some(nodes[0])

  for childr in nodes:
    if childr.attrsLen == 0:
      continue
    if matches(childr, options):
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
