# VM für die Generierung der beiliegenden Dokumente

## Was genau kommt auf mich zu?

Vagrant ist ein Werkzeug, um virtuelle Maschinen reproduzierbar zu erstellen -
das heißt, wenn du diese VM erstellst, hast du nachher genau dieselbe VM wie
ich sie auch bei mir habe. Da eine VM mehrere Gigabyte groß ist, verteile ich
nicht die VM an sich, sondern eine Konfiguration für Vagrant, mit der diese
VM erstellt werden kann.

Der Prozess kann je nach Hardware eine viertel bis halbe Stunde dauern und
zieht ordentlich Leistung von deinem PC. Das muss dich aber nicht abschrecken:
Wenn du dir nur die Dokumente erstellen willst, kannst du die ganze Sache
danach direkt in den Papierkorb werfen. Der Vorteil einer VM ist, dass sie
keine Spuren auf deinem System hinterlässt.

## Warum der Spaß?

Ein grundsätzliches Problem dabei, Dokumente zu generieren, die den Original
DSA-Dokumenten ähnlich sehen, ist das Urheberrecht. Deshalb gibt es im anderen
README zum Beispiel die Anleitung, wie man das Fanpaket herunterlädt und
anpasst, damit dessen Grafiken benutzbar sind: Ich bräuchte eine schriftliche
Genehmigung von Ulisses, um die Dateien selbst mit der Klasse zu verteilen.

Neben dem Fanpaket wird auch das Hintergrundbild benötigt, das, wie im anderen
README schon erwähnt, extrahiert werden muss. Dieses ist von Ulisses nicht zur
Weitergabe freigegeben, das heißt, Dokumente, die damit erzeugt werden, dürfen
nicht im Internet zur Verfügung gestellt werden. Natürlich darf jeder mit den
Dateien privat machen, was er will, und an diesem Punkt setzt diese VM an:

Sie enthält ein umfassendes Skript, das sowohl die ganze TeX-Infrastruktur
einrichtet wie auch das Fanpaket herunterlädt und anpasst und das
Hintergrundbild extrahiert und so umwandelt, dass es verwendet werden kann.
Damit habt ihr, die Benutzer, mit drei einfachen Befehlen und etwas Zeit die
Möglichkeit, die Dokumente zu erstellen, ohne irgendwelches Vorwissen um die
dreckigen Details haben zu müssen.

## Voraussetzungen

Um die VM auf deinem System erstellen zu können, brauchst du:

 * [VirtualBox][1]: VirtualBox Laufzeitumgebung, in der die virtuelle Maschine
   ausgeführt wird. Bei der Installation empfehle ich, die Option 
   „Bridged Networking” zu deaktivieren - die installiert dir nur einen
   unnötigen Netzwerkadapter. Auch USB-Unterstützung brauchst du nicht.
 * [Vagrant][2]: Das Tool, das die virtuelle Maschine zusammenbaut.
 * [PuTTY][3]: Nur Windows-User. Brauchst du, um auf der VM was zu machen.
   Es reicht, `putty.exe` herunterzuladen.

Außerdem wird die Schriftart benötigt, die für die Überschriften benutzt wird.
Diese heißt *Mason* und ist kostenpflichtig, im Internet findet sich allerdings
ein Klon namens *Manson*, der kostenlos heruntergeladen kann (frag Google). Wer
eine andere Schriftart benutzen möchte, kann das natürlich auch tun. Wichtig ist,
dass, bevor du irgendetwas anderes tust, du folgende beiden Dateien in den Ordner
`dsa` legst (dort, wo auch `dsa.cls` liegt):

    MansonRegular.ttf
    MansonBold.ttf

Sie müssen genau so heißen. Die erste sollte die normale Schriftart enthalten,
die zweite die **fette** Variante. **Wenn diese Dateien nicht vorhanden sind,
funktioniert alles nicht!**

## Vorgehen

Der Ordner `dsa` sollte an einer Stelle liegen, wo allermindestens 2GB Speicher
verfügbar sind - so viel braucht die VM.

Die Konfigurationsdateien liegen im Unterordner `vagrant-vm`, navigiere dorthin.
Windows-Nutzer doppelklicken auf `start-vm.bat`. Alle anderen geben in der
Kommandozeile `vagrant up` ein. Nun holst du dir einen Tee/Kaffee/Bier/Tharf
und schaust zu, wie ein Haufen Text an dir vorbeiscrollt. Je nach System kann
die Prozedur eine viertel- bis halbe Stunde dauern. Auf Windows kann es sein,
dass ein Bestätigungsdialog kommt, weil die VM ein virtuelles Netzwerk
einrichtet, damit sie Sachen aus dem Internet laden kann. Das musst du
bestätigen.

Wenn der Vorgang abgeschlossen ist, hast du die virtuelle Maschine laufen, und
sie ist fertig eingerichtet. Die Maschine ist nicht sichtbar, weil sie ohne
grafische Oberfläche läuft (die brauchst du nicht). Du musst dich jetzt per SSH
auf die Maschine verbinden. Auf allem außer Windows geht das mit `vagrant ssh`.

Auf Windows brauchst du PuTTY. Öffne es, gib als Host Name `127.0.0.1` and, als
Port `2222`. Starte es, es wird nach Benutzernamen und Passwort fragen. Gib
beides Mal `vagrant` ein.

Nachdem du auf der Kommandozeile der VM bist, gib folgendes ein:

    `cd /dsa`

Der Ordner `/dsa` ist der `dsa` Ordner, der von innerhalb der VM aus
zugreifbar ist. Um nun beispielsweise das Vertrautendokument zu erstellen,
gib folgendes ein:

    `xelatex vertrautendokument.tex`

Wenn der Prozess durchgelaufen ist, hast du im dsa Ordner ein frisches
`vertrautendokument.pdf` - und einige Abfall-Dateien.

**Wichtig:** Vergiss nicht, nach Benutzung der VM diese wieder
herunterzufahren. Sonst läuft sie im Hintergrund weiter und frisst unnötig
Leistung. Auf Windows kannst du auf `stop-vm.bat` doppelklicken, ansonsten
gibst du `vagrant halt` ein. Die VM wird damit gestoppt, nicht gelöscht. Du
kannst sie jederzeit wieder mit `start-vm.bat` bzw. `vagrant up` starten.
Das zweite Mal wird sie viel schneller oben sein, weil sie ja bereits
eingerichtet ist.

Die VM kann mit einem Doppelklick auf `destroy-vm.bat` bzw. mit
`vagrant destroy` komplett gelöscht werden. Beide Male fragt Vagrant nach,
ob du die Maschine wirklich löschen willst (du musst sie danach ganz neu
bauen!). Mit `y` kann dies bestätigt werden.

  [1]: https://www.virtualbox.org/wiki/Downloads
  [2]: http://www.vagrantup.com/downloads.html
  [3]: http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html