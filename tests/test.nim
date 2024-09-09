import unittest
import htmlparser
import strtabs
import beautifulparser


suite "beautifulparser":
  let htmlString = """
    <html>
      <head>
        <title>Test</title>
      </head>
      <body>
        <a href="url">Link</a>
        <p class="p">Paragraph</p>
        <p class="p">Another paragraph</p>
      </body>
    </html>
  """
  let html = parseHtml(htmlString)

  test "find title":
    let title = html.findNode("title")
    check title.isSome
    check title.get().innerText == "Test"

  test "find link":
    let link = html.findNode("a")
    check link.isSome
    check link.get().innerText == "Link"
    check link.get().attrs.getOrDefault("href", "") == "url"

  test "find paragraphs":
    let paragraphs = html.findAllNodes("p", {"class": "p"})
    check paragraphs.len == 2
    check paragraphs[0].innerText == "Paragraph"
