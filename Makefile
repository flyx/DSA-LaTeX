FANPAKET_RENAMES := \
 fanpaket/balken-links.png \
 fanpaket/balken-rechts.png \
 fanpaket/symbol-balken-links.png \
 fanpaket/symbol-balken-rechts.png \
 fanpaket/logo-fanprodukt.png \
 fanpaket/logo-fanprojekt.png \
 fanpaket/kasten-achtelseiter.png \
 fanpaket/kasten-viertelseiter.png \
 fanpaket/kasten-halbseiter.png

clean:
	rm -rf *.pdf fanpaket

fanpaket:
	curl -o tmp.zip http://www.ulisses-spiele.de/download/889/
	unzip tmp.zip
	rm tmp.zip
	mv Das\ Schwarze\ Auge\ -\ Fanpaket* fanpaket

fanpaket/balken-links.png: fanpaket
	-mv fanpaket/Balken\ -\ Seite\ -\ links.png $@
	touch $@

fanpaket/balken-rechts.png: fanpaket
	-mv fanpaket/Balken\ -\ Seite\ -\ rechts.png $@
	touch $@

fanpaket/symbol-balken-links.png: fanpaket
	-mv fanpaket/Balken\ -\ Seite\ \(Symbole\)\ -\ links.png $@
	touch $@

fanpaket/symbol-balken-rechts.png: fanpaket
	-mv fanpaket/Balken\ -\ Seite\ \(Symbole\)\ -\ rechts.png $@
	touch $@

fanpaket/logo-fanprodukt.png: fanpaket
	-mv fanpaket/Logo\ -\ Fanprodukt.png $@
	touch $@

fanpaket/logo-fanprojekt.png: fanpaket
	-mv fanpaket/Logo\ -\ Fanprojekt.png $@
	touch $@

fanpaket/kasten-halbseiter.png: fanpaket
	-mv fanpaket/Kasten\ -\ Halbseiter.png $@
	touch $@

fanpaket/kasten-viertelseiter.png: fanpaket
	-mv fanpaket/Kasten\ -\ Viertelseiter.png $@
	touch $@

fanpaket/kasten-achtelseiter.png: fanpaket
	-mv fanpaket/Kasten\ -\ Achtelseiter.png $@
	touch $@

fanpaket-anpassung: ${FANPAKET_RENAMES}

.PHONY: fanpaket-anpassung clean

%.pdf: %.tex fanpaket-anpassung dsa.cls
	xelatex $<
	xelatex $<
	rm -rf *.aux *.log *.out
