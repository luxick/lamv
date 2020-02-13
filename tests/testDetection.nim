import unittest, os
import lamv

suite "Test the file detection":
  setup:
    const root = "./example"

  test "Directory does not exist":
    expect(OSError):
      discard scanDir("./ThisDirDoesNotExist")

  test "Find org files":
    let files = scanDir(root)
    var parts: tuple[dir, name, ext: string]
    check files.len > 1
    for file in files:
      parts = splitFile(file)
      check parts.ext == ".org"