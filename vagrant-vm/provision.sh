#!/bin/sh

# Tools
apt-get update
apt-get install -y --no-install-recommends texlive texlive-xetex texlive-latex-extra texlive-lang-german pgf lmodern
apt-get install -y poppler-utils imagemagick
apt-get install -y curl unzip

# irgendwas braucht das
locale-gen de_DE.UTF-8

# Fanpaket
mkdir -p /tmp/dsa && cd /tmp/dsa
if [ ! -f "/dsa/fanpaket-setup.sh" ]
then
    # Nicht Release, sondern Git-Repo: Skript muss erst generiert werden.
    apt-get install -y python2.7 python-pystache python-yaml python-markdown
    python /dsa/dev/build-release.py /dsa/dev /dsa 
fi
sh /dsa/fanpaket-setup.sh
mkdir -p /usr/share/texmf/tex/latex/dsa
cp /dsa/dsa.cls /usr/share/texmf/tex/latex/dsa
mv fanpaket /usr/share/texmf/tex/latex/dsa

# Charakterbogen-Hintergrund
curl -o wds.pdf http://www.ulisses-spiele.de/download/468/
pdfimages -f 2 -l 2 wds.pdf wds
convert wds-000.ppm /usr/share/texmf/tex/latex/dsa/fanpaket/wallpaper.png

# PDF Forms Support
curl -o acrotex_pack.zip http://www.math.uakron.edu/~dpstory/acrotex/acrotex_pack.zip
unzip acrotex_pack.zip
cd acrotex && latex acrotex.ins
mkdir -p /usr/share/texmf/tex/latex/acrotex
cp *.def *.sty *.cfg /usr/share/texmf/tex/latex/acrotex
texhash

# Fonts
mkdir -p /usr/local/share/fonts && cd /usr/local/share/fonts
curl -o GaramondNo8-Bold-Italic.ttf http://garamond.org/urw/GaramondNo8-Bold-Italic.ttf
curl -o GaramondNo8-Bold.ttf http://garamond.org/urw/GaramondNo8-Bold.ttf
curl -o GaramondNo8-Italic.ttf http://garamond.org/urw/GaramondNo8-Italic.ttf
curl -o GaramondNo8-Regular.ttf http://garamond.org/urw/GaramondNo8-Regular.ttf
cp /dsa/MansonRegular.ttf .
cp /dsa/MansonBold.ttf .
fc-cache -fv
