import unittest, os
import lamv

suite "Test the file detection":
  const root = "example"
  setCurrentDir(root)

  test "Find org files":
    let files = scanDir()
    var parts: tuple[dir, name, ext: string]
    check files.len > 1
    for file in files:
      parts = splitFile(file)
      check parts.ext == ".org"

  test "Find links in file":
    let files = scanDir()
    for file in files:
      discard file.parseLinks()