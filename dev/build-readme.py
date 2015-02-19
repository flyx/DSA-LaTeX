#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys, codecs, markdown

# ./build-readme.py <input> <output>

with codecs.open(sys.argv[1], 'r', encoding='utf-8') as input:
  with codecs.open(sys.argv[2], 'w', encoding='utf-8') as output:
     output.write(u"""
        <!doctype html>
        <html>
        <head>
           <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
           <title>LaTeX-Klasse für DSA-Dokumente</title>
           <style>body { width: 740px; margin: 0 auto; }</style>
        </head>
        <body>
     """)
     output.write(markdown.markdown(input.read()))
     output.write("</body>\n</html>")