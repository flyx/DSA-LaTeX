# LaTeX-Klasse für DSA-Dokumente

## Überblick

Dies ist die Installationsanleitung der DSA-Klasse für das LaTeX-Textsatzsystem.
Die Benutzung der Klasse wird im Dokument `dokumentation.pdf` erläutert.

## TeX-Distribution installieren (sofern nicht vorhanden)

### Windows

Es gibt mehrere TeX-Distributionen für Windows. Ich empfehle TeX Live, einen
Installer gibt es [hier][1]. Lade die Datei `install-tl.exe` von dort herunter
und führe sie aus. Wähle bei den Optionen *Simple install (big)* aus, um alle
benötigten TeX-Pakete zu installieren (Vorsicht, das benötigt mehr als 2GB 
Speicherplatz).

### OSX

Lade den Installer von [hier][2] herunter und führe ihn aus.

### Linux

Dein Paketmanager sollte TeX zur Verfügung stellen, bitte ziehe die
Dokumentation deiner Linux-Distribution zu Rate.

## Fanpaket anpassen

Das Ulisses-Fanpaket, dessen Grafiken die DSA-Klasse benutzt, beinhaltet
Dateien, die Umlaute und Leerzeichen im Dateinamen haben. Es ist umständlich,
derart benannte Dateien in LaTeX zu benutzen, deshalb liegen der DSA-Klasse
Skripte bei, um die Dateien umzubenennen. Die Skripte laden das Fanpaket
selbständig herunter, du musst das also nicht selbst tun.

### Windows

Wähle aus dem Rechtsklickmenü der Datei `fanpaket-setup.ps1` die Option
*Run with PowerShell* aus (wenn du ein deutsches Windows hast, heißt das
irgendwie anders, du wirsts aber schon finden). Falls die PowerShell beim
Öffnen nach Rechten fragt, *Yes* eingeben.

### OSX

Öffnet ein Terminal und führt `fanpaket-setup.sh` aus.

### Linux

Wie OSX, aber stellt davor sicher, dass ihr `curl` und `unzip` installiert
habt.

## Optional: Hintergrundbild für Charakterbögen

Standardmäßig werden Charakterbögen auf weißem Hintergrund ausgegeben. Dies
verbraucht weniger Tinte / Toner beim Drucken. Du kannst deinen Charakterbogen
aber auch mit dem Original-Hintergrundbild versehen (oder auch einem beliebigen
anderen). Die DSA-Klasse sucht nach einem Bild namens `wallpaper.png` im Ordner
`fanpaket`, der im vorherigen Schritt erzeugt wurde.

Das Original-Hintergrundbild lässt sich aus dem Kampfbogen aus Wege des Schwerts,
der Online verfügbar ist, extrahieren. Ihr könnt die PDF-Datei [hier][3]
herunterladen. Zum Extrahieren des Hintergrundbilds benötigt ihr das Tool
`pdfimages`.

### Windows

Es gibt keine offizielle Version von `pdfimages` für Windows, aber eine
inoffizielle kann [hier][4] heruntergeladen werden. Legt `pdfimages.exe` im
selben Ordner wie die PDF-Datei ab, öffnet eine Kommandozeile, navigiert zu dem
Ordner und führt folgendes Kommando aus:

    pdfimages.exe Wege-des-Schwerts_Handouts_fee3.pdf

### OSX

Für OSX gibt es einen GUI-basierten Port, der [hier][5] heruntergeladen werden
kann. Er benötigt X11 - wenn dies nicht verfügbar ist, wird dir OSX einen Link
geben, wo du es herunterladen kannst. Öffne das Programm und ziehe die PDF in
das Fenster, das sich öffnet.

### Linux

`pdfimages` gehört zu der `poppler`-Bibliothek. Konsultiere deinen Paketmanager,
um es zu installieren. Danach kannst du wie auf Windows diesen Befehl ausführen:

    pdfimages Wege-des-Schwerts_Handouts._fee3.pdf

### Umwandlung und Einbindung

Nachdem du das Kommando ausgeführt hast, hast du folgende Datei erstellt:

    Wege-des-Schwerts_Handouts_fee3-001.ppm

Diese kannst du in einem Bildbearbeitungsprogramm wie [GIMP][6] öffnen und als
PNG exportieren. Lege sie als `wallpaper.png` im Ordner `fanpaket` ab. Damit
werden nun alle Charakterbögen mit diesem Hintergrundbild erstellt.

## Benutzung

Lege dein Dokument im selben Ordner an, wo `dsa.cls` liegt, damit LaTeX die
Klasse findet. Alternativ kannst du die Klasse auch entsprechend den
Konventionen deiner TeX-Distribution installieren, konsultiere hierfür die
Dokumentation deiner Distribution.

Die von der Klasse bereitgestellten Funktionen sind in dem Dokument
`dokumentation.pdf` beschrieben.


 [1]: https://www.tug.org/texlive/acquire-netinstall.html
 [2]: http://www.tug.org/mactex/index.html
 [3]: http://www.ulisses-spiele.de/download/468/
 [4]: http://manifestwebdesign.com/2013/01/09/xpdf-and-poppler-utils-on-windows/
 [5]: http://sourceforge.net/projects/pdf-images/
 [6]: http://www.gimp.org