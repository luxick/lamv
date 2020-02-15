import os, re

type    
  Link = object
    ## Represents a link in a text file 
    href: string  ## The link part that connects to another file
    text: string  ## The text part of the link
    file: string  ## The file, the link is found in

const
  allowedExts = @[".org"]
  orgRegex = r"\[\[(.+)\]\[(.+)\]\]"

proc newLink(href, text, file: string): Link = 
  Link(href: href, text: text, file: file)

proc scanDir*(): seq[string] =
  ## Walk the file system under the root dir
  ## and collect all files that could contain links
  var parts: tuple[dir, name, ext: string]
  for entry in walkDirRec(getCurrentDir(), relative = true):
    if fileExists(entry):
      parts = splitFile(entry)
      if parts.ext in allowedExts:
        result.add(entry)

proc parseLinks*(file: string): seq[Link] =
  ## Parses the given text file and returns all links in the file
  let f = open(file)
  for line in f.lines:
    let matches = line.findAll(re(orgRegex))
    for match in matches:
      echo "Link: ", match, " in file ", file
      

when isMainModule:
  let args = commandLineParams()
  var root = "./"
  if args.len == 1:
    root = args[0]
  setCurrentDir(root)
  let files = scanDir()
  echo "Found these files:\n", files

