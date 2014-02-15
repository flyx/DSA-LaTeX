all: release-files

clean:
	rm -rf release *.zip *.pdf fanpaket

release:
	mkdir release

build-scripts: release
	python dev/build-release.py dev release

release/fanpaket-setup.sh: build-scripts

fanpaket: build-scripts
	sh release/fanpaket-setup.sh

.PHONY: build-scripts

release-files: $(shell find dev) $(shell find . -name "*.tex") clean build-scripts fanpaket
	xelatex -output-directory release dokumentation.tex
	xelatex -output-directory release vertrautendokument.tex
	cp dsa.cls release
	cd release && rm -rf *.aux *.log *.out 