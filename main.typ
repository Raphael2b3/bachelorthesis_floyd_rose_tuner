// The project function defines how your document looks.
// It takes your content and some metadata and formats it.
// Go ahead and customize it to your liking!
#set math.equation(numbering: "(1)")
#let project(
  title: "Entwicklung einer Mobilen Applikation zur effizienten Stimmung einer Floyd-Rose-Gitarre",
  subtitle: none,
  author: "Raphael Schütz",
  matrikelnummer: "82832",
  semester: "7",
  erstprüfer: "Prof. Konrad Schöbel",
  zweitprüfer: "Prof. Ulf Schemmert",
  date: "01.03.2026",
  logos: "assets/htwk-logo.png",
  abkürzungsverzeichnis: none,
  abbreviations: (),
  tabellenverzeichnis: none,
  abbildungsverzeichnis: none,
) = {
  // Save heading and body font families in variables.
  let body-font = "Linux Libertine"
  let sans-font = "Inria Sans"

  // Set body font family.
  set text(font: body-font, lang: "de")
  show heading: set text(font: sans-font)
  set heading(numbering: "1.1")

  v(0.2fr)
  align(center)[
    #image(logos, width: 50%)
  ]
  v(5fr)
  align(center)[
    #text(size: 35pt)[*Bachlor Thesis*]
  ]
  v(2fr)
  align(center)[
    #text(size: 25pt)[#title]
  ]
  v(0.5fr)
  align(center)[
    #text(size: 15pt)[#subtitle]
  ]
  v(6fr)
  align(center)[
    #text(size: 15pt)[Name: #author] \
    #text(size: 15pt)[Matrikelnummer: #matrikelnummer] \
    #text(size: 15pt)[Fachsemester: #semester] \
    #text(size: 15pt)[Erstprüfer: #erstprüfer] \
    #text(size: 15pt)[Zweitprüfer: #zweitprüfer] \
    #text(size: 15pt)[Abgabe: #date] \
  ]

  v(2.4fr)
  pagebreak()


  // Table of contents.
  outline(depth: 3)
  pagebreak()

  if abkürzungsverzeichnis == true {
    heading(depth: 1, "Abkürzungsverzeichnis", numbering: none, outlined: false)
    for (abbr, full) in abbreviations [
      *#abbr*: #full \
    ]
    pagebreak()
  } else {}

  if tabellenverzeichnis == true {
    heading(depth: 1, "Tabellenverzeichnis", numbering: none, outlined: false)
    outline(
      title: none,
      target: figure.where(kind: table),
    )
    pagebreak()
  } else {}

  if abbildungsverzeichnis == true {
    heading(depth: 1, "Abbildungsverzeichnis", numbering: none, outlined: false)
    outline(
      title: none,
      target: figure.where(kind: image),
    )
    pagebreak()
  } else {}

  // Main body.
  set par(justify: true)
}
#project()
#let abbreviations = (
  "String": "String",
)

= Motivation

Es gibt ein Problem beim Stimmen von Floyd-Rose-Gitarren. Bei diesen Gitarren wird eine Saite zwischen dem Gitarrenkopf und einer bis zu einem gewissen Grad rotierbaren Brücke gespannt. An der Brücke halten unterhalb des Drehpunkts Federn dagegen, wenn man Saiten einspannt. Die Brücke wird gemeinhin als "Floating Bridge" bezeichnet, weil sie nicht wie herkömmliche Tremolos am Gitarrenkörper aufliegt sondern in der Luft schwebt.

#figure(image("assets/floydrose_frontside_neutral.jpg", height: 20%), caption: [Floyd-Rose-Tremolo Bild])<FRQuer>

Das Floyd-Rose-Tremolo hat einen Hebel, den man ziehen oder drücken kann. Beim Musizieren ändert das den Ton. Auch wenn diese Architektur neue Klänge ermöglicht, erschwert sie das Stimmen der Gitarre erheblich. Beim Stimmen erhöht oder verringert man die Spannung einer Saite, indem man deren Länge verändert. Demnach erhöht oder verringert sich die Auslenkung der Federn, da zum Beispiel bei geringerer Spannung der Saiten auch eine geringere Kraft auf die Federn wirkt. Das Resultat davon ist, dass sich der Winkel des Floyd-Rose-Tremolos verändert. Das führt dazu, dass die anderen Saiten verstimmt werden, wenn man eine Saite stimmt. Es gibt Erfahrungsberichte und Aufzeichnungen, wie man so eine Gitarre effizient stimmen kann. Dabei dauerte das Stimmen 8 Minuten @youtube_floyd_rose_tune2026. In Foren sprachen Nutzer von einer Stimmzeit von bis zu 20-30 Minuten, jenachdem wie Sauber und wieviele Saiten sie Stimmen mussten @ultimateguitar_floydrose_tuning_forum. Ziel der Arbeit ist eine App zu entwickeln, die diesen Stimmvorgang beschleunigt.

= Grundlagen (Physik der Gitarre)

Die Gitarre spannt 6 Saiten zwischen Brücke und Sattel. Die Saiten schwingen in einer bestimmten Frequenz. Beim Stimmen wickelt man die Saite um den Stimmwirbel, sodass sie sich dehnt und die Frequenz ändert. Dass Saiten elastisch sind, wird im folgendem Expriment gezeigt:
#figure(
  image("assets/gitarren_begriffe.png", height: 34%),
  caption: [Begriffe einer Gitarre],
)<figStimmwirbel>

#figure(
  image("assets/stimmwirbel.png", height: 34%),
  caption: [Gitarre Stimmwirbel],
)<figStimmwirbel>

== Experiment: Elastizität von Gitarrensaiten

In diesem Experiment wird untersucht, ob Stahlsaiten elastische Eigenschaften besitzen, vergleichbar mit einem sehr steifen Gummiband. Beim Stimmen der Saite, die im Wesentlichen aus Stahldraht besteht, wird diese um den Stimmwirbel aufgewickelt.

Plausibel wäre, dass sich Stahlsaiten dehnen können. Würde sich die Saite nicht dehnen, müsste sich stattdessen entweder die Brücke verschieben oder der Gitarrenhals elastisch verformen. In beiden Fällen wären die Bünde potenziell nicht mehr an ihrer vorgesehenen relativen Position, was zu Intonationsproblemen führen würde.
Außerdem würden die übrigen Saiten einen Großteil ihrer Spannung verlieren.
Aus der praktischen Erfahrung ist jedoch bekannt, dass herkömmliche Gitarren diese Probleme nicht aufweisen.

Verhält sich jedoch jede Saite näherungsweise wie eine Feder, lässt sich erklären, wie sich die Gesamtspannung auf mehrere Saiten verteilt und weshalb einzelne Saiten unterschiedliche Spannungen aufweisen können.

=== Materialien

- Gitarre mit starrer Brücke (keine Floyd-Rose-Brücke, z. B. Yamaha Pacifica)
- Tesafilm (zur Markierung der Saiten)

=== Durchführung

Zunächst wurde die hohe E-Saite tiefer gestimmt, sodass sie eine deutlich geringere Spannung annahm. Dabei wurde darauf geachtet, dass die Saite weiterhin eine ausreichende Grundspannung besaß.

Anschließend wurden kleine Markierungen (Tesafilm) auf die hohe E-Saite geklebt. Die Markierungen wurden so positioniert, dass ihre Kante jeweils exakt mittig über einem Bund lag. Insgesamt wurden sechs Markierungen in unterschiedlichen Abständen zwischen Sattel und Brücke angebracht.

Zusätzlich wurde auf den übrigen Saiten jeweils eine Kontrollmarkierung auf denselben Bund angebracht. Dies diente als Referenz, um mögliche Verschiebungen infolge des Stimmvorgangs beurteilen zu können. Die Bundstäbe fungierten dabei als feste Referenzpositionen.

Im nächsten Schritt wurde die Spannung der hohen E-Saite erhöht, bis die dem Sattel nächstgelegene Markierung einen deutlich sichtbaren Abstand zum darunterliegenden Bund aufwies. Anschließend wurde untersucht, wie stark sich die übrigen Markierungen relativ zu ihren jeweiligen Referenzbünden verschoben hatten.

In der folgenden Tabelle sind Bilder, die Verschiebungen der Markierungen zeigen.
#{
  let fret-row(bund, img_pac, cap_pac, img_pac_t, cap_pac_t) = (
    [#bund],
    figure(image(img_pac, width: 8.5em), caption: [#cap_pac]),
    figure(image(img_pac_t, width: 8.5em), caption: [#cap_pac_t]),
  )

  set text(size: 8.5pt)


  table(
    columns: (auto, 1fr, 1fr),
    inset: 6pt,
    stroke: 0.5pt,

    table.header([*Bund*], [*Pacifica - Ruhe*], [*Pacifica - Spannung*]),

    ..fret-row(1, "assets/p_1.jpeg", "Bund 1 - Ruhe", "assets/p_1t.jpeg", "Bund 1 - Spannung"),

    ..fret-row(2, "assets/p_2.jpeg", "Bund 2 - Ruhe", "assets/p_2t.jpeg", "Bund 2 - Spannung"),

    ..fret-row(4, "assets/p_4.jpeg", "Bund 4 - Ruhe", "assets/p_4t.jpeg", "Bund 4 - Spannung"),

    ..fret-row(6, "assets/p_6.jpeg", "Bund 6 - Ruhe", "assets/p_6t.jpeg", "Bund 6 - Spannung"),

    ..fret-row(8, "assets/p_8.jpeg", "Bund 8 - Ruhe", "assets/p_8t.jpeg", "Bund 8 - Spannung"),

    ..fret-row(12, "assets/p_12.jpeg", "Bund 12 - Ruhe", "assets/p_12t.jpeg", "Bund 12 - Spannung"),

    ..fret-row(16, "assets/p_16.jpeg", "Bund 16 - Ruhe", "assets/p_16t.jpeg", "Bund 16 - Spannung"),

    ..fret-row(22, "assets/p_22.jpeg", "Bund 22 - Ruhe", "assets/p_22t.jpeg", "Bund 22 - Spannung"),
  )
}
=== Beobachtung

Die Markierungen, die sich näher am Sattel befanden, legten eine deutlich größere Strecke zurück als jene in unmittelbarer Nähe der Brücke. Die beobachtete Verschiebung nahm kontinuierlich vom Sattel in Richtung Brücke ab.

Die Kontrollmarkierungen auf den übrigen Saiten zeigten dagegen keine oder lediglich eine kaum wahrnehmbare Bewegung. Dies spricht dafür, dass die beobachtete Verschiebung nicht durch ein Verformen des Instruments verursacht wurde, sondern auf eine tatsächliche Längenänderung der gespannten Saite zurückzuführen ist. Als die Saite wieder entspannt wurde, waren die Markierungen wieder an ihrer Ausgangsposition. Die Schwingungsfrequenz der Saite war auch wieder dieselbe wie zu Beginn.

=== Fazit

Die Beobachtungen belegen das elastische Verhalten von Gitarrensaiten.
Wird die Spannung durch Aufwickeln am Stimmwirbel erhöht, verschieben sich die aufgeklebten Markierungen entlang der Saite in unterschiedlichem Ausmaß. Markierungen in der Nähe der Brücke, die als nahezu fixer Punkt wirkt, erfahren nur eine sehr geringe Verschiebung, während weiter entfernte Markierungen deutlich stärker wandern. Elastisch bedeutet, dass die Saite eigenständig wieder ihre Ursprungsform annimmt.
Die Saite verhält sich wie eine elastische Feder. Je näher ein Punkt an der fixierten Brücke liegt, desto geringer ist seine Bewegung.
Dies bestätigt, dass sich die Dehnung der Saite über ihre gesamte Länge verteilt, während der Fixpunkt an der Brücke nahezu ortsfest bleibt.


== Physikalisches Model
Im folgenden wird ein physikalisches Model der Gitarre beschrieben, um zu verstehen warum die Floyd-Rose-Gitarre so schwierig zu stimmen ist.

Die Gitarre wird als Funktion betrachtet, die 6 Aufwickelstrecken $arrow(Delta L) = vec(Delta L_1, dots.v, Delta L_i, dots.v, Delta L_6)$ auf einen Frequenzvektor $arrow(f) = vec(f_1, dots.v, f_i, dots.v, f_6)$ abbildet
$arrow(Delta L) -> arrow(f)$, wobei jede komponente zu einer Saite gehört. Beim Stimmen muss $arrow(Delta L)$ so gewählt werden, dass genau die gewünschten Frequenzen erreicht werden.
Das Ziel ist die Funktion $f(arrow(Delta L))$ zu bestimmen.
Der Zusammenhang zwischen effektiver Saitenlänge $L_(S,i)$, Zugkraft $F_(S,i)$,
linearer Massendichte $mu_i$ und Frequenz $f_i$ wird durch das Mersennesche Gesetz beschrieben
@wiki_mersennes_laws:

$
  f_i = 1 / (2 L_(S,i)) sqrt(F_(S,i) / mu_i)
$<eqMersenne>

Zunächst wird die Saitenkraft $F_(S,i)$ als Funktion der Aufwickelstrecken $arrow(Delta L)$ bestimmt. Die Kraft die auf die Saite wirkt, wird durch das Hooksche Gesetz beschrieben @wiki_hookes_law:

$ F_(S,i) = (L_(S,i) - L_(0S,i)) dot k_(S,i) $<eqSaitenkraft>

$L_(0S,i)$ beschreibt die unbelastete Saitenlänge im Abschnitt zwischen Sattel und Brücke. Diese Länge wird durch die Aufwickelstrecke $Delta L_i$ beeinflusst. $L'_(0S,i)$ sei die initiale unbelastete Saitenlänge.

$
  L_(0S,i) = L'_(0S,i) - Delta L_i
$<eqUnbelasteteSaitenlänge>


#figure(
  image("assets/FloydRoseQuer.png"),
  caption: [Floyd-Rose-Model Quer],
)<FRMQuer>

#figure(image("assets/floydrose_backside_neutral.jpg", height: 20%), caption: [Tremolofedern])<FRFedern>


In @FRQuer, @FRMQuer und @FRFedern ist zusehen, wie die Brücke die Tremolofedern und die Saiten über einen Drehmoment koppelt.  Die Tremolofedern dienen unterhalb der Brücke als Gegenkraft zu der Saitenspannung.


#grid(
  columns: 2,
  inset: 6pt,
  grid.cell([
    #figure(
      image("assets/FlyodRoseTop.png"),
      caption: [Floyd-Rose-Model Draufsicht],
    ) <FRMTop>
  ]),
  grid.cell([
    #figure(
      image("assets/FRrealTop.png"),
      caption: [Floyd-Rose Draufsicht],
    )<FRTop>
  ]),
)


In der Realität hat jede Saite ihre eigene Saitelänge, wie in @FRMTop und @FRTop zu sehen ist. Sie variieren zwar nur minimal haben aber einen Einfluss auf die rotatorische Projektion der Kräfte.

Die Brücke wird als starrer, gewinkelter Hebel betrachtet, siehe @FRMQuer.
Die Drehachse liege im Koordinatenursprung.
Die Vektoren $arrow(h_hat(F))$ (Hebelarm der Feder) und $arrow(h_(S,i))$ (Hebelarm der Saite i)
schließen konstruktionsbedingt einen konstanten Winkel $alpha_i$ ein.
Die Beträge $h_hat(F)$ und $h_(S,i)$ sind systemspezifische Konstanten. Jede Saite erhält seinen eigenen Hebelarm $arrow(h_(S,i))$, um den aufbau wie in @FRTop und @FRMTop korrekt zu modellieren. Die Tremolofedern haben nur einen Hebelarm $arrow(h_hat(F))$ in diesem Modell.

Es sei
$
  arrow(h_hat(F))(beta) = h_hat(F) vec(cos(beta), sin(beta))
$

Dann folgt

$
  arrow(h_(S,i))(beta) = h_(S,i) vec(cos(beta+alpha_i), sin(beta+alpha_i))
$


Sei $arrow(P_S)$ die konstante Position des Sattels.
Die effektive Saitenlänge und Tremolofederlänge ergeben sich zu

$
  L_(S,i) (beta) = abs(arrow(h_(S,i))(beta) - arrow(P_S))
$ <eqSaitenlänge>

$
  L_hat(F) (beta) = abs(arrow(h_hat(F))(beta) - arrow(P_hat(F)))
$ <eqTremolofederlänge>

Nun soll $beta$ bestimmt werden, welcher sich aus dem Kräftegleichgewicht und der darausfolgenden Hebelposition ergibt. Nach den Gesetzen der Statik trägt ausschließlich der zur jeweiligen Hebelarmrichtung orthogonale Kraftanteil zum Drehmoment bei @hebel_wikipedia.
Im stationären Gleichgewicht gilt das Drehmomentgleichgewicht:

$
  sum^6_(i=1) F_(S,i, bot h_(S,i)) dot h_(S,i) = F_(hat(F) bot h_hat(F)) dot h_hat(F)
$ <eqBrückenkraftgleichgewicht>

Dabei bezeichnen $F_(S,i, bot h_(S,i))$ und  $F_(hat(F) bot h_hat(F))$ jeweils die Anteile der Kräfte
$arrow(F_(S,i))$ und $arrow(F_hat(F))$, die orthogonal zu den Hebelarmen $arrow(h_(S,i))$ und $arrow(h_hat(F))$ wirken. Auf der linken Seite von @eqBrückenkraftgleichgewicht müssen die Kräfte der 6 Saiten aufaddiert werden, da sich die Kräfte parallelgeschalteter Federn addieren @leifiphysik_kombination_federn.

Zunächst wird der Richtungsvektor von $F_(S,i)$, $h_(S,i)$, $F_hat(F)$ und $h_hat(F)$ normiert, wobei $P_hat(F)$ der Punkt ist, an dem die Tremolofeder an der Gitarre befestigt ist.

$
  arrow(e_F_(S,i)) = (arrow(P_S) - arrow(h_(S,i))) / abs(arrow(P_S) - arrow(h_(S,i)))
$
$
  arrow(e_h_(S,i)) = vec(cos(beta+alpha_i), sin(beta+alpha_i))
$
$
  arrow(e_F_hat(F)) = (arrow(P_hat(F)) - arrow(h_hat(F))) / abs(arrow(P_hat(F)) - arrow(h_hat(F)))
$
$
  arrow(e_h_hat(F)) = vec(cos(beta), sin(beta))
$
Aus der orthogonalen Projektion eines Vektors $arrow(a)$ bezüglich eines Vektors $arrow(b)$ folgt @technikermathe_orthogonale_zerlegung_vektoren:

$
  F_(S,i bot h_(S,i))
  = F_(S,i) dot sqrt(1 - (arrow(e_F_(S,i)) dot arrow(e_h_(S,i)))^2)
$
$
  = F_(S,i) dot sin(angle.arc(arrow(e_F_(S,i)), arrow(e_h_(S,i))))
$

Analog ergibt sich für die Tremolofeder:
$
  F_(hat(F), bot h_hat(F))
  = F_hat(F) dot sqrt(1 - (arrow(e_F_hat(F)) dot arrow(e_h_hat(F)))^2)
$
$
  = F_hat(F) dot sin(angle.arc(arrow(e_F_hat(F)), arrow(e_h_hat(F))))
$


Das Kräftegleichgewicht lässt sich damit schreiben als:

$
  sum^6_(i=1) F_(S,i) sin(angle.arc(arrow(e_F_(S,i)), arrow(e_h_(S,i)))) dot h_(S,i) = F_(hat(F)) sin(angle.arc(arrow(e_F_hat(F)), arrow(e_h_hat(F)))) dot h_hat(F)
$ <eqBrückenkraftgleichgewichtMitSinus>

Der nächste Schritt wäre, diesen Ausdruck nach $beta(arrow(Delta L))$ umzustellen, um die Hebelposition zu bestimmen. Allerdings ist dies nicht analytisch möglich, da $beta$ in den Sinusfunktionen und den Hebelarmvektoren auf beiden Seiten der Gleichung vorkommt. Es liegt ein nichtlineares Gleichungssystem vor, das numerisch gelöst werden muss.

Bringt man sie in die Form einer Nullstellengleichung, erhält man

$
  0 = g(beta; arrow(Delta L)) = sum^6_(i=1) F_(S,i) sin(angle.arc(arrow(e_F_(S,i)), arrow(e_h_(S,i)))) dot h_(S,i) - F_(hat(F)) sin(angle.arc(arrow(e_F_hat(F)), arrow(e_h_hat(F)))) dot h_hat(F)
$

Damit liegt ein eindimensionales nichtlineares Optimierungs- bzw. Nullstellenproblem vor, mit dem sich der Rotationswinkel $beta$ numerisch bestimmen lässt.

Aus dem so berechneten Winkel ergeben sich transitiv die abhängigen Größen
$h_(S,i) (beta)$, $L_(S,i)(beta)$ und $F_(S,i) (arrow(Delta L))$.

$mu_i$ ist von der Aufwickelstrecke $arrow(Delta L)$ abhängig.
Im Allgemeinen gilt für Saite $i$:

$
  mu_i = m_i / L_"S,i,Total"
$

Dabei bezeichnet $m_i$ die Gesamtmasse der Saite $i$ und $L_"S,i,Total"$ die Gesamtlänge der Saite.
Wird die Saite aufgezogen, bewegt sich die Brücke um eine Strecke $Delta h$ in Richtung Sattel.
$
  L_"S,i,Total" (arrow(Delta L)) = ???
$

Die lineare Massendichte ergibt sich somit zu:

$
  mu_i (arrow(Delta L)) = m_i/(???)
$

Darauf aufbauend lässt sich eine Abbildung definieren, die die Aufwickelstrecke jeder Saite auf einen Frequenzvektor abbildet:

$
  f_i (arrow(Delta L)) =
  1 / (2 dot L_(S,i) (arrow(Delta L)))
  sqrt((F_"S,i" (arrow(Delta L)) )/ (mu_i (arrow(Delta L))))
$


=== Fazit
Es wird ersichtlich, dass die Aufwickelstrecken der Saiten die Frequenzen aller Saiten beeinflussen. Dass erklärt, warum das Stimmen einer Floyd-Rose-Gitarre so schwierig ist.

Beim Stimmen werden die Aufwickelstrecken nur in kleinen Schritten verändert. In diesem Fall verhält sich das System näherungsweise linear, da die Taylor-Approximation für sehr kleine Änderungen gilt. Da das System physikalisch ist, können wir das System als stetig betrachten.

== Experiment: Nachweis Linearität

Diese Linearität soll nun experimentell überprüft werden. Hierbei werden die Frequenzänderungen der Saiten gemessen, wenn eine andere Saite verstimmt wird.

=== Vorgehensweise
Zunächst wird jede Saite in eine Ausgangsposition gebracht. Die Ausgangsfrequenzen der Saiten werden zunächst in Hertz gemessen.
Anschließend wird jeweils eine Saite um ein beliebiges $Delta$ (in Hertz) verstimmt. Dieses $Delta$ wird so gewählt, dass die Verstimmung deutlich hörbar ist. Jede Saite wird in vier Schritten nach oben und unten verstimmt. Für jeden Schritt wird die Frequenz aller anderen Saiten gemessen.

=== Ziel

Das Ziel des Experiments ist es zu beobachten, ob das System
- hinreichend linear ist
- elastisch ist.

Elastizität bedeutet hier, dass die Frequenz einer Saite wieder in ihren Ausgangszustand zurückkehrt, sobald die Saite selbst wieder in die Ausgangslage gebracht wird. Um dies zu überprüfen, werden nach allen Verstimmungsschritten die Endfrequenzen mit den Anfangswerten verglichen.

Zur Frequenzmessung wird ein Python-Programm eingesetzt, das mithilfe der Fourier-Transformation die Grundfrequenzen bestimmt. Die Visualisierung erfolgt ebenfalls mit Python und der Bibliothek matplotlib.pyplot.

Insgesamt werden 324 gelabelte Audio-Samples aufgenommen:

- Es gibt 6 Saiten,
- jede Saite beeinflusst alle 6 Saiten,
- jede Saite wird dabei in 4 Schritten nach oben und 4 Schritte nach unten verstimmt,
- hinzu kommt noch die Ausgangsposition.
Damit ergibt sich die Anzahl der Messungen zu
$324 = 6 dot 6 dot (4 dot 2+1)$.

=== Frequenzmessung

Die Audio-Samples werden mit Hilfe der Fourier Transformation in den Frequenzbereich transformiert. Die Frequenz mit der höchsten Amplitude wird als die Frequenz der Saite angenommen.
Der Python Code um von einer Audio-Datei die Frequenz zu erhalten ist im folgenden definiert:

```py
import numpy as np
from scipy.fftpack import rfft
from scipy.io import wavfile
from scipy.signal import find_peaks
import matplotlib.pyplot as plt
from ipywidgets import HBox, VBox, interactive, Layout, Checkbox, fixed
import random
from sklearn.linear_model import LinearRegression

def get_samples(filepath):
    fs, data = wavfile.read(filepath)  # Load the data
    if len(data.shape) > 1:  # Stereo → Mono
        data = data.mean(axis=1)
    return data, fs

def get_peak_frequency(spectrum, samplerate, min_prominence=1000):
    # Betragsspektrum
    magnitude = np.abs(spectrum)
    # Peaks finden (optional: Mindestprominenz gegen Rauschen)
    peaks, _ = find_peaks(magnitude, prominence=min_prominence)
    if len(peaks) == 0:
        return None  # Falls keine Peaks erkannt werden
    # Index des höchsten Peaks
    peak_idx = peaks[np.argmax(magnitude[peaks])]
    # Frequenz berechnen
    frequency = peak_idx * (samplerate / (2 * len(spectrum)))
    return frequency

def get_frequency_from_file(filepath, min_prominence=1000):
    samples, samplerate = get_samples(filepath)
    spectrum = rfft(samples)
    return get_peak_frequency(spectrum, samplerate, min_prominence=min_prominence)
```

=== Visualisierung der Messdaten

Die Visualisierung zeigt die Frequenz der Saiten in Abhängigkeit von der Verstimmung. Zum Visualisieren wird Matplotlib und IPyWidgets verwendet.
Die Daten zum Visualisieren werden wie folgt strukturiert:

```json
data = {
    'E2': {                              // The first key represents the String that is detuned
        'E2': [200Hz,220Hz,...,330Hz],                          // The second key represents the string on which the impact is measured
                                         // The Value is a List of the length 8. on Index 0 is the measurement where the detuned string was tuned the lowest.
        'D3': [340Hz,330Hz,...,300Hz]),
        ...,
        'E4': [...])
    },
    ...
    'E4': {
        'E2': [...]),
        'A2': [...]),
        ...,
        'E4': [...])
    }
}
```
Die Namen der Saiten sind wie folgt definiert:
1. E2
2. A2
3. D3
4. G3
5. B3
6. E4

Das folgende Programm ermöglicht es uns die Daten zu visualisieren. Es gibt 6 Abbildungen mit jewails 6 Plots. Jede Abbildung zeigt wie sich alle Saiten verstimmen, wenn sich eine andere Saite verändert. Pro Abbildung wird eine Checkbox für jede Saite erstellt, die es uns ermöglicht, die Daten für jede Saite einzeln anzuzeigen. Da interessant ist, ob die Verstimmung logarithmisch ist, wird die Änderung der Frequenz in Cent und in Hz dargestellt.

Im Folgenden werden erstmal zufällige Messdaten zum testen der Visualisierung generiert:

```python
nStrings = 6
steps = 4
step_range = range(-steps, steps + 1)
strings = ["E2", "A2", "D3", "G3", "B3", "E4"]
# Verstimmung jeder anderen seite für jede Saite für alle Verstimmungsschritte
example_dataset = {  # Dummy Data
    string: {other_string: np.array([400 + (-_ * random.random() if other_string != string else _) for _ in step_range])
             for other_string in strings}
    for string in strings
}

def visualisation(df, string, label, **args):
    for other_string in strings:
        if other_string in args.keys() and args[other_string]:
            ## Lineare Regression
            x = df[string][string]
            y = df[string][other_string]
            #m,b = np.polyfit(x, y, 1)
            #plt.plot(x, m*x+b, label=f"Linear Fit {m}x+{b} {other_string}")
            plt.plot(df[string][string], df[string][other_string], label=other_string)
    plt.title("Impact on String when detuning String " + string)
    plt.xlabel(f"Detuning of String {string} in {label}")
    plt.ylabel(f"Frequency of other Strings in {label}")
     # Koordinatengitter hinzufügen
    plt.grid(True)
    plt.legend()

def visualize_all(data, label): # Adds Checkboxes for every Sample
    widget_list = []
    for string in strings:
        checkboxes = {string: Checkbox(value=True, label=string, indent=False) for string in strings}
        widget = interactive(visualisation, df=fixed(data), string=fixed(string), label=fixed(label), **checkboxes)
        controls = HBox(widget.children[:-1])  # Horizontale Box für die Checkboxes
        output = widget.children[-1]
        w = VBox([controls, output], layout=Layout(margin="10px"))
        widget_list.append(w)
    row1 = HBox(widget_list[:3])
    row2 = HBox(widget_list[3:])
    output = VBox([row1, row2])
    display(output)
```

=== Durchführung
```
Die Audio-Dateien sind im Ordner `audio` zu finden.
Die Ordnerstruktur ist wie folgt:


    audio/<variable_saite>/<beeinflusste_saite>/<verstimmungsschritt>.wav

    audio
    ├── E2 # Ändernde Saite
      ├── E2 # Beinflusste Saite
        ├─── -4.wav
        ├─── ...
        ├─── 4.wav
      ├─── ...
      ├─── E4
    ├── ...
    ├── E4

```
=== Setup
Die Gitarre wird per Klinkenkabel an eine Audio-Interface-Karte angeschlossen und mit einer Abtastrate von 44,1 kHz aufgenommen. Die Abbildung zeigt die Positionierung der Gitarre, die so gewählt wurde, dass sich der Hals nicht verzieht und dadurch den Ton beeinflusst. Die Gitarre wird am Stimmwirbel verstimmt, nicht am Feinstimmer an der Brücke.


#figure(image("assets/setup.jpg"), caption: [Setup der Aufnahme])<figSetup>

Die Aufnahmen erfolgen mit der Digital Audio Workstation (DAW) Cubase. Dabei wird in Mono, mit 16 Bit und 44,1 kHz aufgenommen. Zusätzlich wird das in Cubase integrierte Stimmgerät genutzt, um die Frequenz jeder Saite vor jedem Durchgang erneut exakt in die Ausgangsposition zu bringen.


#figure(
  image("assets/digital_setup.png"),
  caption: [Screenshot von Cubase mit Stimmgerät und integriertem Frequenzmessgerät],
)<figCubase>

Jeder Aufnahmeblock enthält die Roh-Audiodaten aller Saiten der Gitarre (E2, A2, D3, G3, B3 und E4). Die Saiten werden in dieser Reihenfolge gespielt. Die Färbung der Blöcke in der DAW visualisiert die Stärke und Richtung der Verstimmung:

- Rottöne → Verstimmung zu tieferen Frequenzen,
- Blautöne → Verstimmung zu höheren Frequenzen.

Jede Zeile in der Aufnahme entspricht einer Saite und einer Verstimmungsrichtung. Von oben nach unten ergibt sich die Reihenfolge:
E2 nach oben, E2 nach unten, A2 nach oben, A2 nach unten, …, E4 nach oben, E4 nach unten.

Im Anschluss werden die einzelnen Audioblöcke so zugeschnitten, dass Transienten und das Ausklingen der Saite entfernt werden. Transienten sind kurze, perkussive Geräusche mit hohem Pegel, die beim Anschlag entstehen und die Frequenzanalyse verfälschen würden.


#figure(
  image("assets/cutted_audio.png"),
  caption: [Screenshot von Cubase mit zugeschnittenen Samples],
)<figCuttedAudio>

Jeder zugeschnittene Block wird einzeln exportiert und in den entsprechenden Ordner der oben beschriebenen Struktur verschoben.

=== Clean Up
Da von dem oben geschriebenen Python-Programm in manchen Aufnahmen die Obertöne der Saite fälschlicherweise als Ton erkannt wurden, werden die Samples noch einmal gefiltert.
Die folgende Abbildung zeigt eine Konsolenausgabe von dem Problem.

#figure(
  image("assets/need_to_clean_data.png"),
  caption: [Screenshot der Zeigt das Obertöne erkannt werden statt Grundfrequenzen],
)<figNeedToCleanData>
Der Screenshot zeigt, dass nicht die Grundfrequenz als solche erkannt wird, sondern teilweise Obertöne als Grundfrequenz erkannt werden. \

Die automatische Auswahl des Peaks anhand einer erwarteten Frequenz ist problematisch, da die Grundfrequenz einer Saite variieren kann (z.B. durch Verstimmen oder unterschiedliche Gitarrenstimmungen). Wird die Saite stark von einem Referenzwert abweichen, besteht die Gefahr, dass der falsche Peak erkannt wird. Eine explizite Übergabe der erwarteten Frequenz für jedes Sample wäre möglich, jedoch aufwendig und nicht praktikabel für die allgemeine Analyse. Deshalb wird für jede Saite ein Bandpassfilter erstellt, der die Obertöne reduziert.

Die folgenden Abbildungen dienten ursprünglich lediglich der Veranschaulichung der Filter und nicht der Spektren des Klanges; ein eventuelles Fehlen der Spektren beeinträchtigt daher die Aussagekraft der Darstellung nicht.

=== Bandpassfilter
#grid(
  columns: 2,
  inset: 6pt,

  grid.cell([
    #figure(
      image("assets/bandpass_e2.png"),
      caption: [Bandpass für E2],
    )<figBandpassE2>
  ]),
  grid.cell([
    #figure(
      image("assets/bandpass_a2.png"),
      caption: [Bandpass für A2],
    )<figBandpassA2>
  ]),

  grid.cell([
    #figure(
      image("assets/bandpass_d3.png"),
      caption: [Bandpass für D3],
    )<figBandpassD3>
  ]),
  grid.cell([
    #figure(
      image("assets/bandpass_g3.png"),
      caption: [Bandpass für G3],
    )<figBandpassG3>
  ]),

  grid.cell([
    #figure(
      image("assets/bandpass_b3.png"),
      caption: [Bandpass für B3],
    )<figBandpassB3>
  ]),
  grid.cell([
    #figure(
      image("assets/bandpass_e4.png"),
      caption: [Bandpass für E4],
    )<figBandpassE4>
  ]),
)
=== Laden der Daten
Im folgenden Script werden die gesamten Audio-Samples geladen, um sie zu verarbeiten und zu visualisieren. Es wird das oben spezifizierte Datenformat zum Speichern der Daten genutzt.

- Dimensionen:
  - 0: `changing_string`
  - 1: `impacted string`
  - 2: Verstimmungsschritt
- Eintrag = `frequency`.

```python
# Experiment
measured_data = {}
filenames = [f"{i}.wav" for i in step_range]
counter = 0
for changing_string in strings:
    for impacted_string in strings:
        #f0 = get_frequency_from_file(f"audio/{changing_string}/{impacted_string}/0.wav")

        for filename in filenames:
            frequency = get_frequency_from_file(f"audio/{changing_string}/{impacted_string}/{filename}")

            print(
                f"Saite: {changing_string}, Beeinflusste Saite: {impacted_string}, Verstimmungsschritt: {filename}, Frequenz: {frequency}")
            counter+=1
            if changing_string not in measured_data:
                measured_data[changing_string] = {}

            if impacted_string not in measured_data[changing_string]:
                measured_data[changing_string][impacted_string] = []

            measured_data[changing_string][impacted_string].append(frequency)
counter
```

=== Aggregierung der Daten
Gemessen wurden die tatsächlichen Frequenzen jeder Saite und wie sie sich in Abhängigkeit der Veränderung jeder anderen Saite ändern. Für unsere Analyse interessiert uns jedoch vor allem das Maß dieser Änderung. Daher werden alle Messwerte mit ihren jeweiligen Ausgangswerten verglichen - sowohl in Cent als auch in Hertz - um die Frequenzänderungen anschaulich darzustellen.

```python

hz_changes = {  # Dummy Data
    string: {other_string: np.array([float(0) for _ in step_range]) for other_string in strings}
    for string in strings
}
cent_changes = hz_changes.copy()

for changing_string in strings:
    for impacted_string in strings:
        inital_value = measured_data[changing_string][impacted_string][steps]
        for i in range(steps * 2 + 1):  # -4 bis 4
            cent_changes[changing_string][impacted_string][i] = frequency_difference_to_cent(
                measured_data[changing_string][impacted_string][i], inital_value)
            hz_changes[changing_string][impacted_string][i] = measured_data[changing_string][impacted_string][i] - inital_value

```

=== Visualiserung der Daten

=== Diskussion der Ergebnisse
Das System ist *elastisch*, da Ausgangs- und Endfrequenzen nach jedem Durchgang gleich sind. Während der Durchführung des Experiments fiel auf, dass beim Zurückbringen einer Saite in ihre Ausgangsposition alle anderen Saiten ebenfalls wieder ihre ursprüngliche Frequenz annahmen.

Die Linearität des Systems ist nicht perfekt, aber hinreichend gut für kleine Verstimmungen. Sie lässt sich quantitativ mit dem *Korrelationskoeffizienten nach Bravais-Pearson* zwischen gemessenen und erwarteten Frequenzänderungen jeder Saite bestimmen. Eine hohe Korrelation bestätigt, dass die Annahme einer linearen Beziehung für kleine Änderungen gerechtfertigt ist.

Die Linearität ist wichtig, da sie die Grundlage für die Modellierung als *lineares Gleichungssystem* bildet. Nur dadurch können die Effekte der Verstimmung jeder Saite auf alle anderen Saiten mit einer *Matrix* erfasst und mathematisch gelöst werden.

== Mathematische Lösung
Die Frequenzen der Saiten können als *Vektor* dargestellt werden:

$
  arrow(f_0) = vec(f_"E2", f_"A2", f_"D3", f_"G3", f_"B3", f_"E4")
$
$
  C = mat(
    1, c_(12), c_(13), c_(14), c_(15), c_(16);
    c_(21), 1, c_(23), c_(24), c_(25), c_(26);
    c_(31), c_(32), 1, c_(34), c_(35), c_(36);
    c_(41), c_(42), c_(43), 1, c_(45), c_(46);
    c_(51), c_(52), c_(53), c_(54), 1, c_(56);
    c_(61), c_(62), c_(63), c_(64), c_(65), 1
  ),
  arrow(g) = vec(hat(f)_"E2", hat(f)_"A2", hat(f)_"D3", hat(f)_"G3", hat(f)_"B3", hat(f)_"E4")
$

- $arrow(f_0)$: Ausgangsfrequenzen der Saiten, gemessen z.B. mit einem digitalen Stimmgerät
- $C$: Verstimmungsmatrix, wobei $c_"ij"$ den *Verstimmungsfaktor* der Saite $i$ angibt, wenn die Saite $j$ um 1Hz verstimmt wird
- $arrow(g)$: Ziel-Frequenzen nach der Verstimmung
Der Vektor

$
  arrow(Delta) = vec(Delta_"E2", Delta_"A2", Delta_"D3", Delta_"G3", Delta_"B3", Delta_"E4")
$

gibt an, um wie viel jede Saite verstimmt werden muss.

Die *effektive Verstimmung* wird durch die Multiplikation mit der Verstimmungsmatrix berechnet:

$
  C dot arrow(Delta) = arrow(Delta)_"effective"
$

Damit die Ziel-Frequenzen $arrow(g)$ erreicht werden, gilt:

$
  arrow(g) = arrow(f_0) + arrow(Delta)_"effective" quad arrow quad arrow(Delta)_"effective" = arrow(g)-arrow(f_0)
$

Um die Eingangsverstimmung $arrow(Delta)$ zu bestimmen, muss das *Inverse der Matrix $C$* gebildet werden:

$
  C dot arrow(Delta) = arrow(Delta)_"effective" quad arrow quad arrow(Delta) = C^(-1) dot arrow(Delta)_"effective"
$

$
  arrow(Delta) = C^(-1) dot (arrow(g)-arrow(f_0))
$

$C^(-1)$ ist die Inverse der Verstimmungsmatrix.

Somit benötigt man für die Berechnung:
1. Ausgangsfrequenzen $arrow(f_0)$
2. Ziel-Frequenzen $arrow(g)$
3. Verstimmungsmatrix $C$
= Verfahrensweise

== Ablauf eines Stimmvorgangs
Um nun eine Gitarre zustimmen, muss zunächst die Verstimmungsmatrix, der zu stimmenden Gitarre ermittelt werden. Dazu muss zunächst die Ausgangslage der Gitarre bestimmt werden. Dann wird die 1. Saite verstimmt und der Einfluss dieser Saite auf die anderen 5. Saiten gemessen. Dann werden die nächsten Saiten nach diesem Schema verstimmt und gemessen. Anhand diesen änderungen wird die Verstimmungsmatrix berechnet. Anschließend wird der Zustand der Gitarre ermittelt und es wird für jede Saite ein delta Frequenz berechnet, um die die Gitarre verstimmt werden muss. Der Nutzer muss dann jede Saite verstimmen sodass die Delta Frequenz 0 ist.

Um das umzusetzen benötigt man ein Verfahren um die Frequenz der Angespielten Saite zu ermitteln.

In der Regel wird auch ein Verfahren benötigt um das Signal zu Filtern sodass es weniger Anfällig für störgeräusche ist.

== Wahl des Verfahrens für die Frequenzanalyse

Für die Implementierung eines Tuners auf mobilen Geräten ist die präzise und effiziente Bestimmung der Grundfrequenz (Fundamental Frequency, F0) entscheidend. Im Folgenden werden gängige Verfahren vorgestellt und hinsichtlich Genauigkeit, Rechenaufwand und Anwendungsbereich bewertet.


=== Autokorrelation
Die Idee der Autokorrelation besteht darin, dass ein Signal mit einer Periode von $tau$, wenn es mit sich selbst gefaltet wird, bei vielfachen von $tau$ maxima aufweisen wird. Wenn man nun den ersten von null verschiedenen x Wert wählt der bei einem Peak ist, hat man mit hoher Wahrscheinlichkeit, das Richtige $Tau$ und mit seinem Inversen die Frequenz des Signals.

$
  r_t(tau) = sum_(j=t+1)^(t+W) x_j x_(j+tau)
$

wo bei $r_t(tau)$ die Autokorrelationsfunktion von der Verzögerung $tau$ berechnet zum Zeitindex $t$ und $W$ ist die Integrationsfenstergröße.@YIN

=== YIN-Algorithmus

Der YIN-Algorithmus ist eine Weiterentwicklung der Autokorrelation. Sie fügt extra Fehlerreduktionsschritte hinzu. So wird zum Beispiel durch die "Difference function" eine Imunität gegenüber schwankenden Amplituden erzeugt und uninteressante $tau$ werden rausgefiltert.@YIN Der Algorithmus wird in vielen Stimmgeräten verwendet.

=== Fourier- und Cepstrum-Analyse

Bei der Fourier-Analyse wird das Signal ins Frequenzspektrum transformiert, um das Spektrum nach der Grundfrequenz zu durchsuchen. Die Cepstrum-Analyse erweitert diesen Ansatz, indem das logarithmierte Spektrum erneut transformiert wird, um periodische Muster zu detektieren. Eine Analyse hat gezeigt, dass Jedoch Fourier-Analysen fehleranfällig sind und eine hohe sampling rate benötigen. @FFT_NEEDS_HIGH_SAMPLING
- *Vorteile:* Robust gegenüber Harmonischen (Cepstrum), gute Integration in digitale Signalverarbeitungssysteme.
- *Nachteile:* Eingeschränkte Genauigkeit bei niedrigen Frequenzen oder verrauschten Signalen.
- *Referenzen:*
  Noll, A. M. (1967). *Cepstrum pitch determination*. J. Acoust. Soc. Am., 41(2), 293-309.

=== Moderne Deep-Learning-Ansätze

Neuronale Netze wie CREPE oder DeepPitch nutzen Convolutional- oder Recurrent Neural Networks, um direkt aus Roh-Audio oder Spektrogrammen die Fundamental-Frequenz vorherzusagen.

- *Vorteile:* Sehr robust bei Polyphonie, Hintergrundgeräuschen und unterschiedlichen Instrumenten.
- *Nachteile:* Hoher Rechenaufwand, Trainingsdaten erforderlich, auf Mobilgeräten ressourcenintensiv.
- *Referenz:*
  Kim, J., & Bello, J. P. (2019). *CREPE: A Convolutional Representation for Pitch Estimation*. ISMIR 2019. [arXiv:1802.06291](https://arxiv.org/abs/1802.06291)


== Filter

1. Filterung durch die Anpassung der Parameter in Frequenzanalyse
2. Bandpass Filter durch FFT

= Software Entwicklung/Implementierung
== User Journeys
== Anforderungen
== Konzeption und Design
== Architektur
== Implementierung
= Evaluation
== Funktionsfähigkeit des Algorithmuses
== Erfüllung der Requirements aus SWE
== Usertests
= Ausblick
== Mehrere Saiten gleichzeitig Messen
== Implementierung für VST und Digital Audio Workstations (Plugin)

= Literatur

Buch- Mobile App Engineering

#bibliography("bib.bib")
