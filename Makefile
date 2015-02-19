all: release-zip

clean:
	rm -rf release *.zip *.pdf fanpaket

release/dsa:
	mkdir -p release/dsa

build-scripts: release/dsa
	python dev/build-release.py dev release/dsa

release/dsa/fanpaket-setup.sh: build-scripts

fanpaket: build-scripts
	sh release/dsa/fanpaket-setup.sh

.PHONY: build-scripts

release-files: $(shell find dev) $(shell find . -name "*.tex") clean build-scripts fanpaket
	xelatex -output-directory release/dsa dokumentation.tex
	cp dsa.cls dokumentation.tex release/dsa
	cp -r dokumentation-snippets release/dsa
	cd release/dsa && rm -rf *.aux *.log *.out

release-zip: release-files
	cd release && zip -r dsa dsa