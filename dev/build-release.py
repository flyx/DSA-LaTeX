#!/usr/bin/env python

import sys, re

import pystache, yaml

if len(sys.argv) is not 3:
   print "Invalid number of arguments.\n"
   print "Usage:"
   print "  {0} source-dir target-dir".format(sys.argv[0])
   exit(1)

mustache_input = { 'files': []}

with open(sys.argv[1] + "/fanpaket-inhalt.yaml", 'r') as input:
   for source, target in yaml.load(input).iteritems():
      mustache_input['files'].append({ 'source' : re.sub(r'([ \(\)])', r'\\\1', source), 'target' : target})

for setuptype in ["sh", "ps1"]:
   with open(sys.argv[1] + "/fanpaket-setup." + setuptype + ".in", 'r') as input:
      with open(sys.argv[2] + "/fanpaket-setup." + setuptype, 'w') as output:
         output.write(pystache.render(input.read(), mustache_input).encode('utf-8'))

print "Success!"