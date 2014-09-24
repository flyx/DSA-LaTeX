#!/usr/bin/env python
# -*- coding: utf-8 -*-

import yaml, yaml.nodes

class Talent(yaml.YAMLObject):

    @classmethod
    def from_yaml(cls, loader, node):
        if not isinstance(node, yaml.nodes.SequenceNode):
            raise Exception("Expected sequence node!")
        eigenschaften = []
        behinderung = ""
        for index, child in enumerate(node.value):
            scalar = loader.construct_scalar(child)
            if index < 3:
                eigenschaften.append(scalar)
            if index > 3:
                raise Exception("Too many values!")
            behinderung = scalar
        return cls(eigenschaften, behinderung)

    def __init__(self, eigenschaften, behinderung):
        self.eigenschaften = eigenschaften
        self.behinderung = behinderung

    def __repr__(self):
        return "(Eigenschaften: [" + ','.join(self.eigenschaften) + "], Behinderung: " + self.behinderung + ")"

class Spezialtalent(Talent):
    yaml_tag = u"!spez"

    def __init__(self, eigenschaften, behinderung):
        Talent.__init__(self, eigenschaften, behinderung)
        self.basis = False

    def __repr__(self):
        return "Spezialtalent" + Talent.__repr__(self)

class Basistalent(Talent):
    yaml_tag = u"!basis"

    def __init__(self, eigenschaften, behinderung):
        Talent.__init__(self, eigenschaften, behinderung)
        self.basis = True

    def __repr__(self):
        return "Basistalent" + Talent.__repr__(self)

class Kampftechnik(yaml.YAMLObject):

    @classmethod
    def from_yaml(cls, loader, node):
        if not isinstance(node, yaml.nodes.SequenceNode):
            raise Exception("Expected sequence node!")
        spalte = ""
        behinderung = ""
        for index, child in enumerate(node.value):
            scalar = loader.construct_scalar(child)
            if index is 0:
                spalte = scalar
            elif index is 1:
                behinderung = scalar
            else:
                raise Exception("Too many values!")
        return cls(spalte, behinderung)

    def __init__(self, spalte, behinderung):
        self.spalte = spalte
        self.behinderung = behinderung

    def __repr__(self):
        return "(Spalte: {}, Behinderung: {})".format(self.spalte, self.behinderung)

class Spezialkampftechnik(Kampftechnik):
    yaml_tag = u"!kampfspez"

    def __init__(self, spalte, behinderung):
        Kampftechnik.__init__(self, spalte, behinderung)
        self.basis = False

    def __repr__(self):
        return "Spezialkampftechnik" + Kampftechnik.__repr__(self)

class Basiskampftechnik(Kampftechnik):
    yaml_tag = u"!kampfbasis"

    def __init__(self, spalte, behinderung):
        Kampftechnik.__init__(self, spalte, behinderung)
        self.basis = True

    def __repr__(self):
        return "Basiskampftechnik" + Kampftechnik.__repr__(self)



def write_basis(dest, talente, name, varname):
    current = talente[name]
    dest.write(u'\\newcommand{\\' + varname + '}[2]{\\ifcase#1')
    lines = []
    for key in sorted(current):
        talent = current[key]
        if talent.basis:
            eigenschaften = talent.eigenschaften
            # best format string ever
            lines.append(u"\\talent{{#2}}{{{}}}{{{}}}{{{}}}{{{}}}{{{}}}".format(
                key, eigenschaften[0], eigenschaften[1], eigenschaften[2], talent.behinderung))
    dest.write(u"\\or".join(lines).encode('utf-8'))
    dest.write("\\fi}\n\n")

def write_list(dest, talente, name, varname):
    current = talente[name]
    dest.write(u'\\newcommand{\\' + varname + '}{()')
    for key in sorted(current):
        dest.write(u'({})'.format(key.replace(u'ä', u'\\"a').replace(u'ü', u'\\"u').replace(u'ö', u'\\"o').replace(u'Ä', u'\\"A').replace(u'Ü', u'\\"U').replace(u'Ö', u'\\"O')).encode('utf-8'))
    dest.write('}\n\n')

def process_category(dest, talente, category, categoryTrunk):
    write_basis(dest, talente, category, categoryTrunk + 'Basis')
    write_list(dest, talente, category, categoryTrunk + 'Talentliste')

with open('talente.yaml', 'r') as f:
    talente = yaml.load(f)

    with open('talentbogen-extern.tex', 'w') as dest:
        process_category(dest, talente, u'Körperliche Talente', u'Koerper')
        process_category(dest, talente, u'Gesellschaftliche Talente', u'Gesellschaft')
        process_category(dest, talente, u'Naturtalente', u'Natur')
        process_category(dest, talente, u'Wissenstalente', u'Wissen')
        process_category(dest, talente, u'Handwerkliche Talente', u'Handwerk')