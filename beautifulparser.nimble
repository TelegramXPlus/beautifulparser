# Package

version       = "0.1.5"
author        = "TelegramXPlus"
description   = "Simple parser for HTML"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 1.0.0"


task test, "Run tests":
  exec "nim c -r tests/test.nim"
