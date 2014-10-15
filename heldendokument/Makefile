# Diese Makefile baut das Heldendokument zusammen. Jede Seite wird zunächst
# als eigenes PDF generiert, aus mehreren Gründen:
#
#  - Man muss nicht bei jeder Änderung alles neu bauen, sondern nur die Seite,
#    an der man Änderungen vorgenommen hat.
#  - Die Eingabefelder funktionieren nicht korrekt, wenn man sie in der
#    landscape-Umgebung benutzt, deshalb muss die Zauberliste auf jeden Fall
#    als extra PDF generiert werden.

### Definition der Quelldateien

COMMON_SRCS=common.tex

PRIMARY_SRCS=frontseite.tex \
             talentbogen.tex \
             kampfbogen.tex \
             ausruestung.tex \
             liturgien.tex \
             zauberliste.tex

CONFIG_SRCS=$(PRIMARY_SRCS:.tex=-konfig.tex)


### Definition generierter Dateien

INTERMEDIATE_PDFS=$(PRIMARY_SRCS:.tex=.pdf)

TARGET=heldendokument.pdf


### Targets zum Bauen der Dokumente

all: $(TARGET)

%.pdf: %.tex %-konfig.tex $(COMMON_SRCS) eingabefelder-extern.tex
	xelatex $<
	rm -rf *.log *.out *.aux

talentbogen-extern.tex: talente.py talente.yaml
	./talente.py

eingabefelder-extern.tex: eingabefelder.py eingabefelder.yaml
	./eingabefelder.py

$(TARGET): $(INTERMEDIATE_PDFS)
	pdfunite $^ $(TARGET)

wallpaper-landscape.png:
	convert /usr/share/texmf/tex/latex/dsa/fanpaket/wallpaper.png -rotate 90 wallpaper-landscape.png

clean:
	rm -f $(INTERMEDIATE_PDFS) heldendokument.pdf talentbogen-extern.tex eingabefelder-extern.tex wallpaper-landscape.png


### Zusätzliche Abhängigkeiten

talentbogen.pdf: talentbogen-extern.tex
liturgien.pdf: misc-macros.tex
ausruestung.pdf: misc-macros.tex
zauberliste.pdf: wallpaper-landscape.png