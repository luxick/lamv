import os

const
  allowedExts = @[".org"]

proc scanDir*(dir: string): seq[string] =
  ## Walk the file system under the root dir and collect all files that could contain links
  setCurrentDir(dir)
  var parts: tuple[dir, name, ext: string]
  for entry in walkDirRec(getCurrentDir(), relative = true):
    if fileExists(entry):
      parts = splitFile(entry)
      if parts.ext in allowedExts:
        result.add(entry)

when isMainModule:
  let args = commandLineParams()
  var root = "./"
  if args.len == 1:
    root = args[0]
  let files = scanDir(root)
  echo "Found these files:\n", files

