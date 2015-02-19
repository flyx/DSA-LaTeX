#!/usr/bin/env python
# -*- coding: utf-8 -*-

# ./build-fanpaket-setup.py <template> <fanpaket-yaml> <output>

import sys, re, codecs
import pystache, yaml

if len(sys.argv) is not 4:
   print "Invalid number of arguments.\n"
   print "Usage:"
   print "  {0} template fanpaket-yaml output".format(sys.argv[0])
   exit(1)

mustache_input = {'files': [] }

with codecs.open(sys.argv[2], 'r', 'utf-8') as input:
   fanpaket = yaml.load(input)
   mustache_input['url'] = fanpaket['url']
   for source, target in fanpaket['files'].iteritems():
      if sys.argv[3].endswith('.sh'):
         mustache_input['files'].append({ 'source' : re.sub(r'([ \(\)])', r'\\\1', source), 'target' : target})
      else:
         mustache_input['files'].append({ 'source' : source, 'target' : target})

with codecs.open(sys.argv[1], 'r', 'utf-8') as input:
   with codecs.open(sys.argv[3], 'w', 'utf-8') as output:
      output.write(pystache.render(input.read(), mustache_input))
