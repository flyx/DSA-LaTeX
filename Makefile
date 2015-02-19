all: release-zip

clean:
	rm -rf release *.zip *.pdf fanpaket

release/dsa:
	mkdir -p release/dsa

release/dsa/fanpaket-setup.ps1: dev/fanpaket-setup.ps1.in dev/fanpaket.yaml release/dsa
	dev/build-fanpaket-setup.py $< dev/fanpaket.yaml $@
release/dsa/fanpaket-setup.sh: dev/fanpaket-setup.sh.in dev/fanpaket.yaml release/dsa
	dev/build-fanpaket-setup.py $< dev/fanpaket.yaml $@
release/dsa/README.html: dev/README-release.md dev/build-readme.py
	dev/build-readme.py $< $@

fanpaket: release/dsa/fanpaket-setup.sh
	sh release/dsa/fanpaket-setup.sh

release-files: $(shell find dev) $(shell find . -name "*.tex") clean release/dsa/fanpaket-setup.sh release/dsa/fanpaket-setup.ps1 release/dsa/README.html fanpaket
	xelatex -output-directory release/dsa dokumentation.tex
	cp dsa.cls dokumentation.tex release/dsa
	cp -r dokumentation-snippets release/dsa
	cd release/dsa && rm -rf *.aux *.log *.out

release-zip: release-files
	cd release && zip -r dsa dsa