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

## Linux

Wie OSX, aber stellt davor sicher, dass ihr `curl` und `unzip` installiert
habt.

 [1]: https://www.tug.org/texlive/acquire-netinstall.html
 [2]: http://www.tug.org/mactex/index.html