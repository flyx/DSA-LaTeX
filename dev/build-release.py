#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys, re, codecs

import pystache, yaml, markdown

if len(sys.argv) is not 3:
   print "Invalid number of arguments.\n"
   print "Usage:"
   print "  {0} source-dir target-dir".format(sys.argv[0])
   exit(1)

mustache_input = {'sh' : { 'files': [] }, 'ps1' : { 'files' : [] }}

with open(sys.argv[1] + "/fanpaket.yaml", 'r') as input:
   fanpaket = yaml.load(input)
   mustache_input['sh']['url'] = fanpaket['url']
   mustache_input['ps1']['url'] = fanpaket['url']
   for source, target in fanpaket['files'].iteritems():
      mustache_input['sh']['files'].append({ 'source' : re.sub(r'([ \(\)])', r'\\\1', source), 'target' : target})
      mustache_input['ps1']['files'].append({ 'source' : source, 'target' : target})

for setuptype in ["sh", "ps1"]:
   with open(sys.argv[1] + "/fanpaket-setup." + setuptype + ".in", 'r') as input:
      with open(sys.argv[2] + "/fanpaket-setup." + setuptype, 'w') as output:
         output.write(pystache.render(input.read(), mustache_input[setuptype]).encode('utf-8'))

with codecs.open(sys.argv[1] + "/README-release.md", 'r', encoding='utf-8') as input:
   with codecs.open(sys.argv[2] + "/README.html", 'w', encoding='utf-8') as output:
      output.write(u"""
         <!doctype html>
         <html>
         <head>
            <title>LaTeX-Klasse für DSA-Dokumente</title>
            <style>body { width: 740px; margin: 0 auto; }</style>
         </head>
         <body>
      """)
      output.write(markdown.markdown(input.read()))
      output.write("</body>\n</html>")

print "Success!"