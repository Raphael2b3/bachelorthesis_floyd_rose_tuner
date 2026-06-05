#let project(
  title: "Entwicklung einer Mobilen Applikation zur effizienten Stimmung einer\nFloyd-Rose-Gitarre",
  subtitle: none,
  author: "Raphael Schütz",
  matrikelnummer: "82832",
  semester: "8",
  erstprüfer: "Prof. Konrad Schöbel",
  zweitprüfer: "Prof. Ulf Schemmert",
  date: "16.06.2026",
  logos: "assets/htwk-logo.png",
  abbildungsverzeichnis: true,
) = {
  v(0.2fr)
  align(center)[
    #image(logos, width: 50%)
  ]
  v(5fr)
  align(center)[
    #text(size: 35pt)[*Bachelorarbeit*]
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
  [#v(1em)
    #align(center)[
      #text(weight: "bold", size: 14pt)[Zusammenfassung]
    ]

    Das Stimmen einer Gitarre mit Floyd-Rose-Tremolo-System ist aufgrund der mechanischen Kopplung aller Saiten über die rotierbare Brücke ein zeitaufwändiger und iterativer Prozess. Erfahrungsberichte sprechen von Stimmzeiten zwischen 8 und 30 Minuten.

    Ziel dieser Bachelorarbeit war die Entwicklung einer mobilen Applikation, die diesen Vorgang durch ein mathematisches Modell der Brückenkopplung signifikant beschleunigt. Hierzu wurde zunächst ein physikalisches Modell der Floyd-Rose-Gitarre erstellt, das den nichtlinearen Zusammenhang zwischen Saitenspannung, Brückenposition und Schwingungsfrequenz beschreibt. Für kleine Verstimmungen konnte dieses System durch eine gitarrenspezifische *Verstimmungsmatrix* hinreichend genau linearisiert werden. Die Inverse dieser Matrix ermöglicht die direkte Berechnung der erforderlichen Verstimmungsbeträge jeder Saite.

    Auf Basis dieses Modells wurde eine plattformübergreifende Flutter-Applikation für Android und iOS entwickelt. Diese unterstützt die einmalige Kalibrierung des Instruments, die Messung des aktuellen Stimmzustands mittels YIN-Algorithmus sowie einen geführten Stimmvorgang mit berechneten Zielfrequenzen.

    Nutzertests zeigten, dass die Gitarre unter kontrollierten akustischen Bedingungen erfolgreich und deutlich schneller gestimmt werden konnte als mit herkömmlichen Methoden. Die Grenzen der aktuellen Implementierung liegen vor allem in der Robustheit der Fundamentalfrequenzerkennung in lauten Umgebungen und starken Obertönen.

    Die Arbeit belegt, dass das Kopplungsverhalten von Floyd-Rose-Gitarren durch eine kalibrierte lineare Matrix hinreichend genau modelliert und für die praktische Unterstützung des Stimmprozesses genutzt werden kann.

    #v(0.8em)
    *Schlagwörter:* Floyd-Rose, Tremolo, Stimmgerät, Signalverarbeitung, Mobile App, Lineare Approximation, Gitarrentechnik]
  pagebreak()
  [#v(1.5em)
    #align(center)[
      #text(weight: "bold", size: 14pt)[Abstract]
    ]

    Tuning a guitar with a Floyd Rose tremolo system is a time-consuming and iterative process due to the mechanical coupling of all strings via the pivoting bridge. Practical reports indicate tuning times between 8 and 30 minutes.

    The aim of this bachelor's thesis was to develop a mobile application that significantly accelerates this process through a mathematical model of the bridge coupling. For this purpose, a physical model of the Floyd Rose guitar was first developed, describing the nonlinear relationship between string tension, bridge position, and vibration frequencies. For small detunings, this system could be sufficiently linearized by a guitar-specific *detuning matrix*. The inverse of this matrix enables the direct calculation of the required detuning amounts for each string.

    Based on this model, a cross-platform Flutter application for Android and iOS was developed. It supports one-time instrument calibration, measurement of the current tuning state using the YIN algorithm, and a guided tuning process with calculated target frequencies.

    User tests showed that the guitar could be tuned successfully and significantly faster than with conventional methods under controlled acoustic conditions. The limitations of the current implementation lie primarily in the robustness of fundamental frequency detection in loud environments and with strong overtones.

    This thesis demonstrates that the coupling behavior of Floyd Rose guitars can be modeled with sufficient accuracy using a calibrated linear matrix and applied to practically support the tuning process.

    #v(0.8em)
    *Keywords:* Floyd Rose, Tremolo, Guitar Tuner, Signal Processing, Mobile App, Linear Approximation, Guitar Technology]
  // Table of contents.
  pagebreak()
  outline(depth: 3)
  pagebreak()
}

// Set body font family.
#set text(lang: "de")
#set math.equation(numbering: "(1)", supplement: none)
#show ref: it => {
  if it.element != none and it.element.func() == math.equation {
    [#link(it.element.location(), [Gleichung (#it)])]
  } else {
    it
  }
}
#set heading(numbering: "1.1")
#set page(numbering: "1")
// Main body.
#set par(justify: true)
#show heading: set block(below: 1.3em)
// ── Nummerierung pro Kategorie ──────────────────────────────────
#show figure.where(kind: "FBA"): set figure(supplement: [FBA ], numbering: "1")
#show figure.where(kind: "FSA"): set figure(supplement: [FSA ], numbering: "1")
#show figure.where(kind: "NFA-MG"): set figure(supplement: [NFA-MG ], numbering: "1")
#show figure.where(kind: "NFA-LA"): set figure(supplement: [NFA-LA ], numbering: "1")
#show figure.where(kind: "NFA-RO"): set figure(supplement: [NFA-RO ], numbering: "1")
#show figure.where(kind: "NFA-BE"): set figure(supplement: [NFA-BE ], numbering: "1")
#show figure.where(kind: "NFA-KO"): set figure(supplement: [NFA-KO ], numbering: "1")
#show figure.where(kind: "NFA-DP"): set figure(supplement: [NFA-DP ], numbering: "1")
#show figure.where(kind: "elast"): set figure(supplement: [Abbildung], numbering: "7.a")
// ── Eine einzige Show-Regel für alle Anforderungs-Kinds ─────────
#let req-kinds = ("FBA", "FSA", "NFA-MG", "NFA-LA", "NFA-RO", "NFA-BE", "NFA-KO", "NFA-DP")

#show figure: it => {
  if type(it.kind) == str and req-kinds.contains(it.kind) {
    it.body
  } else {
    it
  }
}

// ── Hilfsfunktion ───────────────────────────────────────────────
// ID-Präfix bestimmt automatisch den kind-Wert.
// "NFA-MG-01" → kind "NFA-MG", "FBA-03" → kind "FBA"
#let req-kind(id) = {
  if id.starts-with("NFA-") { id.slice(0, 6) } // "NFA-MG", "NFA-LA" …
  else { id.slice(0, 3) } // "FBA", "FSA"
}

#let req(id, prioritaet, inhalt) = figure(
  kind: req-kind(id),
  caption: none,
  block(
    width: 100%,
    inset: (x: 8pt, y: 6pt),
    stroke: (left: 2pt + luma(180)),
    grid(
      columns: (5.5em, 1fr, 5em),
      column-gutter: 1em,
      align: (left + top, left + top, right + top),
      strong(id), inhalt, emph(prioritaet),
    ),
  ),
)
#project()

= Motivation

Das Floyd-Rose-Tremolo ist ein in der E-Gitarre weit verbreitetes Brückensystem, das es Musikerinnen und Musikern ermöglicht, während des Spielens die Tonhöhe aller Saiten gleichzeitig zu verändern. Diese Eigenschaft macht es besonders in Rock- und Metalmusik beliebt.

Diese Flexibilität hat jedoch einen erheblichen Nachteil: Das Stimmen einer Floyd-Rose-Gitarre ist deutlich aufwändiger als bei herkömmlichen Gitarrenbrücken. Der Grund liegt in der mechanischen Kopplung der Saiten über die rotierbare Brücke. Wird die Spannung einer Saite verändert, verschiebt sich der Gleichgewichtszustand der gesamten Brücke und verstimmt dadurch alle übrigen Saiten. Dieser Kaskadeneffekt zwingt den Spieler zu einem iterativen, zeitaufwändigen Stimmvorgang.

Erfahrungsberichte aus der Praxis belegen Stimmzeiten von 8 bis 30 Minuten
@youtube_floyd_rose_tune2026 @ultimateguitar_floydrose_tuning_forum -- ein erheblicher Aufwand, insbesondere für professionelle Gitarristen und Gitarrentechniker, die täglich mehrere Instrumente stimmen müssen.

Bestehende Stimmgeräte -- sowohl hardware- als auch softwarebasiert -- berücksichtigen diese Kopplung nicht. Sie zeigen lediglich die aktuelle Frequenz einer Saite an, ohne Auskunft darüber zu geben, auf welchen Zielwert gestimmt werden muss, damit nach dem Stimmen aller Saiten das gewünschte Ergebnis erreicht wird.

#figure(
  image("assets/floydrose_frontside_neutral.jpg", height: 20%),
  caption: [Floyd-Rose-Tremolo (Floating Bridge)],
)<FRQuer>

= Problemstellung

Ziel dieser Arbeit ist die Entwicklung einer mobilen Applikation, die diesen Stimmvorgang durch ein mathematisches Modell der Brückenkopplung gezielt unterstützt und beschleunigt. Die zentrale Forschungsfrage lautet:

#align(center)[
  #block(width: 85%, inset: 10pt, stroke: (left: 2pt + luma(180)))[
    _Lässt sich das Kopplungsverhalten der Saiten einer Floyd-Rose-Gitarre durch eine gitarrenspezifisch kalibrierte Verstimmungsmatrix hinreichend genau linearisieren, um eine mobile Applikation zu entwickeln, die den Stimmvorgang gegenüber dem manuellen Verfahren messbar vereinfacht?_
  ]
]

Zur Beantwortung dieser Frage wird zunächst ein physikalisches Modell der Floyd-Rose-Gitarre entwickelt, das den Zusammenhang zwischen Saitenspannung, Brückenposition und Schwingungsfrequenz beschreibt. Auf Basis dieses Modells wird eine lineare Näherung hergeleitet und experimentell validiert.

@grundlagen beschreibt die physikalischen Grundlagen der Floyd-Rose-Gitarre, entwickelt das Kopplungsmodell und leitet die mathematische Lösung für den Stimmvorgang her.
@ablauf erläutert den praktischen Ablauf -- von der einmaligen Kalibrierung bis zum eigentlichen Stimmvorgang.
@verfahren stellt die grundlegenden Signalverarbeitungsverfahren vor, die für die Implementierung eines mobilen Stimmgeräts erforderlich sind.
@softwaredev beschreibt Anforderungsanalyse, Konzeption, Architektur und Implementierung der Applikation.
@evaluation bewertet die Erfüllung der Anforderungen und wertet die durchgeführten Nutzertests aus.
Abschließend fasst @fazit die Ergebnisse zusammen und @ausblick benennt Ansätze für eine Weiterentwicklung.

= Grundlagen <grundlagen>
== Bestimmung der Fundamentalfrequenz <verfahren>
Für die Implementierung eines Stimmgeräts auf mobilen Geräten ist die präzise
und effiziente Bestimmung der Grundfrequenz (Fundamental Frequency, F0)
entscheidend. Frequenzabweichungen werden in Cent angegeben -- einer
logarithmischen Einheit, bei der ein gleichstufiger Halbton exakt 100~Cent
entspricht @pierce1999klang. Die Abweichung $d$ in Cent zwischen zwei
Frequenzen $f_1$ und $f_2$ berechnet sich zu:

$
  d = 1200 dot log_2 (f_2 / f_1)
$

Cent eignen sich für diesen Zweck besonders, da gleiche Cent-Abstände
unabhängig von der absoluten Tonhöhe als gleich groß wahrgenommen werden.
Im Folgenden werden gängige Verfahren zur F0-Schätzung vorgestellt.

In @auswahlf0 werden diese Verfahren hinsichtlich Genauigkeit, Effizienz,
Robustheit und Implementierbarkeit bewertet und das geeignetste ausgewählt.

*Autokorrelation*

Die Grundidee der Autokorrelation beruht darauf, dass ein periodisches Signal
mit der Periode $tau$, wenn es mit einer zeitverschobenen Version seiner selbst
multipliziert wird, bei ganzzahligen Vielfachen von $tau$ Maxima aufweist. Das
erste von null verschiedene lokale Maximum bestimmt die gesuchte Periode $tau$;
ihr Kehrwert liefert die Grundfrequenz des Signals.

$
  r_t (tau) = sum_(j=t+1)^(t+W) x_j dot x_(j+tau)
$<acf>

Dabei bezeichnet $r_t (tau)$ den Autokorrelationswert für die Verzögerung $tau$
zum Zeitindex $t$ und $W$ die Fenstergröße der Integration. $x_j$ ist dabei der j-te Messpunkt der Audiodatei. @YIN

*YIN-Algorithmus*

Der YIN-Algorithmus @YIN ist eine Weiterentwicklung der klassischen
Autokorrelation, die durch sechs aufeinander aufbauende Schritte die
Fehlerrate gegenüber dem Basisverfahren von $10,0%$ auf
$0,5%$ reduziert.

*Schritt 1: Autokorrelation (Ausgangsbasis)*

Die klassische Autokorrelationsfunktion (ACF) (@acf)
ist  anfällig gegenüber Amplitudenschwankungen: Steigt die
Signalamplitude über die Zeit, wachsen die ACF-Peaks mit dem Lag, sodass
der Algorithmus fälschlicherweise eine zu niedrige Frequenz schätzt
(_too-low error_). Die Fehlerrate beträgt 10,0%.
#pagebreak()
*Schritt 2: Differenzfunktion*

Statt des Skalarprodukts verwendet YIN die quadratische Differenz zwischen
Signal und verschobener Version:

$
  d_t (tau) = sum_(j=1)^(W) (x_j - x_(j+tau))^2
$

Diese Funktion ist bei exakter Periodizität gleich null und kann über die
ACF ausgedrückt werden:

$
  d_t (tau) = r_t (0) + r_(t+tau) (0) - 2 r_t (tau)
$

Durch den zweiten Energieterm $r_(t+tau)(0)$ -- der in der ACF fehlt --
ist die Differenzfunktion robust gegenüber Amplitudenänderungen.
Die Fehlerrate sinkt auf $1,95%$.

*Schritt 3: Kumulativ gemittelte normierte Differenzfunktion*

Der triviale Minimalwert bei $tau = 0$ kann fälschlicherweise als Periode
gewählt werden. Die _Cumulative Mean Normalized Difference Function_
(CMNDF) verhindert dies durch Normierung:

$
  d'_t (tau) = cases(
    1 & "falls" tau = 0,
    display(d_t (tau) / [(1/tau) sum_(j=1)^(tau) d_t (j)]) & "sonst"
  )
$

Die normierte Funktion startet bei 1 statt bei 0 und fällt nur dort
unter 1, wo $d_t$ unterhalb des laufenden Mittels liegt. Damit werden
_too-high errors_ reduziert und die obere Suchgrenze des Frequenzbereichs
entfällt. Fehlerrate: $1,69%$.

*Schritt 4: Absoluter Schwellwert*

Tiefere Oberton-Minima der CMNDF können das Periodenminimum überdecken
und zu Oktavfehlern führen. YIN wählt daher das _kleinste_ $tau$, für
das $d'_t (tau)$ unter einen absoluten Schwellwert $theta$ (typisch
$theta = 0,1$) fällt:

Der Schwellwert entspricht dabei dem tolerierten Anteil aperiodischer
Leistung am Gesamtsignal und erfordert keine Feinabstimmung. Fehlerrate:
$0,78%$.

*Schritt 5: Parabolische Interpolation*

Da die Periode $tau^*$ ein ganzzahliges Vielfaches der Abtastperiode sein
muss, können Fehler von bis zu einem halben Sample entstehen. Jedes
lokale Minimum von $d'_t$ wird durch eine Parabel angenähert; die
Abszisse des interpolierten Minimums dient als Periodenschätzung.
Dies verbessert die Feingenauigkeit bei hohen Frequenzen, hat auf die
Grobfehlerrate jedoch nur geringen Einfluss: $0,77%$.

*Schritt 6: Bestes lokales Schätzmaß*

Bei nichtstationären Signalen kann die Schätzung phasenabhängig
versagen. Schritt 6 sucht in einer Umgebung
$[t - T_max/2, t + T_max/2]$ nach dem Zeitindex $u$, der das kleinste
$d'_u (tau_u)$ liefert, und verwendet dessen Schätzung als Ausgangspunkt
für eine erneute, eingeschränkte Suche. Dies entspricht einer
qualitätsbasierten statt kontinuitätsbasierten Glättung. Fehlerrate:
$0,50%$.


*Fourier- und Cepstrum-Analyse*

Bei der Fourier-Analyse wird das Zeitsignal in den Frequenzbereich transformiert
und das resultierende Spektrum nach der Grundfrequenz durchsucht. Studien zeigen
jedoch, dass Fourier-basierte Verfahren fehleranfällig sind und hohe
Abtastraten erfordern. @FFT_NEEDS_HIGH_SAMPLING

Die Cepstrum-Analyse erweitert diesen Ansatz, indem das logarithmierte Spektrum
erneut transformiert wird, um periodische Muster zu erkennen. Ein Vorteil
ist die Robustheit gegenüber harmonischen Obertönen sowie die gute Integration
in digitale Signalverarbeitungssysteme. Nachteilig wirkt sich die eingeschränkte
Genauigkeit bei niedrigen Frequenzen und verrauschten Signalen aus, da das
Verfahren Periodizität und harmonische Obertöne voraussetzt -- Annahmen, die in
realen Umgebungen nicht immer erfüllt sind. @Noll1967Cepstrum

*CREPE -- Neuronale Netze*

Neuronale Netze stellen einen grundlegend anderen Ansatz zur F0-Schätzung dar
als die klassischen Verfahren: Anstatt die Grundfrequenz durch mathematische
Regeln abzuleiten, lernen sie anhand großer Mengen annotierter Audioaufnahmen,
welche Muster im Signal welcher Tonhöhe entsprechen.

Ein prominentes Beispiel ist CREPE @Kim2019CREPE (Convolutional Representation
for Pitch Estimation), das ein sogenanntes Convolutional Neural Network (CNN)
direkt auf dem Rohaudiosignal anwendet. CNNs sind eine Klasse neuronaler Netze,
die ursprünglich für die Bilderkennung entwickelt wurden und lokale Muster --
im Falle von Audio also charakteristische Wellenformabschnitte -- besonders
effizient erkennen können. CREPE erreicht dadurch eine hohe Genauigkeit und
ist gegenüber verschiedenen Klangfarben, Rauschpegeln und Instrumenten
robuster als regelbasierte Verfahren.

Der wesentliche Nachteil dieser Ansätze liegt im Ressourcenbedarf: Die
Berechnung eines neuronalen Netzes ist rechenintensiver als klassische
Algorithmen, und das Training erfordert große annotierte Datensätze.

== Physikalisches Modell der Gitarre
Im Folgenden wird ein physikalisches Modell der Gitarre beschrieben, um zu verstehen, warum die Floyd-Rose-Gitarre so schwierig zu stimmen ist.

Die Gitarre spannt sechs Saiten zwischen Brücke und Sattel. Die Saiten schwingen in einer bestimmten Frequenz. Beim Stimmen wickelt man die Saite um den Stimmwirbel, sodass sich Spannung und Frequenz ändern.

#figure(
  image("assets/stimmwirbel.png", height: 27%),
  caption: [Stimmwirbel einer E-Gitarre],
)<figStimmwirbel>

=== Mathematische Beschreibung
Die Gitarre wird als Abbildung modelliert, die sechs Aufwickelstrecken $arrow(Delta L) = mat(Delta L_1, dots.h, Delta L_i, dots, Delta L_6)^T$ auf einen Frequenzvektor $arrow(f) = mat(f_1, dots, f_i, dots, f_6)^T$ abbildet
$arrow(Delta L) -> arrow(f)$, wobei jede Komponente zu einer Saite gehört. Beim Stimmen muss $arrow(Delta L)$ so gewählt werden, dass genau die gewünschten Frequenzen erreicht werden.
Das Ziel ist, die Funktion $f(arrow(Delta L))$ zu bestimmen.
Der Zusammenhang zwischen effektiver Saitenlänge $L_(S,i)$, Zugkraft $F_(S,i)$,
linearer Massendichte $mu_i$ und Frequenz $f_i$ wird durch das Mersennesche Gesetz beschrieben
@jeans1968science:

$
  f_i = 1 / (2 L_(S,i)) sqrt(F_(S,i) / mu_i)
$<eqMersenne>

Zunächst wird die Saitenkraft $F_(S,i)$ als Funktion der Aufwickelstrecken $arrow(Delta L)$ bestimmt. Die Kraft, die auf die Saite wirkt, wird durch das Hooksche Gesetz beschrieben @beer2020:

$ F_(S,i) = (L_(S,i) - L_(0S,i)) dot k_(S,i) $<eqSaitenkraft>


Die Federkonstante $k_(S,i)$ ist eine materialspezifische Größe des jeweiligen Saitenabschnitts $L_(S,i)$.

$L_(0S,i)$ beschreibt die unbelastete Saitenlänge im Abschnitt zwischen Sattel und Brücke. Diese Länge wird durch die Aufwickelstrecke $Delta L_i$ beeinflusst. $L'_(0S,i)$ sei die ursprüngliche unbelastete Saitenlänge.

$
  L_(0S,i) = L'_(0S,i) - Delta L_i
$<eqUnbelasteteSaitenlänge>


#figure(
  image("assets/FloydRoseSkizze2.png"),
  caption: [Queransicht des physikalischen Modells der Floyd-Rose-Brücke],
)<FRMQuer>

#figure(
  image("assets/floydrose_backside_neutral.jpg", height: 20%),
  caption: [Gegenzugfedern (Tremolofedern) der Floyd-Rose-Brücke],
)<FRFedern>


In @FRQuer, @FRMQuer und @FRFedern ist zu sehen, wie die Brücke die Tremolofedern und die Saiten über ein Drehmoment koppelt.  Die Tremolofedern dienen unterhalb der Brücke als Gegenkraft zur Saitenspannung.


#grid(
  columns: 2,
  inset: 6pt,
  grid.cell([
    #figure(
      image("assets/Topview.png"),
      caption: [Draufsicht des physikalischen Modells mit Saiten-Hebelarmen],
    ) <FRMTop>
  ]),
  grid.cell([
    #figure(
      image("assets/FRrealTop.png"),
      caption: [Draufsicht einer realen \ Floyd-Rose-Brücke],
    )<FRTop>
  ]),
)


In der Realität hat jede Saite ihre eigene Saitenlänge, wie in @FRMTop und @FRTop zu sehen ist. Sie variieren zwar nur minimal, haben aber einen Einfluss auf die rotatorische Projektion der Kräfte.

Die Brücke wird als starrer, gewinkelter Hebel betrachtet, siehe @FRMQuer.
Die Drehachse liege im Koordinatenursprung.
Die Vektoren $arrow(h)_hat(F)$ (Hebelarm der Feder) und $arrow(h)_(S,i)$ (Hebelarm der Saite i)
schließen konstruktionsbedingt einen konstanten Winkel $alpha_i$ ein.
Die Beträge $h_hat(F)$ und $h_(S,i)$ sind systemspezifische Konstanten. Jede Saite erhält ihren eigenen Hebelarm $arrow(h)_(S,i)$, um den Aufbau wie in @FRTop und @FRMTop korrekt zu modellieren. Die Tremolofedern erhalten in diesem Modell einen gemeinsamen Hebelarm $arrow(h)_hat(F)$.

$
  arrow(h)_hat(F)(beta) = h_hat(F) vec(cos(beta), sin(beta))
$


$
  arrow(h)_(S,i)(beta) = h_(S,i) vec(cos(beta+alpha_i), sin(beta+alpha_i))
$


Sei $arrow(P)_S$ die konstante Position des Sattels und $arrow(P)_hat(F)$ die konstante Position, an der die Tremolofeder an den Körper der Gitarre befestigt ist.
Die effektive Saitenlänge und Tremolofederlänge ergeben sich zu

$
  L_(S,i) (beta) = abs(arrow(h)_(S,i)(beta) - arrow(P)_S)
$ <eqSaitenlänge>

$
  L_hat(F) (beta) = abs(arrow(h)_hat(F)(beta) - arrow(P)_hat(F))
$ <eqTremolofederlänge>

Nun soll die Variable $beta$ bestimmt werden, die sich aus dem Kräftegleichgewicht und der darausfolgenden Hebelposition ergibt. Nach den Gesetzen der Statik trägt ausschließlich der zur jeweiligen Hebelarmrichtung orthogonale Kraftanteil zum Drehmoment bei @tipler2015.
Im stationären Gleichgewicht gilt das Drehmomentgleichgewicht:

$
  sum^6_(i=1) F_(S,i, bot h_(S,i)) dot h_(S,i) = F_(hat(F) bot h_hat(F)) dot h_hat(F)
$ <eqBrückenkraftgleichgewicht>

Dabei bezeichnen $F_(S,i, bot h_(S,i))$ und  $F_(hat(F) bot h_hat(F))$ jeweils die Anteile der Kräfte
$arrow(F)_(S,i)$ und $arrow(F)_hat(F)$, die orthogonal zu den Hebelarmen $arrow(h)_(S,i)$ und $arrow(h)_hat(F)$ wirken. Auf der linken Seite von @eqBrückenkraftgleichgewicht müssen die Kräfte der sechs Saiten aufaddiert werden, da sich die Kräfte parallelgeschalteter Federn addieren @beer2020.

Zunächst wird der Richtungsvektor von $F_(S,i)$, $h_(S,i)$, $F_hat(F)$ und $h_hat(F)$ normiert, wobei $P_hat(F)$ der Punkt ist, an der die Tremolofeder an der Gitarre befestigt ist.

$
  arrow(e)_F_(S,i) = (arrow(P)_S - arrow(h)_(S,i)) / abs(arrow(P)_S - arrow(h)_(S,i))
$
$
  arrow(e)_h_(S,i) = vec(cos(beta+alpha_i), sin(beta+alpha_i))
$
$
  arrow(e)_F_hat(F) = (arrow(P)_hat(F) - arrow(h)_hat(F)) / abs(arrow(P)_hat(F) - arrow(h)_hat(F))
$
$
  arrow(e)_h_hat(F) = vec(cos(beta), sin(beta))
$
Aus der orthogonalen Projektion eines Vektors $arrow(a)$ bezüglich eines Vektors $arrow(b)$ folgt @Glaister01032001:

$
  F_(S,i bot h_(S,i))
  = F_(S,i) dot sqrt(1 - (arrow(e)_F_(S,i) dot arrow(e)_h_(S,i))^2)
$
$
  = F_(S,i) dot sin(angle.arc(arrow(e)_F_(S,i), arrow(e)_h_(S,i)))
$

Analog ergibt sich für die Tremolofeder:
$
  F_(hat(F), bot h_hat(F))
  = F_hat(F) dot sqrt(1 - (arrow(e)_F_hat(F) dot arrow(e)_h_hat(F))^2)
$
$
  = F_hat(F) dot sin(angle.arc(arrow(e)_F_hat(F), arrow(e)_h_hat(F)))
$


Das Kräftegleichgewicht lässt sich damit schreiben als:

$
  sum^6_(i=1) F_(S,i) sin(angle.arc(arrow(e)_F_(S,i), arrow(e)_h_(S,i))) dot h_(S,i) = F_(hat(F)) sin(angle.arc(arrow(e)_F_hat(F), arrow(e)_h_hat(F))) dot h_hat(F)
$ <eqBrückenkraftgleichgewichtMitSinus>

Der nächste Schritt wäre, diesen Ausdruck nach $beta(arrow(Delta L))$ umzustellen, um die Hebelposition zu bestimmen. Allerdings ist dies nicht analytisch möglich, da $beta$ in den Sinusfunktionen und den Hebelarmvektoren auf beiden Seiten der Gleichung vorkommt. Es liegt ein nichtlineares Gleichungssystem vor, das numerisch gelöst werden muss.

Bringt man sie in die Form einer Nullstellengleichung, erhält man

$
  0 = g(beta; arrow(Delta L)) = sum^6_(i=1) F_(S,i) sin(angle.arc(arrow(e)_F_(S,i), arrow(e)_h_(S,i))) dot h_(S,i) - F_(hat(F)) sin(angle.arc(arrow(e)_F_hat(F), arrow(e)_h_hat(F))) dot h_hat(F)
$

Damit liegt ein eindimensionales nichtlineares Optimierungs- bzw. Nullstellenproblem vor, mit dem sich der Rotationswinkel $beta$ numerisch bestimmen lässt.

Aus dem so berechneten Winkel ergeben sich transitiv die abhängigen Größen
$h_(S,i) (beta)$, $L_(S,i)(beta)$ und $F_(S,i) (arrow(Delta L))$.

$mu_i$ ist von der Aufwickelstrecke $arrow(Delta L)$ abhängig.
Im Allgemeinen gilt für Saite $i$:

$
  mu_i = m_i / L_"S,i,Total"
$

Dabei bezeichnet $m_i$ die Gesamtmasse und $L_"S,i,Total"$ die Gesamtlänge der Saite $i$.
Die Gesamtlänge setzt sich zusammen aus der effektiven Saitenlänge $L_(S,i)$ und dem Teil der Saite der hinter dem Sattel liegt,
wie in @figStimmwirbel und @FRMTop zu sehen ist.

Diese Strecke sei $L_(M,i) = L_(0M,i)+Delta L_i$.

$L_(0M,i)$ beschreibt dabei die konstante Ausgangslage.

$
  L_"S,i,Total" (arrow(Delta L)) = L_(S,i) (arrow(Delta L)) + L_(0M,i) + Delta L_i
$

Beim Aufwickeln der Saite erhöht sich die Strecke hinter dem Sattel um $Delta L_i$. Die zusätzliche Strecke, die durch die Dehnung entsteht, steckt in $Delta L_(S,i)(arrow(Delta L))$.

Die lineare Massendichte ergibt sich somit zu:

$
  mu_i (arrow(Delta L)) = m_i/(L_(S,i) (arrow(Delta L)) + L_(0M,i) + Delta L_i)
$

Darauf aufbauend lässt sich eine Abbildung definieren, die die Aufwickelstrecken jeder Saite auf einen Frequenzvektor abbildet:

$
  f_i (arrow(Delta L)) =
  1 / (2 dot L_(S,i) (arrow(Delta L)))
  sqrt((F_"S,i" (arrow(Delta L)) )/ (mu_i (arrow(Delta L))))
$


Es wird ersichtlich, dass die Aufwickelstrecken der Saiten die Frequenzen aller Saiten beeinflussen. Das erklärt, warum das Stimmen einer Floyd-Rose-Gitarre so schwierig ist.


=== Experiment: Elastizität von Gitarrensaiten

Es wurde die Annahme getroffen, dass sich Gitarrensaiten wie Federn verhalten und das Hooksche Gesetz gilt. Dies wurde im folgenden Experiment überprüft.

Die Ergebnisse dieses Experiments beruhen auf Vorarbeiten des Autors, die im Rahmen des Moduls "Projekt 3" des Studiengangs Telekommunikationsinformatik an der HTWK Leipzig durchgeführt wurden @Schuetz2026FloydRose.

In der folgenden Tabelle sind Bilder, die die elastische Dehnung der Saite zeigen:
#{
  let fret-row(bund, img_pac, cap_pac, img_pac_t, cap_pac_t) = (
    [#bund],
    figure(image(img_pac, width: 8.5em), caption: [#cap_pac], kind: "elast"),
    figure(image(img_pac_t, width: 8.5em), caption: [#cap_pac_t], kind: "elast"),
  )

  set text(size: 8.5pt)
  show figure: set block(breakable: true)
  figure(
    kind: image,
    table(
      columns: (auto, 1fr, 1fr),
      inset: 6pt,
      stroke: 0.5pt,

      table.header([*Bund*], [*Normale E-Gitarre - Ruhe*], [*Normale E-Gitarre - Spannung*]),

      ..fret-row(1, "assets/p_1.jpeg", "Bund 1 - Ruhe", "assets/p_1t.jpeg", "Bund 1 - Spannung"),

      ..fret-row(6, "assets/p_6.jpeg", "Bund 6 - Ruhe", "assets/p_6t.jpeg", "Bund 6 - Spannung"),

      ..fret-row(12, "assets/p_12.jpeg", "Bund 12 - Ruhe", "assets/p_12t.jpeg", "Bund 12 - Spannung"),

      ..fret-row(22, "assets/p_22.jpeg", "Bund 22 - Ruhe", "assets/p_22t.jpeg", "Bund 22 - Spannung"),
    ),
    caption: [Elastische Dehnung von Gitarrensaiten bei unterschiedlicher Spannung],
  )
}<table1>

Die Markierungen, die sich näher am Sattel befanden, legten eine deutlich größere Strecke zurück als jene in unmittelbarer Nähe der Brücke. Die beobachtete Verschiebung nahm kontinuierlich vom Sattel in Richtung Brücke ab.

Die Kontrollmarkierungen auf den übrigen Saiten zeigten dagegen keine oder lediglich eine kaum wahrnehmbare Bewegung. Dies spricht dafür, dass die beobachtete Verschiebung nicht durch ein Verformen des Instruments verursacht wurde, sondern auf eine tatsächliche Längenänderung der gespannten Saite zurückzuführen ist. Als die Saite wieder entspannt wurde, waren die Markierungen wieder an ihrer Ausgangsposition. Die Schwingungsfrequenz der Saite war auch wieder dieselbe wie zu Beginn.

Die Beobachtungen belegen das elastische Verhalten von Gitarrensaiten.
Wird die Spannung durch Aufwickeln am Stimmwirbel erhöht, verschieben sich die aufgeklebten Markierungen entlang der Saite in unterschiedlichem Ausmaß. Markierungen in der Nähe der Brücke, die als nahezu fixer Punkt wirkt, erfahren nur eine sehr geringe Verschiebung, während weiter entfernte Markierungen deutlich stärker wandern.




=== Experiment: Nachweis Linearität <nachweisLin>
Beim Stimmen werden die Aufwickelstrecken nur in kleinen Schritten verändert. In diesem Fall verhält sich das System näherungsweise linear. Da das System physikalisch ist, kann das System als stetig betrachtet werden.

Diese Linearität wurde bereits experimentell in der _Projekt 3_ Arbeit des Autors @Schuetz2026FloydRose überprüft. Dabei wurde jedoch nicht der lineare Zusammenhang zwischen der Aufwickelstrecke $arrow(Delta L)$ und den Frequenzen $arrow(f)$ betrachtet. Stattdessen analysierte die Untersuchung den Einfluss der Frequenzänderung einer Saite auf die Frequenzen der übrigen Saiten. Dieses Vorgehen ist insbesondere im Hinblick auf die spätere praktische Anwendung von höherer Relevanz.

*Vorgehensweise*

Zunächst wurde jede Saite in eine Ausgangsposition gebracht. Die Ausgangsfrequenzen der Saiten wurden in Hertz gemessen.
Anschließend wurde jeweils eine Saite um ein beliebiges $Delta$ (in Hertz) verstimmt. Dieses $Delta$ wurde so gewählt, dass die Verstimmung deutlich hörbar ist. Für jeden Schritt wurde die Frequenz aller anderen Saiten gemessen.

#figure(
  kind: image,
  table(
    columns: (auto, auto, auto),
    inset: 8pt,
    stroke: .5pt,
    [*Nr.*], [*Saite*], [*Frequenz*],
    [1], [E2 = E-Saite], [82,41 Hz],
    [2], [A2 = A-Saite], [110 Hz],
    [3], [D3 = D-Saite], [146,83 Hz],
    [4], [G3 = G-Saite], [196 Hz],
    [5], [B3 = B-Saite], [246,94 Hz],
    [6], [E4 = hohe E-Saite], [329,63 Hz],
  ),
  caption: "Standard-Stimmung (EADGBE) mit zugehörigen Sollfrequenzen",
)<tableSaitenNamen>
#pagebreak()
*Ergebnisse*

*Relative Visualisierung der Frequenzänderungen*
#grid(
  columns: 2,
  inset: 6pt,
  grid.cell([
    #figure(
      image("assets/plot_E2_relative Hz.png"),
      caption: [Relativer Frequenzeinfluss beim Verstimmen der E2 Saite],
    ) <relativeE2>
  ]),
  grid.cell([
    #figure(
      image("assets/plot_A2_relative Hz.png"),
      caption: [Relativer Frequenzeinfluss beim Verstimmen der A2 Saite],
    ) <relativeA2>
  ]),
  grid.cell([
    #figure(
      image("assets/plot_D3_relative Hz.png"),
      caption: [Relativer Frequenzeinfluss beim Verstimmen der D3 Saite],
    ) <relativeD3>
  ]),
  grid.cell([
    #figure(
      image("assets/plot_G3_relative Hz.png"),
      caption: [Relativer Frequenzeinfluss beim Verstimmen der G3 Saite],
    ) <relativeG3>
  ]),
  grid.cell([
    #figure(
      image("assets/plot_B3_relative Hz.png"),
      caption: [Relativer Frequenzeinfluss beim Verstimmen der B3 Saite],
    ) <relativeB3>
  ]),
  grid.cell([
    #figure(
      image("assets/plot_E4_relative Hz.png"),
      caption: [Relativer Frequenzeinfluss beim Verstimmen der E4 Saite],
    ) <relativeE4>
  ]),
)
#pagebreak()
*Korrelationskoeffizienten und Fehler*

#figure(
  image("assets/pearson_correlation.png", height: 30%),
  caption: [Pearson-Korrelationskoeffizienten der Frequenzmessdaten],
) <correlations>

Beim Zurückbringen einer Saite in ihre Ausgangsposition nahmen alle anderen Saiten ebenfalls wieder ihre ursprüngliche Frequenz an.

*Diskussion der Ergebnisse*

Das System ist elastisch, da Ausgangs- und Endfrequenzen nach jedem Durchgang gleich sind.

Die Linearität des Systems ist nicht perfekt, aber hinreichend gut für kleine Verstimmungen. Sie lässt sich quantitativ mit dem Korrelationskoeffizienten nach Bravais-Pearson @pearson1896 zwischen gemessenen und erwarteten Frequenzänderungen jeder Saite bestimmen.
In @correlations sind die Korrelationskoeffizienten für jede Saite dargestellt. Der Betrag aller relevanten Werte liegt unter -0,98, was auf eine sehr starke negative Korrelation hinweist. Das rechtfertigt die Annahme einer linearen Beziehung für kleine Änderungen.
= Verfahren

== Ablauf des Stimmvorgangs für Floyd-Rose-Gitarren <ablauf>

Im Folgenden wird der Ablauf zum Stimmen einer Floyd-Rose-Gitarre beschrieben
sowie die dafür erforderlichen Verfahren erläutert.

=== Initiierung -- Bestimmung der Verstimmungsmatrix
Vor dem eigentlichen Stimmvorgang muss die gitarrenspezifische
Verstimmungsmatrix $C$ einmalig ermittelt werden. Da sie eine physikalische
Eigenschaft des jeweiligen Instruments beschreibt, ist diese Kalibrierung nur
beim erstmaligen Einsatz der Methode notwendig.

Zur Bestimmung jedes Matrixeintrags werden mindestens zwei Messpunkte benötigt,
um die lineare Steigung zu ermitteln. Die Diagonalelemente $C_"ii" = 1$ sind
definitionsgemäß bekannt und müssen nicht gemessen werden.

Der erste Messpunkt beschreibt den Ausgangszustand der Gitarre; alle weiteren
Messpunkte erfassen das Verhalten der übrigen Saiten bei gezielter Veränderung
einer einzelnen Saite. Durch eine höhere Anzahl an Messpunkten lässt sich die
Schätzgenauigkeit der Steigung beliebig steigern. Zur Auswertung wird ein
lineares Regressionsverfahren eingesetzt.

Dabei kommen folgende Verfahren in Betracht:

/ Methode der kleinsten Quadrate (OLS): Minimiert die Summe der quadrierten
  vertikalen Abstände in $Y$-Richtung zwischen den Datenpunkten und der
  Regressionsgeraden. Sie setzt voraus, dass ausschließlich die Antwortvariable
  $Y$ fehlerbehaftet ist, während die Prädiktorvariable $X$ als exakt gilt.

/ Orthogonale Regression (Deming-Regression): Minimiert die Summe der
  quadrierten senkrechten Abstände der Datenpunkte zur Regressionsgeraden. Sie
  wird angewendet, wenn sowohl $Y$ als auch $X$ Messfehler aufweisen.
  @Glaister01032001

Da die Frequenzmessungen beider Achsen messtechnisch bedingte Fehler enthalten,
wird die *orthogonale Regression* verwendet.

=== Stimmvorgang

Zunächst wird die gewünschte Zielstimmung festgelegt. Gitarren werden je nach
musikalischem Kontext in verschiedenen Stimmungen gespielt, da bestimmte
Akkordgriffe in alternativen Stimmungen vereinfacht oder erst ermöglicht werden.

Anschließend wird der aktuelle Zustand der Gitarre durch eine einmalige
Frequenzmessung aller Saiten erfasst, um den Frequenzvektor $arrow(f)_0$ zu
bestimmen.


Mithilfe von @eqFloydRoseTuner wird für jede Saite die Zwischenzielfrequenz
berechnet -- also die Frequenz, auf die der Gitarrist beim sequentiellen Stimmen
abzielt.

Da die Zwischenzielfrequenzen die bereits gestimmten Saiten berücksichtigen,
sind sie von der gewählten Stimmreihenfolge abhängig.

Abschließend wird mithilfe eines herkömmlichen Stimmgeräts verifiziert, ob alle
Saiten die berechneten Zielfrequenzen erreicht haben und die Gitarre korrekt
gestimmt ist.

*Herleitung des Floyd-Rose-Stimmalgorithmus*

Die Frequenzen der Saiten werden als Vektor dargestellt. Der Vektor $arrow(f)_0$ beschreibt die Ausgangsfrequenzen der Saiten. Beim Stimmen erfährt jede Saite eine Änderung ihrer Frequenz. $arrow(Delta)$ gibt an, um wie viel Hertz jede Saite beim Stimmen verstimmt wird. Außerdem sollen die Saiten die Zielfrequenzen $arrow(g)$ erreichen:



$
  arrow(f)_0 = vec(f_"E2", f_"A2", f_"D3", f_"G3", f_"B3", f_"E4") quad quad arrow(Delta) = vec(Delta_"E2", Delta_"A2", Delta_"D3", Delta_"G3", Delta_"B3", Delta_"E4") quad quad arrow(g) = vec(hat(f)_"E2", hat(f)_"A2", hat(f)_"D3", hat(f)_"G3", hat(f)_"B3", hat(f)_"E4")
$




Aus @nachweisLin geht hervor, dass der Einfluss dieser Saiten mit einem konstanten Koeffizienten $c_"ij"$ beschrieben werden kann.

Wird zum Beispiel $Delta_"E2"$ geändert, berechnet sich der neue Zustand der Frequenz aus:

$
  arrow(f) = arrow(f)_0 + vec(c_11 Delta_"E2", c_21 Delta_"E2", c_31 Delta_"E2", c_41 Delta_"E2", c_51 Delta_"E2", c_61 Delta_"E2")
$
Werden weitere Saiten verstimmt, addieren sich die jeweiligen Einflüsse auf.
$
  arrow(f) = arrow(f)_0 + vec(c_11 Delta_"E2", dots.v, c_61 Delta_"E2") +vec(c_12 Delta_"A2", dots.v, c_62 Delta_"A2") + ... +vec(c_16 Delta_"E4", dots.v, c_66 Delta_"E4") = arrow(f)_0 + sum_(j=1)^(6) vec(c_(1 j) Delta_j, dots.v, c_(6 j) Delta_j)
$
Diese Operation ist eine Matrix-Vektor-Multiplikation mit der Matrix $C$ und dem Vector $arrow(Delta)$:
$
  C = mat(
    1, c_(12), c_(13), c_(14), c_(15), c_(16);
    c_(21), 1, c_(23), c_(24), c_(25), c_(26);
    c_(31), c_(32), 1, c_(34), c_(35), c_(36);
    c_(41), c_(42), c_(43), 1, c_(45), c_(46);
    c_(51), c_(52), c_(53), c_(54), 1, c_(56);
    c_(61), c_(62), c_(63), c_(64), c_(65), 1
  )
$

$C$ ist die sogenannte Verstimmungsmatrix. Die Einträge $c_"ij"$ geben den Verstimmungsfaktor der Saite $i$, unter Verstimmung der Saite $j$ um 1 Hz, an. Für die Diagonaleinträge gilt $c_"ii"=1$, da jede Saite sich selbst voll beeinflusst.

Die Verstimmungsmatrix aus dem Experiment aus @nachweisLin ist in @distortionMatrix dargestellt:

#figure(
  image("assets/detuning_matrix_example.png", height: 40%),
  caption: [Messdaten einer Verstimmungsmatrix],
) <distortionMatrix>


Die effektive Verstimmung wird durch die Multiplikation mit der Verstimmungsmatrix berechnet:

$
  C dot arrow(Delta) = arrow(Delta)_"eff"
$
$arrow(Delta)_"eff"$ berücksichtigt dabei also auch die Verstimmung, die durch den Nebeneffekt des Stimmens entstanden ist.

Damit die Ziel-Frequenzen $arrow(g)$ erreicht werden, gilt:

$
  arrow(g) = arrow(f)_0 + arrow(Delta)_"eff" quad => quad arrow(Delta)_"eff" = arrow(g)-arrow(f)_0
$

Um die Eingangsverstimmung $arrow(Delta)$ zu bestimmen, muss das Inverse der Matrix $C$ gebildet werden:

$
  C dot arrow(Delta) = arrow(Delta)_"eff" quad => quad arrow(Delta) = C^(-1) dot arrow(Delta)_"eff"
$

$
  arrow(Delta) = C^(-1) dot (arrow(g)-arrow(f)_0)
$<eqdeltas>

$C^(-1)$ ist die Inverse der Verstimmungsmatrix.

Somit benötigt man für die Berechnung:
1. Ausgangsfrequenzen $arrow(f)_0$
2. Ziel-Frequenzen $arrow(g)$
3. Verstimmungsmatrix $C$
Bei $arrow(Delta)$ handelt es sich um relative Verstimmungswerte. Für die
praktische Anwendung sind diese allerdings unhandlich.

Um zu bestimmen, auf welche Frequenz eine Saite gestimmt werden muss, müsste der Gitarrist zunächst die aktuelle Frequenz dieser Saite messen und anschließend $Delta_i$ addieren.
Da sich beim Verstimmen einer Saite auch die Frequenzen aller anderen Saiten verändern, würde die erforderliche relative Verstimmung für jeden weiteren Stimmschritt eine erneute Messung und Addition des entsprechenden $Delta_i$ erfordern.

Stattdessen sollen Zwischenzielfrequenzen berechnet werden, auf die der
Gitarrist ohne Zwischenmessung stimmen kann.

Es wird angenommen, dass die Saiten sequentiell in der Reihenfolge
E2 $arrow.r$ A2 $arrow.r$ D3 $arrow.r$ G3 $arrow.r$ B3 $arrow.r$ E4
gestimmt werden.

Es gilt:

$
  arrow(g) = arrow(f)_0 + C dot arrow(Delta)
$

Da der Nutzer jede Saite nur einzeln stimmen kann, gilt:

$
  arrow(g) = arrow(f)_0 + C vec(Delta_"E2", 0, dots.v, 0) + C vec(0, Delta_"A2", 0, dots.v, 0) + dots + C vec(0, dots.v, 0, Delta_"E4",)
$

Zur Berechnung der Zwischenzielfrequenz der $N$-ten Saite müssen daher die Einflüsse der bereits gestimmten Saiten auf die aktuell zu stimmende Saite berücksichtigt werden.

Beim Stimmen der $N$-ten Saite wurden die Saiten $j < N$ bereits gestimmt.
Die
Zwischenzielfrequenz $f_(z,N)$, auf die beim Stimmen abgezielt wird, lautet also:

$
  f_(z,N) = f_(0,N) + sum_(j=1)^(N) Delta_j dot c_(N j)
$<eqFloydRoseTuner>

Dies lässt sich auch mit Hilfe einer Dreiecksmatrix schreiben.

$
  L_C = mat(
    1, 0, 0, 0, 0, 0;
    c_(21), 1, 0, 0, 0, 0;
    c_(31), c_(32), 1, 0, 0, 0;
    c_(41), c_(42), c_(43), 1, 0, 0;
    c_(51), c_(52), c_(53), c_(54), 1, 0;
    c_(61), c_(62), c_(63), c_(64), c_(65), 1
  )
$
$
  arrow(f)_z = arrow(f)_0 + L_C arrow(Delta)
$
Für die ersten drei Saiten ergibt sich konkret:

$
  f_(z,"E2") & = f_(0,"E2") + Delta_"E2" \
  f_(z,"A2") & = f_(0,"A2") + Delta_"A2" + Delta_"E2" dot c_(21) \
  f_(z,"D3") & = f_(0,"D3") + Delta_"D3" + Delta_"A2" dot c_(32)
               + Delta_"E2" dot c_(31)
$

$f_(z,N)$ ist eine Zwischenzielfrequenz -- nachfolgende Saiten
verschieben Saite $N$ noch weiter. Die Endfrequenz aller Saiten konvergiert
dennoch zu $arrow(g)$, da die $Delta_j$ aus der vollen Verstimmungsmatrix $C$
berechnet wurden.

== Auswahl des Verfahrens zur Bestimmung der Fundamentalfrequenz <auswahlf0>

Zur systematischen Auswahl wurde eine multikriterielle
Entscheidungsanalyse nach dem Analytic Hierarchy Process (AHP) @Saaty1980
durchgeführt.

*Bewertungskriterien und Gewichtung*

Die Kriterien leiten sich direkt aus den Anforderungen einer mobilen
Echtzeit-Implementierung in Flutter ab. In @auswahlflutter wird erläutert,
was Flutter ist und warum es eingesetzt wird.

Die Kriterien wurden qualitativ in die Kategorien "_unwichtig_", "_weniger wichtig_" und "_sehr wichtig_" eingeordnet.
#figure(
  table(
    columns: (auto, auto, auto),

    table.header([*Kriterium*], [*Beschreibung*], [*Gewichtung*]),
    [Genauigkeit], [Zuverlässigkeit der F0-Schätzung bei realen Musiksignalen], [_sehr wichtig_],
    [Effizienz], [CPU-Last und Speicherverbrauch unter \ Echtzeitbedingungen], [_weniger wichtig_],
    [Robustheit], [Stabilität gegenüber Rauschen und \ Amplitudenschwankungen], [_weniger wichtig_],
    [Implementierbarkeit], [Verfügbarkeit als Bibliothek oder Integrationsaufwand in Flutter/Dart], [_sehr wichtig_],
  ),

  kind: image,
  caption: [Bewertungskriterien und Gewichtung],
)

*Genauigkeit* ist _sehr wichtig_, da sie die Präzision der Applikation unmittelbar beeinflusst. Ungenaue F0-Schätzungen wirken sich direkt auf die Messwerte der Verstimmungsmatrix und damit auf die Berechnung der Zwischenzielfrequenz aus.

*Effizienz* ist _weniger wichtig_, da moderne Mobilgeräte in der Regel ausreichend Rechenleistung bereitstellen.

*Robustheit* ist ebenfalls _weniger wichtig_, da die Applikation zunächst die Funktionalität des Floyd-Rose-Stimmalgorithmus demonstrieren soll, jedoch noch keinen hohen Anspruch an Robustheit in lauten, verrauschten Umgebungen stellt.

*Implementierbarkeit* ist _sehr wichtig_, da die Verfügbarkeit einer Bibliothek den Entwicklungsaufwand erheblich beeinflusst. Dies ist relevant, da die Entwicklung im Rahmen der Bachelorarbeit einer festen Frist unterliegt.

*Entscheidungsmatrix*

Die vier Verfahren wurden auf einer ordinalen Skala (_schlecht_, _mittel_, _gut_) bewertet.

#figure(
  kind: image,
  table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr),
    table.header(
      [*Verfahren*],
      [*Genauigkeit* \ _sehr wichtig_],
      [*Effizienz* \ _weniger \ wichtig_],
      [*Robustheit* \ _weniger \ wichtig_],
      [*Implementierbarkeit* \ _sehr wichtig_],
    ),
    [Klassische Autokorrelation], [_schlecht_], [_gut_], [_schlecht_], [_gut_],
    [YIN-Algorithmus], [_gut_], [_mittel_], [_mittel_], [_gut_],
    [Fourier-/Cepstrum-Analyse], [_gut_], [_mittel_], [_mittel_], [_mittel_],
    [CREPE], [_gut_], [_schlecht_], [_gut_], [_mittel_],
  ),
  caption: [Entscheidungsmatrix zur Auswahl des Verfahrens],
)

*Bewertung der Einzelverfahren*

*Klassische Autokorrelation*

Die klassische Autokorrelation hat eine _schlechte_ Genauigkeit, da sie gegenüber Oktavfehlern und harmonischen Obertönen strukturell anfällig ist @YIN -- insbesondere bei Gitarrensignalen mit starken Obertönen kann das erste Nebenmaximum fälschlicherweise als Grundfrequenz detektiert werden.

Die Robustheit ist _schlecht_, da sie zusätzlich unter der Empfindlichkeit gegenüber additivem Rauschen leidet.

Ihre Effizienz und Implementierbarkeit ist _gut_, da sie auf einer einfachen Berechnungsformel basiert.

*YIN-Algorithmus*

Der YIN-Algorithmus reduziert Oktavfehler gegenüber der klassischen Autokorrelation deutlich. Er hat eine _gute_ Genauigkeit mit einem mittleren Fehler von unter 2~% bei periodischen Signalen @YIN.

Die Nachbearbeitungsschritte -- insbesondere die parabolische Interpolation sowie ein absoluter Schwellenwert zur Voicing-Entscheidung -- erhöhen die Zeitkomplexität gegenüber der einfachen Autokorrelation, weshalb die Effizienz als _mittel_ bewertet wurde.

Die Robustheit ist _mittel_, da sie im Vergleich zum CREPE-Algorithmus geringer ausfällt @kroon2022comparingconventionalpitchdetection und gleichzeitig von der Differenzbildung profitiert, die stationäres Rauschen teilweise unterdrückt.

Entscheidend für die Implementierbarkeit ist die Verfügbarkeit des Algorithmus als natives Dart-Paket für Flutter, wodurch kein eigener Portierungsaufwand entsteht. Dieser Umstand wird als _gut_ bewertet.

*Fourier-/Cepstrum-Analyse*

Die Genauigkeit wird als _gut_ bewertet; für tiefe Gitarrenfrequenzen unter 80~Hz sind jedoch lange Fensterlängen erforderlich, was die zeitliche Auflösung verschlechtert @FFT_NEEDS_HIGH_SAMPLING. Der Genauigkeitsunterschied gegenüber YIN ist dabei vergleichsweise gering @SUKHOSTAT2015410.

Die zweifache Transformation erhöht den Rechenaufwand gegenüber der klassischen Autokorrelation spürbar, weshalb die Effizienz als _mittel_ bewertet wird.

Die Robustheit wird ebenfalls als _mittel_ eingestuft und ist mit der von YIN vergleichbar @SUKHOSTAT2015410.

Die Implementierbarkeit wird als _mittel_ bewertet, da FFT-Bibliotheken für Dart verfügbar sind, die Cepstrum-Verarbeitung jedoch manuell implementiert werden müsste.

*CREPE*

Die Genauigkeit wird als _gut_ bewertet; gemäß @kroon2022comparingconventionalpitchdetection ist die Leistung mit YIN vergleichbar. Da das Modell auf allgemeinen Audiodaten trainiert wurde, wären durch ein nachträgliches Training auf Gitarrenaufnahmen weitere Verbesserungen erzielbar.

Die Robustheit wird als _gut_ bewertet: Da das Modell während des Trainings eine Vielzahl an Klangfarben, Rauschpegeln und Aufnahmebedingungen gesehen hat, ist es gegenüber solchen Schwankungen widerstandsfähiger als regelbasierte Verfahren.

Die Effizienz wird als _schlecht_ bewertet. Das Netz verarbeitet 1024 Rohsamples in sechs aufeinanderfolgenden Rechenschritten (Faltungslayern), in denen jeweils lokale Muster im Signal gesucht werden, gefolgt von einer abschließenden Klassifikationsschicht mit 360 möglichen Ausgaben. Bereits der erste Rechenschritt erzeugt dabei $128 times 1024 = 131,072$ Zwischenwerte (~512~KB), was etwa dem 16-fachen aller nachfolgenden Schritte entspricht. Der gesamte Arbeitsspeicherbedarf pro Berechnung beträgt ca.\ 600~KB, die Modellgröße rund 4--5~MB.

Die Implementierbarkeit wird als _mittel_ bewertet: CREPE ist als Python-Bibliothek verfügbar, eine direkt einbindbare Lösung für Flutter existiert jedoch nicht. Eine Integration würde die Umwandlung des Modells in ein mobiltaugliches Format (TensorFlow Lite) sowie eine entsprechende Anbindung an Flutter erfordern -- ein erheblicher Mehraufwand gegenüber einer fertigen Bibliothek.

*Auswahl*

Der *YIN-Algorithmus* erzielt die höchste Gesamtbewertung und wird daher für die Implementierung ausgewählt. Trotz etwas geringerer Genauigkeit gegenüber CREPE überzeugt YIN durch die direkte Verfügbarkeit als Flutter-Bibliothek, gute Effizienz sowie ausreichende Robustheit für den vorgesehenen Einsatzbereich.

Für zukünftige Iterationen bleibt CREPE eine interessante Option, da das Modell durch gitarrenspezifisches Training weiter optimiert werden könnte.

== Signal-Filter
Um die Zuverlässigkeit der Grundfrequenzschätzung zu erhöhen, wird Ein- und Ausgangssignal gefiltert und aufbereitet.
=== Bandpassfilterung durch Parameteranpassung
Da der YIN-Algorithmus verwendet wird, lässt sich eine implizite
Bandpassfilterung durch gezielte Anpassung seiner Parameter erreichen. Durch
Reduktion der Abtastrate werden Frequenzen oberhalb der halben Abtastrate
nicht mehr erfasst, was dem Nyquist-Shannon-Abtasttheorem entspricht.
@oppenheim1999discrete

Die untere Grenzfrequenz wird durch die maximale Fensterlänge $W$ begrenzt.
Gemäß $f = 1 slash T$ darf die Fensterlänge den Wert $T_"max" = 1 slash f_"min"$
nicht überschreiten. Da der Frequenzbereich von Gitarrensaiten näherungsweise
$50 "Hz"$ bis $350 "Hz"$ umfasst, lassen sich die Parameter entsprechend
dimensionieren.

=== Gleitender Mittelwert für Streaming-Messdaten<movingAverage>
Mikrofonaufnahmen enthalten unvermeidlich Umgebungsgeräusche, die zu
Schwankungen in der Frequenzschätzung führen. Um eine stabile Visualisierung zu
gewährleisten, wird ein gleitender Mittelwert über die letzten $N$ Messwerte
gebildet und angezeigt. Dieses Verfahren reduziert kurzzeitige Ausreißer, ohne
dabei wesentliche Latenzen einzuführen.
=== Amplitudenschwelle

Um eine kontinuierliche Grundfrequenzschätzung bei Stille oder Umgebungslärm zu
vermeiden, wird die Schätzung nur aktiviert, wenn das Signal einen
Mindestpegel überschreitet. Der Schalldruckpegel wird dabei gemäß

$
  L = 20 dot log_10 lr((frac("RMS", 32768)))
$

in _decibels relative to full scale_ (dBFS) @dBFS berechnet, wobei $32768$ dem maximalen Amplitudenwert eines
16-Bit-PCM-Signals entspricht.

= Softwareentwicklung/Implementierung<softwaredev>

Die Methodik der Softwareentwicklung wurde durch das Buch "Mobile App Engineering" @mobileAppEngineering inspiriert.

Das Buch beschäftigt sich mit der Entwicklung von _Enterprise Apps_. Die in diesem Rahmen entwickelte App ist zwar keine _Enterprise App_, aber die Prinzipien der Softwareentwicklung, die in diesem Buch beschrieben werden, sind dennoch anwendbar. Es werden insbesondere die Prinzipien der Anforderungsanalyse und der nutzerzentrierten Gestaltung übernommen.

Wie im Buch beschrieben, werden Mobile Applikationen in iterativen Prozessen entwickelt. Daher werden manche Designentscheidungen mit Usertests begründet, die mit einer älteren Version der App durchgeführt wurden.

== Requirements Engineering
Dieses Kapitel wurde mithilfe des Buchs "Mobile App Engineering" @mobileAppEngineering entwickelt. Die Ergebnisse folgen aus der Befolgung des Kapitels 4 "Requirements Engineering".

=== Projektvision

Ziel des Projekts ist die Entwicklung einer mobilen Applikation, die Gitarristen
beim effizienten Stimmen von Gitarren mit Floyd-Rose-Brücke unterstützt und den
damit verbundenen zeitlichen sowie technischen Aufwand minimiert.

=== Ziel- und Benutzergruppe

Die Zielgruppe umfasst alle Personen, die regelmäßig oder gelegentlich eine
Gitarre mit Floyd-Rose-Brücke stimmen müssen. Sie lässt sich in drei Segmente
unterteilen:

*Gitarren-Einsteiger* erwarben eine Floyd-Rose-Gitarre häufig ohne vollständiges
Bewusstsein über den erhöhten Stimmaufwand dieses Brückensystems. Vorkenntnisse
über Gitarrentechnik sind in dieser Gruppe gering; Alter und technisches
Vorwissen variieren stark.

*Professionelle Gitarristen* verfügen über mehrere Instrumente in
unterschiedlichen Stimmungen, um ein breites klangliches Spektrum abdecken zu
können. Sie besitzen fundierte Gitarrenkenntnisse und kommunizieren in der Regel
auf Englisch.

*Gitarrentechniker in Musikgeschäften* stellen die zeitkritischste Benutzergruppe
dar. Sie stimmen und warten potenziell täglich mehrere Floyd-Rose-Gitarren für
Kunden, verfügen über tiefgehendes technisches Fachwissen und sind mit
englischsprachiger Fachterminologie vertraut. Für diese Gruppe bietet die
Applikation den größten Effizienzgewinn.

=== Systemkontext

Der Systemkontext beschreibt alle materiellen und immateriellen Einflussfaktoren,
die im Zusammenhang mit dem Projekt stehen. @mobileAppEngineering Im vorliegenden
Fall umfasst er folgende Aspekte:

*Benutzer:* Personen, die eine Floyd-Rose-Gitarre stimmen möchten, unabhängig
von ihrem technischen Kenntnisstand.

*Akustische Umgebung:* Die Umgebungsgeräusche am Ort des Stimmvorgangs
beeinflussen die Qualität der Frequenzmessung und stellen eine zentrale
Einflussgröße für die Zuverlässigkeit der Applikation dar.

*Hardware des Mobilgeräts:* Die Mikrofonqualität des verwendeten Endgeräts
wirkt sich direkt auf die Genauigkeit der Grundfrequenzschätzung aus.

*Spielweise der Gitarre:* Es ist zu unterscheiden, ob die Gitarre über einen
Verstärker mit ausreichendem Schallpegel betrieben oder unverstärkt und damit
leiser angespielt wird. Zudem kann ein ausgeprägter Obertonanteil die
Frequenzanalyse erschweren.

Da die Applikation vollständig lokal auf dem Endgerät ausgeführt wird, ist
kein IT-Backend und keine Internetverbindung erforderlich.

=== Anwendungskontext

Der Anwendungskontext wurde maßgeblich durch die in @nutzerTests dokumentierten
Nutzertests ermittelt. Dabei wurden folgende praxisrelevante Erkenntnisse
gewonnen:

*Akustische Störeinflüsse:* Ein Teil der Testpersonen stimmte die Gitarre in
lauten Umgebungen oder spielte Instrumente mit ausgeprägtem Obertonanteil.
Beides führte zu einer fehlerhaften Erkennung der Grundfrequenz und stellt
damit eine zentrale Herausforderung für die Signalverarbeitung dar.

*Benutzerführung:* Die Tests zeigten, dass rein textbasierte Erklärungen für
einen Teil der Nutzer nicht ausreichen. Visuelle Unterstützung durch
Illustrationen oder animierte Hinweise ist notwendig, um Bedienabläufe
verständlich zu vermitteln.

*Darstellung von Messwerten:* Numerische Frequenzangaben erzeugten bei
Testpersonen häufig Verwirrung. Eine abstrahierte, intuitiv verständliche
Visualisierung der Stimmgenauigkeit ist daher einer rein zahlenwertbasierten
Darstellung vorzuziehen.

*Abgrenzung des Anwendungsbereichs:* Einzelne Testpersonen äußerten den Wunsch
nach einer Integration in professionelle Musikstudio-Umgebungen sowie nach
einer Verwendbarkeit als Plugin für Digital Audio Workstations (DAW). Dieser
Anwendungsfall liegt jedoch außerhalb des definierten Projektumfangs und wird
nicht berücksichtigt.

=== Personas <hanna>

Um die Anforderungen der Zielgruppe greifbar zu machen, wurden auf
Basis der
Zielgruppensegmente vier repräsentative Personas entwickelt.

*Emil -- Gitarren-Einsteiger*

Emil ist 26 Jahre alt, arbeitet als Kellner und macht Musik als Hobby. Er hat
Translationswissenschaften studiert und keinen technischen Hintergrund. Durch
ein Familiengeschenk kam er in den Besitz einer Floyd-Rose-Gitarre, ohne sich
zuvor mit den Besonderheiten dieses Brückensystems auseinandergesetzt zu haben.

Emil nutzt alltäglich Spotify, WhatsApp, Instagram und YouTube. Er liest Texte
selten vollständig und bevorzugt visuelle oder interaktive Inhalte. Er ist
ungeduldig und erwartet, dass Anwendungen ihn intuitiv durch Prozesse führen.

Der erhöhte Zeitaufwand beim Stimmen frustriert ihn zunehmend und lässt ihn
über den Kauf einer einfacher zu stimmenden Gitarre nachdenken.

*Relevanz:* Emil repräsentiert Nutzer mit geringem Vorwissen, die eine niedrige
Einstiegshürde und eine geführte Benutzeroberfläche benötigen.

*Matilda -- Professionelle Gitarristin*

Matilda ist 38 Jahre alt und verdient ihren Lebensunterhalt als Gitarristin
ihrer Metalband "Fire Hawks". Sie spielt seit 20 Jahren E-Gitarre und besitzt
eine Sammlung mehrerer Instrumente, darunter ihre bevorzugte Music Man
Silhouette mit Floyd-Rose-Tremolo.

Da sie ihre Saiten aufgrund intensiver Bespielung regelmäßig wechselt, ist
das Neustimmen für sie Routine. Matilda wechselt häufig zwischen Standard- und
Drop-D-Stimmung und schätzt dabei Effizienz. Sie kommuniziert per E-Mail,
Telefon und WhatsApp; als Musikerin nutzt sie bewusst Streaming-Plattformen,
die Künstler stärker vergüten als marktführende Dienste.

*Relevanz:* Matilda repräsentiert erfahrene Nutzerinnen, die schnelle Workflows
und die Unterstützung mehrerer Stimmungen priorisieren.

*Jonas -- Gitarrentechniker*

Jonas ist 45 Jahre alt und arbeitet seit 18 Jahren als Gitarrentechniker in
einem Musikfachgeschäft. Er wartet, repariert und stimmt täglich Instrumente
verschiedener Kunden -- darunter regelmäßig Gitarren mit Floyd-Rose-Brücke.

Er verfügt über tiefgehendes technisches Fachwissen zu Gitarren aller Bauarten
und ist mit englischsprachiger Fachterminologie vertraut. Zeiteffizienz hat für
ihn höchste Priorität, da er unter Umständen mehrere Floyd-Rose-Gitarren pro
Tag stimmen muss. Er ist gegenüber neuen Werkzeugen aufgeschlossen, sofern sie
seinen Workflow beschleunigen und zuverlässig funktionieren.

*Relevanz:* Jonas repräsentiert professionelle Anwender im gewerblichen Umfeld,
für die die Applikation den größten messbaren Effizienzgewinn liefert.

*Hanna -- Home-Producerin*

Hanna ist 30 Jahre alt und betreibt ein eigenes Heimstudio, in dem sie
regelmäßig Bands aufnimmt und mischt -- darunter die Band "Fire Hawks". Sie
arbeitet mit der _DAW Bitwig_ und ist mit _CLAP-_ und _VST-Plugin-Formaten_ sowie
den Grundlagen der digitalen Signalverarbeitung vertraut. Darüber hinaus
programmiert sie eigenständig und verfügt über hochpräzise
Frequenzmessmöglichkeiten in ihrer Studioumgebung.

Im Aufnahmekontext begegnen ihr regelmäßig Gitarristinnen und Gitarristen mit
Floyd-Rose-Instrumenten. Da für eine qualitativ hochwertige Aufnahme eine
präzise Stimmung unerlässlich ist, hat der Stimmvorgang in der Vergangenheit
wiederholt Aufnahmesessions verzögert. Hanna ist mit einschlägiger
Fachterminologie aus Tontechnik und Gitarrenbau vertraut und erwartet von
Werkzeugen eine hohe Messgenauigkeit.

*Relevanz:* Hanna repräsentiert technisch versierte Nutzerinnen im
professionellen Aufnahmekontext, für die Präzision und Geschwindigkeit des
Stimmvorgangs direkte Auswirkungen auf den Produktionsablauf haben. Zudem
verfügen Nutzerinnen dieses Segments außerhalb der Applikation über
hochpräzise Messinstrumente, was eine entsprechend hohe Messgenauigkeit
voraussetzt.

=== Szenarien

*Szenario 1 -- Emils erster Versuch*

*Normaler Ablauf:*
Emil kommt nach einem langen Arbeitstag nach Hause und möchte zur Entspannung
Gitarre spielen. Über eine YouTube-Empfehlung wird er auf die Applikation
aufmerksam und hofft, damit den Kauf einer neuen Gitarre vermeiden zu können.
Er lädt die App herunter, setzt sich mit der Gitarre auf den Boden seines
Wohnzimmers und legt das Smartphone vor sich.

Nach dem Start der Applikation kann er eine Zielstimmung sowie ein
Gitarrenprofil auswählen. Da noch kein Profil existiert, legt er über einen
prominenten Button eine neue Gitarre an und benennt sie "Onkel Ullies Gitarre".
Anschließend gelangt er in den Kalibrierungsmodus, in dem er aufgefordert wird,
jede Saite einzeln anzuspielen. Daraufhin wird er gebeten, die E2-Saite gezielt
zu verstimmen und alle Saiten erneut zu messen. Eine Fortschrittsanzeige
informiert ihn über die verbleibenden Messschritte. Nach Abschluss der
Kalibrierung ist das Gitarrenprofil angelegt.

Im anschließenden Stimmvorgang misst Emil zunächst den aktuellen Zustand der
Gitarre. Die App zeigt ihm daraufhin für jede Saite eine visuelle Zielanzeige,
anhand derer er die Saite in den grünen Bereich stimmt. Nach Abschluss aller
Saiten wird ihm im integrierten Stimmgerät bestätigt, dass die Gitarre korrekt
gestimmt ist.

*Mögliche Fehler und Lösungsansätze:*

+ *Falsche Stimmung gewählt:* Emil wählt versehentlich eine unbekannte Stimmung
  aus und ist anschließend verwirrt, da die Gitarre nicht dem erwarteten Klang
  entspricht. Da Emil textbasierte Erklärungen meidet, sollte ein kurzes
  Erklärvideo zur Verfügung stehen; ergänzend kann ein knapper Infotext
  eingeblendet werden.

+ *Unbekannte Saitenbezeichnungen:* Emil ist mit den Bezeichnungen E2, A2, D3,
  G3, B3 und E4 nicht vertraut. Auch hier bietet ein kurzes Demonstrationsvideo
  den geeigneten Einstieg.

+ *Schwierigkeiten bei der Frequenzeingabe:* Emil weiß nicht, wie er die
  Frequenz einer Saite in die App einträgt. Ein Anleitungsvideo, das den
  Messvorgang vorführt, ermöglicht ihm ein einfaches Nachahmen.

+ *Falsche Saite verstimmt:* Emil verstimmt versehentlich die falsche Saite,
  ohne es zu bemerken. Die Applikation sollte anhand der gemessenen Frequenzen
  automatisch erkennen, ob die korrekte Saite verstimmt wurde, und den Nutzer
  gegebenenfalls zur Wiederholung auffordern.

+ *Frequenz nicht erkennbar:* Die Gitarre wird zu leise angespielt, sodass das
  Mikrofon -- insbesondere bei tiefen Saiten -- kein zuverlässiges Signal
  erfasst. In diesem Fall werden häufig harmonische Obertöne gemessen; die App
  sollte durch Rückrechnung die Grundfrequenz ableiten und eine
  Plausibilitätsprüfung anhand des erwarteten Frequenzbereichs durchführen.

+ *Defektes Mikrofon:* Das Mikrofon des Endgeräts ist nicht funktionsfähig.
  Als Fallback sollte die manuelle Eingabe von Frequenzwerten über ein
  Textfeld ermöglicht werden.

*Szenario 2 -- Matilda auf einer Jam-Session*

*Normaler Ablauf:*
Matilda spielt auf einer Jam-Session und möchte für den nächsten Auftritt die
Stimmung ihrer Gitarre wechseln. Sie öffnet die App, wählt die gewünschte
Zielstimmung Drop-D sowie ihr gespeichertes Gitarrenprofil aus und startet den
Stimmvorgang. Da die Umgebung laut ist, benötigt sie mehrere Versuche, um
stabile Frequenzmessungen zu erhalten. Nach erfolgreichem Abschluss aller
Saiten ist die Gitarre korrekt gestimmt.

*Mögliche Fehler und Lösungsansätze* (ergänzend zu Szenario 1):

+ *Störgeräusche unterbrechen die Messung:* Hintergrundgeräusche führen dazu,
  dass kontinuierlich neue Frequenzwerte erkannt werden, ohne dass eine Saite
  angespielt wurde. Über einen einstellbaren Lautstärkeschwellenwert -- etwa
  einen Schieberegler in den Einstellungen -- kann die Empfindlichkeit des
  Mikrofons so angepasst werden, dass Messungen nur ausgelöst werden, wenn die
  Lautstärke der gespielten Saite den Umgebungspegel deutlich übersteigt.


=== Anforderungen

Auf Basis der Projektvision, des System- und Anwendungskontexts sowie der
erstellten Personas und Anwendungsszenarien wurden funktionale und
nicht-funktionale Anforderungen an die Applikation abgeleitet. Wie in
@mobileAppEngineering empfohlen, werden diese nach _MUSS_- und _SOLL_-Kriterien
sowie nach der Wertigkeit gemäß Kano-Modell priorisiert. Anforderungen mit
hohem Wert und hohem Ausfallrisiko erhalten dabei die höchste Priorität,
gefolgt von Anforderungen mit hohem Nutzen bei geringem Risiko. Anforderungen
mit geringem Nutzen und geringem Risiko werden zuletzt eingestuft. Dies folgt
aus @mobileAppEngineering und der sogenannten _Wert-Risiko-Matrix_@Cohn2004.

*Funktionale Benutzeranforderungen*

#req("FBA-01", "MUSS", [Ein Nutzer muss eine Floyd-Rose-Gitarre effizient stimmen können.]) <req-fba-01>
#req("FBA-02", "MUSS", [Ein Nutzer muss die App auf seine Gitarre kalibrieren können.]) <req-fba-02>
#req("FBA-03", "MUSS", [Ein Nutzer muss die Kalibrierung mehrerer Gitarren langfristig speichern können.]) <req-fba-03>
#req("FBA-04", "MUSS", [Ein Nutzer muss den aktuellen Stimmzustand seiner Gitarre messen können.]) <req-fba-04>
#req(
  "FBA-05",
  "MUSS",
  [Ein Nutzer muss die Empfindlichkeit der Frequenzmessung einstellen können, um die App in geräuschbelasteten Umgebungen zuverlässig nutzen zu können.],
) <req-fba-05>

#req("FBA-06", "MUSS", [Ein Nutzer muss Hilfe zur Bedienung der App erhalten können.]) <req-fba-06>

#req(
  "FBA-07",
  "MUSS",
  [Ein Nutzer muss die Korrektheit einer Messung überprüfen können, sofern dies nicht bereits automatisch durch die App erfolgt.],
) <req-fba-07>

#req("FBA-08", "MUSS", [Ein Nutzer muss fehlerhafte Messungen korrigieren können.]) <req-fba-08>

#req(
  "FBA-09",
  "SOLL",
  [Ein Nutzer sollte unterschiedliche Stimmungen für den Stimmprozess auswählen können.],
) <req-fba-09>

#req(
  "FBA-10",
  "SOLL",
  [Ein Nutzer sollte die Stimmung seiner Gitarre mithilfe eines herkömmlichen Stimmgeräts auf Richtigkeit prüfen können.],
) <req-fba-10>

#req("FBA-11", "SOLL", [Ein Nutzer sollte die App auf seine Gitarre rekalibrieren können.]) <req-fba-11>

#req("FBA-12", "SOLL", [Ein Nutzer sollte Kalibrierungen einen benutzerdefinierten Namen vergeben können.]) <req-fba-12>

#req("FBA-13", "SOLL", [Ein Nutzer sollte eigene Stimmungen erstellen, bearbeiten und löschen können.]) <req-fba-13>

#req(
  "FBA-14",
  "SOLL",
  [Ein Nutzer sollte Messungen auch manuell mit externen Hilfsmitteln (z.~B. einem separaten Frequenzmessgerät) vornehmen und die Werte eintragen können.],
) <req-fba-14>

#req(
  "FBA-15",
  "SOLL",
  [Ein Nutzer sollte nicht allgemein bekannte Begriffe -- insbesondere Stimmungsbezeichnungen und Saitennamen -- nachvollziehen können.],
) <req-fba-15>
#req(
  "FBA-16",
  "SOLL",
  [Ein Nutzer sollte die Präzision des Stimmungsprozesses erhöhen können],
) <req-fba-16>
*Funktionale Systemanforderungen*

#req(
  "FSA-01",
  "MUSS",
  [Das System muss die Grundfrequenz einer angespielten Saite mittels YIN-Algorithmus in Echtzeit schätzen.],
) <req-fsa-01>

#req(
  "FSA-02",
  "MUSS",
  [Das System muss Frequenzmessungen nur durchführen, wenn der Schalldruckpegel des Eingangssignals einen konfigurierbaren dBFS-Schwellenwert überschreitet.],
) <req-fsa-02>

#req(
  "FSA-03",
  "MUSS",
  [Das System muss nach einer vollständigen Zustandsmessung aller Saiten ($arrow(f)_0$) für jede Saite $N$ die absolute Zielfrequenz gemäß
    $
      f_N = f_"0,N" + sum_(i=1)^(N) Delta_i dot C_(N\,i)
    $
    berechnen.],
) <req-fsa-03>

#req(
  "FSA-04",
  "MUSS",
  [Das System muss sicherstellen, dass Saiten stets in der Reihenfolge E2 $arrow$ A2 $arrow$ D3 $arrow$ G3 $arrow$ B3 $arrow$ E4 gestimmt werden, sodass die Verstimmungseinflüsse bereits gestimmter Saiten in die Zielfrequenz nachfolgender Saiten einfließen.],
) <req-fsa-04>

#req(
  "FSA-05",
  "MUSS",
  [Das System muss einen gleitenden Mittelwert über die letzten $N$ Messwerte berechnen und zur Anzeige verwenden, um kurzfristige Ausreißer zu dämpfen.],
) <req-fsa-05>

#req(
  "FSA-06",
  "MUSS",
  [Das System muss den Frequenzbereich der Schätzung auf näherungsweise 50 Hz bis 350 Hz begrenzen.],
) <req-fsa-06>

#req(
  "FSA-07",
  "MUSS",
  [Das System muss bei der Kalibrierung für jede Saite $j$ mindestens zwei Messpunkte erfassen und daraus den Eintrag $C_(i,j)$ der Verstimmungsmatrix mittels orthogonaler Regression (Deming-Regression) schätzen.],
) <req-fsa-07>

#req(
  "FSA-08",
  "MUSS",
  [Das System muss die Diagonalelemente $C_(i i) = 1$ der Verstimmungsmatrix ohne Messung als bekannt voraussetzen.],
) <req-fsa-08>

#req(
  "FSA-09",
  "MUSS",
  [Das System muss bei der Kalibrierung automatisch prüfen, ob die vom Nutzer verstimmte Saite der geforderten Saite entspricht, und bei Abweichung die Messung verwerfen und den Schritt wiederholen.],
) <req-fsa-09>

#req(
  "FSA-10",
  "MUSS",
  [Das System muss die gitarrenspezifische Verstimmungsmatrix $C$ persistent auf dem Gerät speichern und beim nächsten Start wiederherstellen.],
) <req-fsa-10>

#req(
  "FSA-11",
  "MUSS",
  [Das System muss die Funktionalität eines Standard-Stimmgeräts anbieten, um die Korrektheit der Stimmung zu verifizieren.],
) <req-fsa-11>

#req(
  "FSA-12",
  "SOLL",
  [Das System sollte bei einer gemessenen Frequenz, die einem harmonischen Oberton entspricht, durch Halbierung auf die Grundfrequenz rückschließen und den Wert anhand des erwarteten Frequenzbereichs der jeweiligen Saite plausibilisieren.],
) <req-fsa-12>

#req(
  "FSA-13",
  "SOLL",
  [Das System sollte für jedes Gitarrenprofil einen benutzerdefinierten Namen persistent speichern und beim Laden anzeigen.],
) <req-fsa-13>

#req(
  "FSA-14",
  "SOLL",
  [Das System sollte vordefinierte Stimmungen (mindestens Standard-E und Drop-D) als unveränderliche Referenzwerte bereitstellen.],
) <req-fsa-14>

#req(
  "FSA-15",
  "SOLL",
  [Das System sollte benutzerdefinierte Stimmungen persistent speichern, bearbeiten und löschen können.],
) <req-fsa-15>

#req(
  "FSA-16",
  "SOLL",
  [Das System sollte das Erfassen von mehr als zwei Messpunkten pro Saite
    ermöglichen, um die Schätzgenauigkeit der Verstimmungsmatrix durch
    zusätzliche Stützstellen für die Deming-Regression zu erhöhen.],
) <req-fsa-16>

*Nichtfunktionale Anforderungen*

*Messgenauigkeit*

#req(
  "NFA-MG-01",
  "MUSS",
  [Das System muss die Grundfrequenz einer Gitarrensaite mit einer Abweichung von maximal $±5 "Cent"$ vom wahren Wert schätzen, gemessen unter kontrollierten akustischen Bedingungen.],
) <req-nfa-mg-01>

#req(
  "NFA-MG-02",
  "MUSS",
  [Das System muss harmonische Obertöne von der Grundfrequenz unterscheiden und darf diese nicht als Grundfrequenz ausgeben, sofern der Signalpegel des Grundtons den Schwellenwert überschreitet.],
) <req-nfa-mg-02>

#req(
  "NFA-MG-03",
  "SOLL",
  [Das System sollte auch bei unverstärktem Spiel eine Messgenauigkeit von $±5 "Cent"$ einhalten.],
) <req-nfa-mg-03>

*Latenz*

#req(
  "NFA-LA-01",
  "MUSS",
  [Das System muss die visuelle Zielanzeige innerhalb von 100 ms nach Eingang eines stabilen Messwerts aktualisieren, sodass der Nutzer beim Stimmen unmittelbares Feedback erhält.],
) <req-nfa-la-01>

#req(
  "NFA-LA-02",
  "MUSS",
  [Das System muss die Berechnung der Zielfrequenzen aller sechs Saiten nach Abschluss der Zustandsmessung in unter 500 ms abschließen.],
) <req-nfa-la-02>

*Robustheit*

#req(
  "NFA-RO-01",
  "MUSS",
  [Das System muss bei Umgebungsgeräuschen bis zu einem Pegel von $70 "dB(A)"$ stabile Frequenzmessungen liefern, sofern der Schallpegel der gespielten Saite den Umgebungspegel um mindestens $10 "dB"$ übersteigt.],
) <req-nfa-ro-01>

#req(
  "NFA-RO-02",
  "MUSS",
  [Das System darf bei Stille oder reinem Umgebungslärm keine Frequenzschätzung ausgeben und muss in diesem Zustand die Zielanzeige nicht aktualisieren.],
) <req-nfa-ro-02>

#req(
  "NFA-RO-03",
  "MUSS",
  [Das System muss bei einem nicht funktionsfähigen Mikrofon in einen Fallback-Modus wechseln und den Nutzer darüber informieren.],
) <req-nfa-ro-03>

*Bedienbarkeit*

#req(
  "NFA-BE-01",
  "MUSS",
  [Das System muss so gestaltet sein, dass ein Nutzer ohne Vorkenntnisse im Umgang mit Floyd-Rose-Gitarren den vollständigen Erststart -- Kalibrierung und erster Stimmvorgang -- ohne externe Hilfe abschließen kann.],
) <req-nfa-be-01>

#req(
  "NFA-BE-02",
  "MUSS",
  [Das System muss alle zentralen Aktionen (Profil auswählen, Stimmvorgang starten, Messung auslösen) mit maximal drei Interaktionen erreichbar machen.],
) <req-nfa-be-02>

#req(
  "NFA-BE-03",
  "SOLL",
  [Das System sollte Bedienabläufe durch visuelle Mittel (Illustrationen, Animationen) vermitteln und auf rein textbasierte Anleitungen verzichten, wo visuelle Alternativen verfügbar sind.],
) <req-nfa-be-03>

#req(
  "NFA-BE-04",
  "SOLL",
  [Das System sollte kurze Erklärvideos zu Saitenbezeichnungen, Stimmungswahl und Messvorgang bereitstellen.],
) <req-nfa-be-04>

#pagebreak()
*Kompatibilität*

#req(
  "NFA-KO-01",
  "MUSS",
  [Das System muss auf iOS (ab Version 16) und Android (ab Version 10) lauffähig sein.],
) <req-nfa-ko-01>

#req(
  "NFA-KO-02",
  "MUSS",
  [Das System muss auf Geräten mit einem Arbeitsspeicher von mindestens 2 GB ohne merkbare Leistungseinbußen betrieben werden können.],
) <req-nfa-ko-02>

#req(
  "NFA-KO-03",
  "SOLL",
  [Das System sollte auf gängigen Gerätegrößen (4,7 Zoll bis 6,7 Zoll Bildschirmdiagonale) ohne Layoutbrüche dargestellt werden.],
) <req-nfa-ko-03>

*Datenschutz und Betrieb*

#req(
  "NFA-DP-01",
  "MUSS",
  [Das System darf keine Nutzerdaten, Audiodaten oder Gitarrenprofile an externe Server übermitteln; alle Daten verbleiben ausschließlich lokal auf dem Endgerät.],
) <req-nfa-dp-01>

#req(
  "NFA-DP-02",
  "MUSS",
  [Das System muss ohne aktive Internetverbindung vollständig funktionsfähig sein.],
) <req-nfa-dp-02>

#req(
  "NFA-DP-03",
  "SOLL",
  [Das System sollte gespeicherte Gitarrenprofile und Stimmungen bei einer Neuinstallation durch ein Export-/Importformat wiederherstellbar machen.],
) <req-nfa-dp-03>

*Ausgeschlossene Anforderungen*

Die folgenden Anwendungsfälle liegen explizit außerhalb des definierten
Projektumfangs und werden nicht berücksichtigt:

- Integration in professionelle Musikstudio-Umgebungen
- Verwendbarkeit als Plugin für Digital Audio Workstations (DAW)
- Netzwerkbasierte Funktionen wie Cloud-Synchronisation oder
  Mehrgeräte-Unterstützung

*Hinweis*

Da ein vollständiges Anforderungsdokument den Rahmen dieser Bachelorarbeit
sprengen würde, wurde auf Formalien wie Projekteam- und Rollenbeschreibung,
_Storyboards_, _UML-Anwendungsfalldiagramme_, _Anwendungsfallschablonen_,
ausformulierte _User Stories_ sowie die Einhaltung von
Barrierefreiheitsstandards und weiteren Normen verzichtet.



=== Entwicklungsparadigma
Die Applikation richtet sich gemäß @req-nfa-ko-01 an Nutzer beider
marktführenden mobilen Betriebssysteme -- iOS und Android. Eine native
Entwicklung für jede Plattform separat würde bedeuten, dieselbe
Fachlogik -- insbesondere den YIN-Algorithmus (@req-fsa-01), die
Berechnung der Verstimmungsmatrix (@req-fsa-07) sowie die
Zielfrequenzformel (@req-fsa-03) -- doppelt zu implementieren und zu
warten.

Da die Applikation gemäß @req-nfa-dp-01 und @req-nfa-dp-02 vollständig
lokal und ohne Netzwerkzugriff betrieben wird, entfallen die
Hauptargumente gegen Cross-Platform-Ansätze: Es gibt keine
plattformspezifischen Push-Benachrichtigungen, keine hardwarenahen
Hintergrunddienste und keine nativen Zahlungsschnittstellen. Der einzige
plattformnahe Zugriff -- das Gerätemikrofon -- gehört zu den am weitesten
verbreiteten hardwarenahen Features mobiler Geräte und wird von allen
gängigen Cross-Compiling-Frameworks über eine stabile,
plattformübergreifende API abgedeckt. Der Effizienzgewinn einer
gemeinsamen Codebasis überwiegt daher den Mehraufwand einer rein nativen
Implementierung deutlich.

== Konzeption und Design
=== Informationsarchitektur

#figure(
  image("assets/infoarch.png"),
  caption: [Informationsarchitektur der Floyd-Rose-Tuner-App],
) <infArch>

@infArch zeigt die Informationsarchitektur der App. Den zentralen
Einstiegspunkt bildet der Startbildschirm, von dem aus alle
wesentlichen Funktionen erreichbar sind:

+ *Hilfe* -- kontextsensitive Unterstützung zur Bedienung (@req-fba-06)
+ *Gitarre auswählen* -- Laden eines gespeicherten Gitarrenprofils für
  den Stimmvorgang (@req-fba-03)
+ *Standard-Stimmgerät* -- konventionelles chromatisches Stimmgerät zur
  schnellen Überprüfung der Stimmung ohne Floyd-Rose-Logik (@req-fba-10)
+ *Stimmung auswählen* -- Zielstimmung für den Stimmprozess festlegen
  (@req-fba-09)
+ *Gitarre anlegen* -- neues Gitarrenprofil erstellen; relevant
  insbesondere für Persona Jonas (@hanna), der täglich neue
  Instrumente stimmt (@req-fba-02)
+ *Floyd-Rose-Stimmen* -- Kernfunktion der App (@req-fba-01)

Wird eine bestehende Gitarre ausgewählt, stehen zusätzlich die Aktionen
_Umbenennen_, _Rekalibrieren_ (@req-fba-11) und _Löschen_ zur
Verfügung. Wird eine neue Gitarre angelegt, durchläuft der Nutzer
unmittelbar die Benennung und den Kalibrierungsvorgang (@req-fba-12,
@req-fba-02).
=== Interaktionsdesign

Für die Erstellung des Interaktionsdesigns wurde die grafische Sprache
_Visuelles Vokabular_ nach @Garrett2012 verwendet. Die resultierenden
Diagramme sind in @iiakt1, @iiakt2 und @iiakt3 dargestellt.

*Navigation*

#figure(
  image("assets/interaktionsdesign.png", height: 30%),
  caption: [Interaktionsdesign -- Navigation],
) <iiakt1>

Den Einstiegspunkt bildet die Floyd-Rose-Initiierungsseite, von der aus
der Nutzer die Hilfeseite, das Standard-Stimmgerät, die Gitarrenansicht
sowie den Stimmprozess erreichen kann.

Vom Standard-Stimmgerät aus ist es möglich, direkt in die Kalibrierung
der aktuell ausgewählten Gitarre zu wechseln, falls das Ergebnis nicht
den Erwartungen entspricht (@req-fba-11). Auf der Gitarrenansichtsseite
kann die Gitarre umbenannt (@req-fba-12) und rekalibriert werden.

*Kalibrierung*

#figure(
  image("assets/interaktionsdesign2.png", height: 30%),
  caption: [Interaktionsdesign -- Kalibrierung],
) <iiakt2>

Der Kalibrierungsvorgang nutzt drei Seiten, die in einem festgelegten
Ablauf durchlaufen werden.

*Seite 1 -- Saite messen* und *Seite 2 -- Messung prüfen* wechseln sich
ab, bis alle sechs Saiten gemessen sind. So wird der Ausgangszustand der
Gitarre als erster Messpunkt erfasst (@req-fsa-07).

Anschließend folgt *Seite 3 -- Saite verändern*: Der Nutzer verstimmt
eine bestimmte Saite. Daraufhin wechseln sich Seite 1 und Seite 2 erneut
ab, bis alle sechs Saiten gemessen sind und der Einfluss der Verstimmung
auf die übrigen Saiten erfasst ist. Der zuletzt gemessene Zustand dient
dabei jeweils als Ausgangslage für die folgende Verstimmung. Dieser
Vorgang wiederholt sich für jede der sechs Saiten (@req-fsa-07,
@req-fsa-09).

Sobald alle Messpunkte erfasst sind, kann der Nutzer sämtliche Messdaten
in einer Gesamtübersicht einsehen und fehlerhafte Einträge korrigieren
(@req-fba-08), bevor die Kalibrierung abgeschlossen wird.

*Stimmen*

#figure(
  image("assets/interaktionsdesign3.png", height: 30%),
  caption: [Interaktionsdesign -- Stimmprozess],
) <iiakt3>

Der Stimmprozess folgt einem ähnlichen Ablauf wie die Kalibrierung.
Zunächst spielt der Nutzer jede Saite einzeln an; nach jeder Messung
kann er den erfassten Wert auf einer Bestätigungsseite prüfen. Sobald
alle sechs Saiten gemessen sind, berechnet das System die individuellen
Zielfrequenzen gemäß @req-fsa-03 und führt den Nutzer saitenweise
durch den Stimmvorgang, bis die Gitarre korrekt gestimmt ist
(@req-fba-01).

=== Visuelles Konzept

Da die App in der Entwicklungsphase primär auf Android getestet wird,
werden die Gestaltungsrichtlinien von Google -- das Material-3-Designsystem
@material3 -- als visuelle Grundlage verwendet. Material 3 definiert
verbindliche Standards für Typografie, Farbschemata, Icons,
Interaktionszustände von Komponenten sowie Navigationsstrukturen und
gewährleistet damit eine plattformkonforme, konsistente Darstellung
(@req-nfa-ko-03).

Für Konzeption und
UI-Design wird Figma#footnote[https://www.figma.com/] eingesetzt, das ebenfalls ein offizielles
Material-3-Komponentenset bereitstellt und so einen konsistenten
Übergang vom Entwurf zur Implementierung ermöglicht.

=== Prototypen

Die App wurde zunächst als vertikaler Prototyp entwickelt, um frühzeitig
zu überprüfen, ob @req-fba-01 -- das erfolgreiche Stimmen einer
Floyd-Rose-Gitarre -- grundsätzlich umsetzbar ist. Im Anschluss wurde
die Benutzeroberfläche iterativ überarbeitet, um die App auch für
weniger technisch versierte Nutzer zugänglich zu machen (@req-nfa-be-01).

@protCreateGuita zeigt einen frühen Prototyp der Kalibrierungsseite,
der trotz technischer Funktionsfähigkeit eine hohe Informationsdichte
aufwies und Testpersonen überforderte. In @protoCalib ist die
überarbeitete Version zu sehen, in der die Oberfläche deutlich
vereinfacht und die Nutzerführung strukturiert wurde.

#grid(
  columns: 2,
  inset: 6pt,
  grid.cell([
    #figure(
      image("assets/prototyp_create_guitar.png", height: 30%),
      caption: [Früher vertikaler Prototyp der \ Kalibrierungsansicht],
    ) <protCreateGuita>
  ]),
  grid.cell([
    #figure(
      image("assets/prototyp_calibration.png", height: 30%),
      caption: [Überarbeiteter Prototyp: \ Kalibrierungsansicht],
    ) <protoCalib>
  ]),
)

=== Wireframes

Auf Basis der Informationsarchitektur und des Interaktionsdesigns wurden
Wireframes erstellt, um die Benutzeroberfläche zu konkretisieren und optimieren (@wfLanding bis @wfStandardTuner).

#grid(
  columns: 3,
  inset: 6pt,
  grid.cell([
    #figure(
      image("assets/wf_landing.png", height: 25%),
      caption: [Wireframe: \ Startseite],
    ) <wfLanding>
  ]),
  grid.cell([
    #figure(
      image("assets/wf_gitarren_editierung.png", height: 25%),
      caption: [Wireframe: \ Gitarre bearbeiten],
    ) <wfGitarreEdit>
  ]),
  grid.cell([
    #figure(
      image("assets/wf_kalibrierung1.png", height: 25%),
      caption: [Wireframe: Kalibrierung -- Saite messen],
    ) <wfKalMessen>
  ]),
)

@wfLanding zeigt die Startseite, deren Struktur der Informationsarchitektur
aus @infArch folgt. Über eine Bottom-Tab-Navigation sind die Hilfsseite
und das Standard-Stimmgerät jederzeit erreichbar. Auf der Startseite
selbst kann der Nutzer eine Zielstimmung sowie ein Gitarrenprofil
auswählen. Gemäß dem Nutzungsszenario von Jonas (@hanna) ist zudem
das direkte Anlegen einer neuen Gitarre prominent platziert. Ein großer
Stimmen-Button leitet den Floyd-Rose-Stimmprozess ein (@req-fba-01).

@wfGitarreEdit zeigt die Bearbeitungsansicht einer gespeicherten
Gitarre. Von hier aus kann der Nutzer das Profil umbenennen (@req-fba-12),
löschen sowie die Kalibrierung starten (@req-fba-11).
@wfKalMessen zeigt den ersten Schritt der Kalibrierung. Am oberen Rand
informiert ein Fortschrittsindikator über den aktuellen Stand. Darunter
wird der Nutzer aufgefordert, eine bestimmte Saite anzuspielen; die
laufende Frequenzmessung wird unmittelbar darunter visualisiert. Ein
Weiter-Button führt zu @wfKalPrüf.



#grid(
  columns: 3,
  inset: 6pt,
  grid.cell([
    #figure(
      image("assets/wf_kalibrierung2.png", height: 25%),
      caption: [Wireframe: \ Kalibrierung -- Messung prüfen],
    ) <wfKalPrüf>
  ]),
  grid.cell([
    #figure(
      image("assets/wf_kalibrierung3.png", height: 25%),
      caption: [Wireframe: \ Kalibrierung -- \ Saite verstimmen],
    ) <wfKalVerändern>
  ]),
  grid.cell([
    #figure(
      image("assets/wf_check_kalibrierung.png", height: 25%),
      caption: [Wireframe: \ Kalibrierung -- \ Gesamtübersicht],
    ) <wfKalib>
  ]),
)

Dort kann der Nutzer die erfasste Messung überprüfen. Anstelle einer
numerischen Frequenzanzeige -- die in den Nutzertests zu Verwirrung
führte (@nutzerTests, Nutzer 3) -- ist ein Button vorgesehen, der einen
Ton in der gemessenen Frequenz abspielt. So kann der Nutzer auditiv
beurteilen, ob die richtige Frequenz erkannt wurde, ohne Zahlenwerte
interpretieren zu müssen (@req-fba-07). Bei einer fehlerhaften Messung
kann er den Schritt wiederholen.
Sind alle Saiten gemessen, führt das Interaktionsdesign (@iiakt2) zur
nächsten Phase: @wfKalVerändern fordert den Nutzer auf, eine bestimmte
Saite zu verstimmen. Ein visuelles Feedback-Element soll dabei
bestätigen, dass die Verstimmung erkannt wurde (@req-fsa-09).

Nach Abschluss aller Messreihen gelangt der Nutzer zu @wfKalib, einer
Gesamtübersicht aller erfassten Messwerte. Von hier aus können einzelne
Messungen gezielt korrigiert und die entsprechende Stelle im
Kalibrierungsablauf direkt angesprungen werden (@req-fba-08).

#grid(
  columns: 3,
  inset: 6pt,
  grid.cell([
    #figure(
      image("assets/wf_hilfe_page.png", height: 30%),
      caption: [Wireframe: Hilfsseite],
    ) <wfHelp>
  ]),
  grid.cell([
    #figure(
      image("assets/wf_standard_tuner.png", height: 30%),
      caption: [Wireframe: Standard-Stimmgerät],
    ) <wfStandardTuner>
  ]),
)

@wfHelp und @wfStandardTuner zeigen den Aufbau der Hilfsseite
(@req-fba-06, @req-nfa-be-04) sowie des Standard-Stimmgeräts
(@req-fsa-11, @req-fba-10), das unabhängig vom Floyd-Rose-Algorithmus
zur schnellen Überprüfung der Stimmung genutzt werden kann.
=== Design

*Onboarding*

#grid(
  columns: 3,
  inset: 6pt,
  grid.cell([
    #figure(
      image("assets/d_help.png", height: 30%),
      caption: [Design: \ Hilfsseite],
    ) <dHelp>
  ]),
  grid.cell([
    #figure(
      image("assets/d_setup.png", height: 30%),
      caption: [Design: Startseite],
    ) <dLanding>
  ]),
  grid.cell([
    #figure(
      image("assets/d_gitarre.png", height: 30%),
      caption: [Design: Gitarre \ bearbeiten],
    ) <dGitarreEdit>
  ]),
)

Beim ersten Start der App wird der Nutzer auf die Hilfsseite (@dHelp)
geleitet, die eine Übersicht der App-Funktionen sowie einen Link zu
einem Tutorial-Video enthält (@req-fba-06, @req-nfa-be-04). Von dort
gelangt er zur Startseite (@dLanding), die bei allen folgenden Starts
direkt angezeigt wird. Bereits gespeicherte Gitarrenprofile und
Stimmungen sind vorausgewählt; ein prominenter "Start Tuning"-Button
leitet den Stimmvorgang unmittelbar ein (@req-fba-01).

Über "Add A New Guitar" legt der Nutzer ein neues Gitarrenprofil an und
gelangt zur Gitarrenansicht (@dGitarreEdit). Dort wird vorab ein Name
mit zufälliger ID generiert, der frei angepasst werden kann
(@req-fba-12). Der "Calibrate This Guitar"-Button ist mit einem Badge
versehen und zieht damit die Aufmerksamkeit des Nutzers auf sich; der
begleitende Hinweistext "This Guitar Needs Calibration" macht den
nächsten Schritt unmissverständlich deutlich (@req-nfa-be-01). Ein Klick
auf den Button startet sofort den Kalibrierungsvorgang.

*Kalibrierung*

#grid(
  columns: 3,
  inset: 6pt,
  grid.cell([
    #figure(
      image("assets/d_cal_m.png", height: 25%),
      caption: [Design: \ Kalibrierung -- Saite messen],
    ) <dKalMessen>
  ]),
  grid.cell([
    #figure(
      image("assets/d_manualdetect.png", height: 25%),
      caption: [Design: Manuelle Frequenzeingabe],
    ) <dManDet>
  ]),
  grid.cell([
    #figure(
      image("assets/d_cal_check.png", height: 25%),
      caption: [Design: \ Kalibrierung -- Messung prüfen],
    ) <dKalPrüf>
  ]),
)

@dKalMessen zeigt die Messseite. Ein Empfindlichkeitsregler mit
Live-Lautstärkeanzeige erlaubt die Anpassung des Mikrofonschwellenwerts
(@req-fba-05). Eine Checkbox "Auto Detect" steuert
den Erkennungsmodus: Wird sie deaktiviert, erscheint ein Textfeld, in
das der Nutzer eine extern gemessene Frequenz manuell eintragen kann
(@dManDet, @req-fba-14). Sobald eine Frequenz erkannt oder eingetragen
wurde, führt "Continue" zur Prüfseite.

Auf der Prüfseite (@dKalPrüf) befindet sich zentral und gut erreichbar
ein "Play Sound"-Button, der die erkannte Frequenz als Ton abspielt.
Der begleitende Text fragt den Nutzer, ob der abgespielte Ton mit dem
zuvor gespielten übereinstimmt. Bei Nein kehrt er zur Messseite zurück
und wiederholt die Aufnahme; bei Ja wird die nächste Saite gemessen
(@req-fba-07, @req-fba-08).

#grid(
  columns: 3,
  inset: 6pt,
  grid.cell([
    #figure(
      image("assets/d_cal_cha.png", height: 25%),
      caption: [Design: \ Kalibrierung -- Saite \ verstimmen],
    ) <dKalVerändern>
  ]),
  grid.cell([
    #figure(
      image("assets/d_control.png", height: 25%),
      caption: [Design: \ Kalibrierung -- Gesamtübersicht],
    ) <dKalib>
  ]),
  grid.cell([
    #figure(
      image("assets/d_select_guit.png", height: 25%),
      caption: [Design: Gitarre \ auswählen],
    ) <dselect>
  ]),
)

@dKalVerändern fordert den Nutzer auf, eine bestimmte Saite zu
verstimmen. Für den Fall, dass versehentlich die falsche Saite verändert
wurde, steht ein "Wrong String Changed"-Button zur Verfügung, der den
Schritt zurücksetzt (@req-fsa-09). Nach dem Verstimmen bestätigt der
Nutzer mit "Done" und der Ablauf folgt dem Interaktionsdesign aus
@iiakt2.

Nach Abschluss aller Messreihen gelangt der Nutzer zur Gesamtübersicht
(@dKalib). Die obere Tab-Navigation zeigt die Saite, deren Verstimmung
das jeweilige Sample beschreibt; die untere Tab-Navigation wechselt
zwischen den einzelnen Messpunkten. Jedes Sample besteht aus sechs
Einträgen -- einem Frequenzwert pro Saite -- die auf zwei
Nachkommastellen gerundet angezeigt werden. Über "Done" wird die
Kalibrierung abgeschlossen und der Nutzer kehrt zur Startseite zurück
(@dLanding, @req-fba-08).

Möchte der Nutzer auf der Startseite (@dLanding) eine gespeicherte
Gitarre auswählen, öffnet sich eine Auswahlliste (@dselect). Jeder
Eintrag enthält ein Stift-Icon, über das der Nutzer direkt zur
Gitarrenansicht navigiert. Wurde eine Gitarre bereits kalibriert, zeigt
@drecal, dass der Kalibrierungsbutton weiterhin vorhanden, aber weniger
prominent gestaltet ist, um erfahrene Nutzer nicht zu bremsen
(@req-fba-11).
#grid(
  align: center,
  columns: 3,
  inset: 6pt,
  grid.cell([
    #figure(
      image("assets/d_recal.png", height: 35%),
      caption: [Design: \ Rekalibrieren],
    ) <drecal>
  ]),
  grid.cell([
    #figure(
      image("assets/d_fr_tuner.png", height: 35%),
      caption: [Design: \ Floyd-Rose-Tuner],
    ) <dFRTuner>
  ]),
  grid.cell([
    #figure(
      image("assets/d_standard_tuner.png", height: 35%),
      caption: [Design: \ Standard-Stimmgerät],
    ) <dStandardTuner>
  ]),
)



*Stimmvorgang*

Ein Klick auf "Start Tuning" führt zunächst durch dieselben Mess- und
Prüfseiten wie die Kalibrierung (@dKalMessen, @dKalPrüf), um den
aktuellen Zustand der Gitarre zu erfassen. Nach dem Messen aller sechs
Saiten wird der Nutzer zur Floyd-Rose-Tuner-Seite weitergeleitet
(@dFRTuner). Dort spielt er die angezeigte Saite an und stimmt sie, bis
der Slider in den grünen Zielbereich rückt. "Next" wechselt zur
nächsten Saite (@req-fba-01, @req-fsa-03, @req-fsa-04).

Nach dem Stimmen aller Saiten gelangt der Nutzer zum
Standard-Stimmgerät (@dStandardTuner), das die gespielte Note, die
Frequenz in Hertz sowie die Abweichung in Cent anzeigt und so eine
abschließende Überprüfung der Stimmung ermöglicht (@req-fsa-11,
@req-fba-10).

== Architektur

#figure(
  image("assets/architecture.png"),
  caption: [Architektur der App],
) <arch>

Die App folgt dem Architekturmuster _Model-View-ViewModel_ (MVVM). Dieses
Muster eignet sich besonders, weil das ViewModel die Schnittstelle
zwischen View und Model kapselt: Die UI kennt keine Implementierungsdetails
des Modells und das Modell ist unabhängig von der Darstellung. In
Verbindung mit Riverpod (@abhaengigkeiten) wird dieses Muster durch
sogenannte _Provider_ und _Notifier_ umgesetzt -- Provider stellen
lesenden Zugriff auf den Zustand bereit, Notifier ermöglichen dessen
Veränderung und benachrichtigen die UI automatisch über Änderungen,
sodass betroffene Widgets neu gerendert werden. Ein wesentlicher Vorteil
dieses Ansatzes ist, dass kein manuelles Prop-Passing durch den gesamten
Widget-Baum erforderlich ist.

*Audio Stream Provider*

Der Audio Stream Provider stellt einen kontinuierlichen Datenstrom der
Mikrofonaufnahme bereit. Der Datentyp ist ein `Stream<Int16List>`, der
die rohen PCM-Samples des Mikrofons als 16-Bit-Integer ausgibt und von
allen nachgelagerten Signalverarbeitungs-Providern konsumiert wird
(@req-fsa-01).

*Volume Stream Provider*

Abonniert den Audio Stream Provider  und berechnet den
Schalldruckpegel des Eingangssignals in dBFS gemäß @req-fsa-02. Der
Ausgabewert ist ein `Stream<double>` im Wertebereich
$[-60,0, 0,0]~"dBFS"$.

*Frequency Stream Provider*

Abonniert den Audio Stream Provider  und wendet den
YIN-Algorithmus @YIN auf den Audiodatenstrom an (@req-fsa-01). Die
Ausgabe ist ein `Stream<double>`, der die geschätzte Grundfrequenz in
Hertz liefert.

*Smoothed Frequency Provider*

Abonniert den Frequency Stream Provider und glättet die
eingehenden Messwerte durch einen gleitenden Mittelwert (@req-fsa-05),
um kurzfristige Ausreißer zu dämpfen. Die Ausgabe ist ein
`Stream<double>`.

*Volume Threshold Provider*

Liefert den konfigurierbaren Lautstärkeschwellenwert im Wertebereich
$[-60,0, 0,0]~"dBFS"$ (@req-fsa-02). Der Wert wird über den
Empfindlichkeits-Schieberegler in den Einstellungen gesteuert
(@req-fba-05).

*Detected Frequency Provider*

Kombiniert die Ausgaben des Smoothed Frequency Providers, des Volume
Stream Providers und des Volume Threshold Providers und liefert
die zuletzt erkannte Frequenz als `double`.

Ist manuelle Erkennung aktiviert (`manualDetection == true`), wird die
Frequenz ausschließlich über einen Notifier gesetzt -- etwa durch eine
Texteingabe (@req-fba-14). Andernfalls wird der aktuelle Wert des
Smoothed Frequency Providers übernommen, sofern der Schalldruckpegel
zum selben Zeitpunkt den Schwellenwert überschreitet (@req-fsa-02).

*String Measure State Provider*

Stellt das `StringMeasureState`-Objekt bereit, das den aktuellen
Fortschritt der saitenweisen Messung abbildet:

```dart
StringMeasureState {
  int currentStringIndex   // Index der aktuell zu messenden Saite (0–5)
  bool manualDetection     // Eingabemodus: automatisch oder manuell
}
```

*Guitar State Provider*

Repräsentiert den aktuellen Frequenzzustand aller sechs Saiten als
`List<double>` der Länge 6. Jeder Eintrag entspricht der zuletzt
gemessenen Frequenz der jeweiligen Saite. Dieser Provider bildet das
zentrale zustandstragende Modell während des Stimm- und
Kalibrierungsvorgangs und kann von beliebigen Widgets -- etwa über
Button-Interaktionen -- aktualisiert werden.


*Calibration State Provider*

Stellt das `CalibrationState`-Objekt bereit, das den Fortschritt
innerhalb der Kalibrierung verfolgt (@req-fsa-07):

```dart
CalibrationState {
  int currentEffectingStringIndex  // Index der aktuell verstimmten Saite
  int currentSampleIndex           // Index des aktuellen Messpunkts
}
```

*Guitars- und Selected-Guitar-Provider*

Der Guitars-Provider verwaltet die persistente Speicherung aller
`Guitar`-Objekte auf dem Gerät (@req-fsa-10, @req-fba-03). Der
Selected-Guitar-Provider hält das aktuell ausgewählte Profil vor.

Ein `Guitar`-Objekt ist wie folgt aufgebaut:

```dart
Guitar {
  String guitarName                      // Benutzerdefinierter Name (@req-fsa-13)
  List<List<double>> matrix              // Verstimmungsmatrix C
  List<List<double>> inverseMatrix       // Gecachte Inverse von C
  Map<int, List<GuitarState>> samples    // Rohmessdaten der Kalibrierung
}
```

`Guitar.samples` speichert alle Messpunkte, aus denen die
Verstimmungsmatrix berechnet wird (@req-fsa-07). Der erste Schlüssel
bezeichnet die verstimmte Saite, der zweite den Messpunkt-Index. So
entspricht `samples[1][2]` dem dritten erfassten Gitarrenzustand, als
Saite A2 (Index 1) verstimmt wurde -- also einem Frequenzvektor der
Form $[f_"E2", f_"A2", f_"D3", f_"G3", f_"B3", f_"E4"]$.

`matrix` und `inverseMatrix` lassen sich vollständig aus `samples`
ableiten, werden jedoch aus Performancegründen gecacht und gemeinsam
persistiert.

*Tunings- und Selected-Tuning-Provider*

Der Tunings-Provider verwaltet die persistente Speicherung aller
`Tuning`-Objekte (@req-fsa-14, @req-fsa-15). Der
Selected-Tuning-Provider hält die aktuell gewählte Stimmung vor.

Ein `Tuning`-Objekt ist wie folgt aufgebaut:

```dart
Tuning {
  String name               // Bezeichnung der Stimmung
  List<String> goalNotes    // Zielnoten im Format "E2", "A2", …
}
```

`Tuning.goalNotes` enthält die standardisierten Notenbezeichnungen im
Format _Note + Oktave_ (z.~B. `"E2"` für das E in der zweiten Oktave)
und definiert damit die Zielfrequenzen für den Stimmprozess (@req-fsa-03).
== Implementierung <impl>

=== Auswahl des Cross-Platform-Frameworks<auswahlflutter>

Da die App gemäß @req-nfa-ko-01 auf iOS und Android lauffähig sein muss,
wird ein Cross-Platform-Framework eingesetzt, um eine gemeinsame Codebasis
für beide Plattformen zu erhalten. Zur Auswahl standen React Native
@reactnative_dev, .NET MAUI @dotnet_maui und Flutter @flutter_dev.

*Umsetzungsgeschwindigkeit komplexer Anforderungen*

Flutter bietet mit seinem Widget-System und dem integrierten
Rendering-Stack eine durchgängige Abstraktionsebene, auf der sich
komplexe UI-Zustände -- wie die Echtzeit-Visualisierung der
Stimmgenauigkeit -- direkt und ohne Umwege über plattformspezifische
APIs umsetzen lassen. React Native erfordert bei komplexeren
Anforderungen häufiger den Rückgriff auf native Module oder externe
Bibliotheken, was den Entwicklungsaufwand erhöht. .NET MAUI zeigte in
eigenen Experimenten bei plattformübergreifenden UI-Komponenten
Inkonsistenzen, die zusätzlichen Abstimmungsaufwand erzeugten.

*Einstiegshürde*

Flutter verwendet die Programmiersprache Dart, die im Vergleich zu
JavaScript (React Native) oder C\# (.NET MAUI) zunächst eine
unbekanntere Wahl darstellt. In der Praxis erwies sich Dart jedoch als
schnell erlernbar: Die Sprache ist stark typisiert, die Dokumentation
vollständig und das Tooling -- insbesondere Hot Reload und die
IDE-Integration -- reduziert die Zeit bis zu ersten funktionierenden
Ergebnissen erheblich. Aus eigener Erfahrung war die Einstiegshürde bei
Flutter trotz der neuen Sprache geringer als bei .NET MAUI, dessen
Abstraktion über native Controls zu unerwartetem Verhalten und schwer
nachvollziehbaren Fehlern führte.

*Codestabilität*

Flutter kompiliert Ahead-of-Time (AOT) in nativen Code und umgeht damit
die Bridge-Architektur von React Native, die bei häufigem Datenaustausch
zwischen JavaScript- und nativer Ebene Laufzeitfehler und
Performance-Einbrüche verursachen kann. Da die App gemäß @req-fsa-01
kontinuierliche Frequenzmessungen in Echtzeit durchführt, ist ein
stabiler, vorhersehbarer Ausführungspfad ohne Kommunikations-Overhead
essenziell. Darüber hinaus reduziert Flutters geschlossenes Ökosystem --
im Gegensatz zu Reacts starker Abhängigkeit von externen Bibliotheken --
das Risiko inkompatibler Abhängigkeiten und erleichtert langfristige
Wartung.

*UI-Komponenten mit Material 3*

Flutter integriert Material 3 @material3 direkt als Teil des Frameworks,
ohne externe Abhängigkeit. Standardkomponenten wie Buttons, Navigation,
Eingabefelder und Farbschemata stehen sofort zur Verfügung und folgen
konsistenten Designrichtlinien. Für diese App bedeutet das, dass die
Benutzeroberfläche -- insbesondere die geführte Kalibrierung und die
Stimmansicht gemäß @req-nfa-be-01 und @req-nfa-be-02 -- ohne eigenes
Design-System von Grund auf aufgebaut werden musste. Theming,
Typografie und Abstände sind systemseitig definiert und plattformweit
konsistent, was den Designaufwand erheblich reduziert und gleichzeitig
eine professionelle Darstellung sicherstellt.

*Entscheidung*

Aufgrund eigener praktischer Erfahrungen mit allen drei Frameworks sowie
der beschriebenen Eigenschaften wurde Flutter gewählt. Es bietet bessere
Performance als React Native, ein kohärenteres Entwicklungserlebnis als
.NET MAUI und ermöglicht eine plattformübergreifende Darstellung, die
auf jedem Gerät identisch aussieht. Nachteile von
Cross-Compiling-Ansätzen, die in @mobileAppEngineering (2017) beschrieben
werden, sind durch Flutters AOT-Kompilierung, eigenständiges Rendering
und die direkte Integration von Material 3 heute weitgehend überholt.

=== Abhängigkeiten <abhaengigkeiten>

Die App verwendet folgende Laufzeit-Abhängigkeiten:

#table(
  columns: (auto, auto, 1fr),
  inset: 7pt,
  stroke: 0.5pt,
  align: (left, left, left),
  table.header(strong[Paket], strong[Version], strong[Verwendung]),
  [`flutter_riverpod`],
  [`^3.0.0`],
  [State-Management; stellt gemeinsamen Zustand über den Widget-Baum bereit und bildet die Grundlage für Provider und Notifier.],

  [`riverpod_annotation`], [`^4.0.0`], [Annotationspaket für Riverpod; wird zur Code-Generierung benötigt.],

  [`shared_preferences`],
  [`^2.3.3`],
  [Persistenz einfacher Schlüssel-Wert-Paare; speichert Gitarrenprofile und Stimmungen dauerhaft auf dem Gerät (@req-fsa-10, @req-fsa-13).],

  [`json_annotation`],
  [`^4.9.0`],
  [Annotationspaket für JSON-Serialisierung; ermöglicht das Speichern komplexer Objekte als JSON-String in `shared_preferences`.],

  [`record`], [`^6.1.1`], [Plattformunabhängiger Zugriff auf das Gerätmikrofon für iOS und Android (@req-fsa-01).],

  [`pitch_detector_dart`],
  [`^0.0.7`#footnote([
      Da die Applikation im Rahmen dieser Bachelorarbeit als Proof of Concept
      entwickelt wurde, wird die noch nicht stabil veröffentlichte Version der
      Abhängigkeit toleriert. Für eine Veröffentlichung im App Store sollte eine stabile Alternative gewählt werden.
    ])],
  [Implementierung des YIN-Algorithmus zur Grundfrequenzschätzung (@req-fsa-01).],

  [`buffered_list_stream`],
  [`^1.3.0`],
  [Puffert den kontinuierlichen Audiodatenstrom zu Blöcken, die der YIN-Algorithmus verarbeiten kann.],

  [`ml_linalg`],
  [`^13.12.6`],
  [Optimierte Matrizenoperationen (Multiplikation, Inversion) für Verstimmungsmatrix und Zielfrequenzberechnung (@req-fsa-07, @req-fsa-03).],

  [`statistics`],
  [`^1.2.1`],
  [Hilfsfunktionen für Listenoperationen in der Signalverarbeitung und Plausibilitätsprüfung.],

  [`async`], [`^2.13.0`], [Erweiterungen für asynchrone Programmierung und Parallelverarbeitung des Audiostreams.],

  [`flutter_sound`], [`^9.30.0`], [Wiedergabe eines Referenztons zur auditiven Überprüfung der Stimmung.],

  [`auto_route`], [`^11.1.0`], [Typsicheres Routing mit reduziertem Boilerplate-Code.],

  [`url_launcher`], [`^6.3.2`], [Öffnet externe URLs; verlinkt Hilfevideos auf YouTube (@req-fba-06, @req-nfa-be-04).],
)

Folgende Abhängigkeiten werden ausschließlich zur Entwicklungszeit
benötigt und sind nicht Teil des ausgelieferten Artefakts:

#table(
  columns: (auto, auto, 1fr),
  inset: 7pt,
  stroke: 0.5pt,
  align: (left, left, left),
  table.header(strong[Paket], strong[Version], strong[Verwendung]),
  [`riverpod_generator`], [`^4.0.0+1`], [Generiert Riverpod-Provider aus Annotationen.],

  [`riverpod_lint`], [`^3.0.0`], [Statische Analyse für korrekte Riverpod-Verwendung.],

  [`json_serializable`], [`^6.11.1`], [Generiert JSON-Serialisierungscode aus `json_annotation`-Annotationen.],

  [`auto_route_generator`], [`^10.2.4`], [Generiert Routing-Code aus `auto_route`-Annotationen.],

  [`build_runner`], [`^2.7.1`], [Führt alle Code-Generatoren aus.],

  [`flutter_lints`], [`^6.0.0`], [Offizielles Lint-Regelwerk für Flutter; stellt statische Codequalität sicher.],
)

=== Quellcode

Die App wurde mit Git versioniert und ist öffentlich auf GitHub verfügbar:
#link("https://github.com/Raphael2b3/floyd_rose_tuner")

=== Kalibrierungslogik

Um die Fortschrittsanzeige und eine Zurück-Funktion zu implementieren,
muss zu jedem Zeitpunkt eindeutig bestimmbar sein, in welchem Schritt
des Kalibrierungsvorgangs sich die App befindet und wie der Zustand bei
"Weiter" bzw. "Zurück" zu setzen ist.

Der Kalibrierungsablauf wird durch vier Variablen vollständig beschrieben:

#table(
  columns: (auto, auto, 1fr),
  inset: 7pt,
  stroke: 0.5pt,
  align: (left, center, left),
  table.header(strong[Variable], strong[Wertebereich], strong[Bedeutung]),
  [`pageIndex`], [$in NN, [0, 2]$], [Aktuelle Seite: 0 = Messen, 1 = Prüfen, 2 = Verändern],
  [`stringIndex`], [$in NN, [0, 5]$], [Index der Saite, mit der aktuell interagiert wird],
  [`sampleIndex`], [$in NN, [0, N-1]$], [Index des aktuellen Messpunkts],
  [`effectIndex`], [$in NN, [0, 5]$], [Index der Saite, deren Verstimmung das Sample beschreibt],
)

Es wird die minimale Anzahl der benötigten Messpunkte verwendet: $N = 2$.

*Fortschrittsberechnung*

Aus diesen Variablen lässt sich ein linearer Fortschrittswert ableiten:

$
  "progress" = "pageIndex" + 2 dot "stringIndex"
  + 13 dot "sampleIndex" + 26 dot "effectIndex"
$

Der maximale Wert ergibt sich zu:

$
  "max" = 2 + 2 dot 5 + 13 dot 2 + 26 dot 5 = 168
$

Der normierte Fortschritt $p = "progress" \/ "max" in [0, 1]$ wird
direkt als Füllstand der Fortschrittsanzeige verwendet.

*Navigationslogik*

#figure(
  image("assets/kalog.png"),
  caption: [Zustandsdiagramm des Stimmvorgangs],
) <zstKalib>

Die Zustandsübergänge beim Drücken von "Weiter" sind in @zstKalib mit
den Labels a) bis h) dargestellt und werden im Folgenden als
Pseudocode ausformuliert. #footnote([`++` ist die Kurzform für
  $v = v + 1$; analog gilt `--` für $v = v - 1$.])


*Messseite*
```
Weiter-Button{ // Übergang a)
    navigate(Prüfseite);
}

Zurück-Button{
    if stringIndex == 0 && sampleIndex == 0 && effectIndex == 0:
        // Übergang x)
        exit()
    else if stringIndex > 0: // Übergang reverse b) rückwärts
        stringIndex--
        navigate(Prüfseite)
    else:  // stringIndex == 0
        stringIndex = 5
        if sampleIndex > 0: // Übergang d)
            sampleIndex--
        else:               // Übergang e)
            sampleIndex = 1 // letztes Sample der vorherigen Verstimmung
        navigate(Veränderungsseite)
}
```

*Prüfseite*

```
Weiter-Button{
    samples[effectIndex][sampleIndex][stringIndex] = messung

    if stringIndex < 5: // Übergang b)
        stringIndex++
        prüfungFehler=false
        navigate(Messseite)

    else if sampleIndex == 1 && effectIndex == 5:
        calculateMatrix() // Übergang g)
        saveGuitar()
        navigate(Kontrollansicht)

    else:
        if sampleIndex == 0: // Übergang c)
            stringIndex = effectIndex
        else: // Übergang g)  sampleIndex==1 && effectIndex<5
            samples[effectIndex + 1][0] = samples[effectIndex][1]
            // Ausgangslage für nächste Verstimmung übernehmen
            effectIndex++
            stringIndex = effectIndex
            sampleIndex = 0
        navigate(Veränderungsseite)
}

Zurück-Button{ // Übergang a) rückwärts
    navigate(Messseite)
}
```

*Veränderungsseite*

```
Fertig-Button{ // Übergang d)
    sampleIndex++
    stringIndex = 0
    prüfungFehler=false
    navigate(Messseite)
}

WrongStringChanged-Button{ // Übergang e)
    sampleIndex = 0
    stringIndex = 0
    prüfungFehler=false
    navigate(Messseite)
}

Zurück-Button{ // Übergang c) rückwärts
    stringIndex = 5
    if sampleIndex == 1 && effectIndex > 0: // Übergang f) rückwärts
        effectIndex--
    navigate(Prüfseite)
}
```

=== Stimmlogik

#figure(
  image("assets/stimlgcc.png"),
  caption: [Zustandsdiagramm: Stimmlogik],
) <zststm>

Der Stimmvorgang wird durch zwei Variablen beschrieben:

#table(
  columns: (auto, auto, 1fr),
  inset: 7pt,
  stroke: 0.5pt,
  align: (left, center, left),
  table.header(strong[Variable], strong[Wertebereich], strong[Bedeutung]),
  [`pageId`], [$in NN, {0, 1, 2}$], [Aktuelle Seite: 0 = Messen, 1 = Prüfen, 2 = Stimmen],
  [`stringIndex`], [$in NN, [0, 5]$], [Index der Saite, mit der aktuell interagiert wird],
)

*Fortschrittsberechnung*

Da die Stimmseite eine abweichende Gewichtung benötigt, ist der
Fortschrittswert stückweise definiert:

$
  "progress" = cases(
    "pageId" + 2 dot "stringIndex" & "pageId" != 2,
    12 + "stringIndex" & "pageId" = 2,
  )
  quad "max" = 18
$
*Navigationslogik*

Die Zustandsübergänge beim Drücken von "Weiter" und "Zurück" sind in
@zststm mit den Labels a) bis f) dargestellt und werden im Folgenden
als Pseudocode ausformuliert.

*Messseite*

```
Weiter-Button:{ // Übergang a)
    navigate(Prüfseite)
}

Zurück-Button{
    if stringIndex == 0: // Übergang x)
        exit()
    else: // Übergang b) rückwärts
        stringIndex--
        navigate(Prüfseite)
}
```
#pagebreak()
*Prüfseite*

```
Weiter-Button{
    speicherMessung(stringMeasureState[stringIndex] = messung)

    if stringIndex < 5: // Übergang b)
        stringIndex++
        navigate(Messseite)
    else: // Übergang c)
        stringIndex = 0
        berechneZielfrequenzen()
        navigate(Stimmseite)
}

Zurück-Button{ // reverse a)
    navigate(Messseite)
}
```

*Stimmseite*

```
Weiter-Button{
    if stringIndex < 5: // Übergang d)
        stringIndex++
    else: // Übergang e)
        navigate(Ende)
        return
    navigate(Stimmseite) // gleiche Seite, neue Saite
}
Zurück-Button{
    if stringIndex > 0: // Übergang d) rückwärts
        stringIndex--
    else: // Übergang e) rückwärts
        stringIndex = 5
        navigate(Prüfseite)
        return
    navigate(Stimmseite)
}
```

== Tests während der Entwicklung

*Manuelle Tests*

Aus Zeitgründen wurden die meisten Anforderungen manuell getestet.
Dabei wurde jede Anforderung durch gezielte Bedienung der App unter
den jeweils beschriebenen Bedingungen überprüft und das Ergebnis
protokolliert.

Manuell getestet wurden:

- @req-fba-01 bis @req-fba-16
- @req-fsa-01, @req-fsa-02
- @req-fsa-04 bis @req-fsa-06
- @req-fsa-09 bis @req-fsa-16
- @req-nfa-mg-01 bis @req-nfa-mg-03
- @req-nfa-ro-02, @req-nfa-ro-03
- @req-nfa-be-01 bis @req-nfa-be-04
- @req-nfa-dp-01 bis @req-nfa-dp-03
#pagebreak()
*Unit-Tests*

Für die mathematisch verifizierbaren Kernanforderungen wurden
automatisierte Unit-Tests implementiert:

- @req-fsa-03: Korrektheit der Zielfrequenzberechnung anhand bekannter
  Eingabe- und Ausgabewerte
- @req-fsa-07, @req-fsa-08: Schätzung der Verstimmungsmatrix mittels
  Deming-Regression, überprüft gegen synthetische Messdaten mit
  bekannter Steigung

*Ungetestete Anforderungen*

Die folgenden Anforderungen wurden im Rahmen dieser Arbeit nicht
getestet und stellen offene Punkte für eine Weiterentwicklung dar:

- @req-nfa-la-01, @req-nfa-la-02: Latenzmessung erfordert eine
  instrumentierte Testumgebung zur präzisen Zeiterfassung
- @req-nfa-ro-01: Systematischer Test bei definiertem Umgebungspegel
  von $70 "dB(A)"$ war messtechnisch nicht umsetzbar
- @req-nfa-ko-01 bis @req-nfa-ko-03: Kompatibilitätstests auf
  verschiedenen Geräten und Betriebssystemversionen stehen aus

= Evaluation<evaluation>

== Funktionsfähigkeit des Algorithmus

Das zentrale Ziel der Arbeit wurde erreicht: Unter kontrollierten akustischen Bedingungen konnte eine Floyd-Rose-Gitarre mithilfe der Applikation erfolgreich gestimmt werden. In den Nutzertests (@nutzerTests) lagen die finalen Abweichungen bei durchschnittlich ±3 bis ±14 Cent. Damit wurde eine für musikalische Zwecke sehr gute Stimmgenauigkeit erreicht.
Die Verstimmungsmatrix wurde
korrekt kalibriert und die berechneten Zielfrequenzen führten zu einem
gestimmten Instrument.

Gleichzeitig zeigten die Tests Grenzen des aktuellen Stands: Unter
lauten Bedingungen oder bei verzerrtem Signal war die
Fundamentalfrequenzerkennung nicht zuverlässig genug, um den
Stimmvorgang abzuschließen (@nutzerTests, Nutzer 1). Zudem wurde ein
konzeptioneller Fehler im Stimmvorgang identifiziert -- die fehlende
Kompensation von Folgeverstimmungen beim schrittweisen Stimmen --
der zwischenzeitlich behoben wurde (@nutzerTests, Nutzer 2).

== Erfüllung der Requirements aus SWE
#table(
  columns: (auto, 1fr, auto),
  inset: 7pt,
  stroke: 0.5pt,
  align: (center, left, center),

  table.header(strong[ID], strong[Anforderung], strong[Erfüllt]),

  // ── Funktionale Benutzeranforderungen ──────────────────────────
  table.cell(colspan: 3, fill: luma(230))[
    *Funktionale Benutzeranforderungen*
  ],
  [@req-fba-01], [Eine Floyd-Rose-Gitarre effizient stimmen], [Ja],
  [@req-fba-02], [App auf Gitarre kalibrieren], [Ja],
  [@req-fba-03], [Kalibrierung mehrerer Gitarren speichern], [Ja],
  [@req-fba-04], [Stimmzustand der Gitarre messen], [Ja],
  [@req-fba-05], [Messempfindlichkeit einstellen], [Ja],
  [@req-fba-06], [Bedienhilfe erhalten], [Teilweise],
  [@req-fba-07], [Korrektheit der Messung manuell prüfen], [Ja],
  [@req-fba-08], [Fehlerhafte Messungen korrigieren], [Ja],
  [@req-fba-09], [Unterschiedliche Stimmungen auswählen], [Ja],
  [@req-fba-10], [Stimmung mit herkömmlichem Stimmgerät prüfen], [Ja],
  [@req-fba-11], [App rekalibrieren], [Ja],
  [@req-fba-12], [Kalibrierungen benennen], [Ja],
  [@req-fba-13], [Eigene Stimmungen erstellen, bearbeiten, löschen], [Nein],
  [@req-fba-14], [Messungen manuell mit externem Gerät eintragen], [Ja],
  [@req-fba-15], [Unbekannte Begriffe nachvollziehen], [Nein],
  [@req-fba-16], [Präzision der Kalibrierung erhöhen], [Teilweise],
  // ── Funktionale Systemanforderungen ───────────────────────────
  table.cell(colspan: 3, fill: luma(230))[
    *Funktionale Systemanforderungen*
  ],
  [@req-fsa-01], [Grundfrequenzschätzung per YIN-Algorithmus], [Ja],
  [@req-fsa-02], [Messung nur bei Überschreitung des dBFS-Schwellenwerts], [Ja],
  [@req-fsa-03], [Berechnung der Zielfrequenz gemäß Verstimmungsformel], [Ja],
  [@req-fsa-04], [Stimmen in Reihenfolge E2 → A2 → D3 → G3 → B3 → E4], [Ja],
  [@req-fsa-05], [Gleitender Mittelwert zur Ausreißerdämpfung], [Ja],
  [@req-fsa-06], [Frequenzbereich auf 50 Hz – 350 Hz begrenzen], [Ja],
  [@req-fsa-07], [Verstimmungsmatrix per Deming-Regression schätzen], [Ja],
  [@req-fsa-08], [Diagonalelemente $C_(i i)=1$ ohne Messung setzen], [Ja],
  [@req-fsa-09], [Falsch verstimmte Saite bei Kalibrierung erkennen], [Nein],
  [@req-fsa-10], [Verstimmungsmatrix $C$ persistent speichern], [Ja],
  [@req-fsa-11], [Standard-Stimmgerät-Funktionalität anbieten], [Ja],
  [@req-fsa-12], [Grundfrequenz aus Obertönen ableiten], [Nein],
  [@req-fsa-13], [Gitarrenprofilnamen persistent speichern], [Ja],
  [@req-fsa-14], [Vordefinierte Stimmungen bereitstellen], [Ja],
  [@req-fsa-15], [Benutzerdefinierte Stimmungen speichern/bearbeiten/löschen], [Nein],
  [@req-fsa-16], [Mehr als zwei Samples für Regression], [Teilweise],

  // ── Nichtfunktionale: Messgenauigkeit ─────────────────────────
  table.cell(colspan: 3, fill: luma(230))[
    *Nichtfunktionale Anforderungen – Messgenauigkeit*
  ],
  [@req-nfa-mg-01], [Grundfrequenz mit max. $±5 "Cent"$ Abweichung], [Ja],
  [@req-nfa-mg-02], [Obertöne nicht als Grundfrequenz ausgeben], [Teilweise],
  [@req-nfa-mg-03], [Bei unverstärktem Spiel max. $±5 "Cent"$ Abweichung], [Ja],

  // ── Nichtfunktionale: Latenz ───────────────────────────────────
  table.cell(colspan: 3, fill: luma(230))[
    *Nichtfunktionale Anforderungen – Latenz*
  ],
  [@req-nfa-la-01], [Zielanzeige innerhalb von 100 ms aktualisieren], [Nicht Überprüft],
  [@req-nfa-la-02], [Zielfrequenzberechnung in unter 500 ms], [Nicht Überprüft],

  // ── Nichtfunktionale: Robustheit ──────────────────────────────
  table.cell(colspan: 3, fill: luma(230))[
    *Nichtfunktionale Anforderungen – Robustheit*
  ],
  [@req-nfa-ro-01], [Stabile Messung bei bis zu 70 dB(A) Umgebungslärm], [Nicht Überprüft],
  [@req-nfa-ro-02], [Keine Schätzung bei Stille oder reinem Lärm], [Ja],
  [@req-nfa-ro-03], [Fallback-Modus bei defektem Mikrofon], [Ja],

  // ── Nichtfunktionale: Bedienbarkeit ───────────────────────────
  table.cell(colspan: 3, fill: luma(230))[
    *Nichtfunktionale Anforderungen – Bedienbarkeit*
  ],
  [@req-nfa-be-01], [Erststart ohne externe Hilfe abschließbar], [Ja],
  [@req-nfa-be-02], [Zentrale Aktionen mit max. 3 Interaktionen erreichbar], [Ja],
  [@req-nfa-be-03], [Visuelle statt textbasierte Bedienführung], [Teilweise],
  [@req-nfa-be-04], [Erklärvideos bereitstellen], [Nein],

  // ── Nichtfunktionale: Kompatibilität ──────────────────────────
  table.cell(colspan: 3, fill: luma(230))[
    *Nichtfunktionale Anforderungen – Kompatibilität*
  ],
  [@req-nfa-ko-01], [Lauffähig auf iOS ≥ 16 und Android ≥ 10], [Android: Ja],
  [@req-nfa-ko-02], [Betrieb auf Geräten mit ≥ 2 GB RAM], [Nicht Überprüft],
  [@req-nfa-ko-03], [Kein Layoutbruch auf 4,7 – 6,7 Zoll Displays], [Nicht Überprüft],

  // ── Nichtfunktionale: Datenschutz und Betrieb ─────────────────
  table.cell(colspan: 3, fill: luma(230))[
    *Nichtfunktionale Anforderungen – Datenschutz und Betrieb*
  ],
  [@req-nfa-dp-01], [Keine Datenübermittlung an externe Server], [Ja],
  [@req-nfa-dp-02], [Vollständig offline nutzbar], [Ja],
  [@req-nfa-dp-03], [Profile und Stimmungen exportierbar/importierbar], [Nein],
)

Die folgenden MUSS-Anforderungen wurden nicht erfüllt oder konnten
nicht überprüft werden:

@req-fsa-09 war technisch umsetzbar, wurde jedoch zurückgestellt, da
die automatische Erkennung einer falsch verstimmten Saite kein
Kernmerkmal des Stimmvorgangs darstellt, sondern ein Beitrag zur
Nutzererfahrung ist, der in einer späteren Iteration ergänzt werden
kann.


@req-nfa-ro-01 konnte nicht getestet werden, da der Aufbau einer
kontrollierten akustischen Testumgebung mit definiertem Umgebungspegel
von $70 "dB(A)"$ außerhalb des Projektumfangs lag.

@req-nfa-ko-01 und @req-nfa-ko-02 konnten aufgrund fehlender Hardware
und zeitlicher Einschränkungen nicht systematisch auf verschiedenen
Geräten und Betriebssystemversionen getestet werden.
== Nutzertests <nutzerTests>
Die Nutzertests wurden als unmoderierte, jedoch beobachtete Feld- bzw. Nutzungsszenarien durchgeführt. Die Probanden erhielten die Anwendung ohne strukturierte Einweisung und führten den Stimmprozess eigenständig durch, während der Autor als passiver Beobachter anwesend war. Ziel war die Erfassung realistischer Nutzungssituationen sowie potenzieller Fehlerquellen im Bedien- und Messprozess.

Die Tests fanden in unterschiedlichen akustischen Umgebungen statt, um die Robustheit der Frequenzanalyse und Signalverarbeitung unter realistischen Bedingungen zu evaluieren:

- ruhige Innenräume mit direkter Gitarrenaufnahme
- laute Umgebungen (z.\,B. Jam-Situationen)
Der Ablauf folgte keinem strikt vorgegebenen Protokoll, sondern einem task-basierten explorativen Vorgehen.
Erfasst wurden sowohl quantitative Kennzahlen als auch qualitative Beobachtungen:

- Dauer der Kalibrierung
- Dauer des gesamten Stimmprozesses
- Robustheit unter Störbedingungen (Lärm, Verzerrung)
- Verständlichkeit der Benutzerführung und der visuellen Darstellung

Die Tests wurden iterativ über mehrere Softwareversionen durchgeführt, wodurch ein Vergleich der Systementwicklung hinsichtlich Effizienz, Stabilität und Benutzerverständnis möglich wurde.

Die Auswertung erfolgte qualitativ-deskriptiv auf Basis der dokumentierten Testverläufe sowie ergänzend durch Zeitmessungen der einzelnen Prozessschritte.

#{
  // Ab hier sind alle Überschriften innerhalb der Klammern blockiert
  set heading(outlined: false)
  [

    *Nutzer 0*

    Die App wurde in einem ruhigen Zimmer mit verstärkter Gitarre ohne
    Verzerrungseffekt getestet. Die Frequenzen aller Saiten wurden korrekt
    erkannt und die Gitarre konnte erfolgreich gestimmt werden. Es traten
    vereinzelte Schwankungen bei der Erkennung der Fundamentalfrequenz auf,
    die den Prozess geringfügig verlangsamten.

    Die Bestimmung der Verstimmungsmatrix inklusive anschließender
    Überprüfung der Messdaten dauerte 3:47 Minuten; der gesamte
    Stimmvorgang war nach ca. 7 Minuten abgeschlossen.

    Version der  App: @protCreateGuita \
    Mobilgerät: Galaxy S20 5G \
    Modell: SM-G981B/DS

    *Nutzer 1*

    Die App wurde auf einer Jam-Session vorgestellt. Beim Versuch, die
    Frequenzen der E-Gitarre zu messen, wurde nicht die Fundamentalfrequenz,
    sondern der erste Oberton (Faktor 2) erkannt. Als Ursache kommen zwei
    Faktoren zusammen: die laute Umgebung sowie ein aktiver
    Verzerrungseffekt, der den Obertonanteil des Signals verstärkte. Der
    Stimmvorgang musste abgebrochen werden.

    Dieser Test macht deutlich, dass die Fundamentalfrequenzerkennung unter
    ungünstigen akustischen Bedingungen robuster gestaltet werden muss.

    Version der App: @protCreateGuita \
    Mobilgerät: Galaxy S20 5G \
    Modell: SM-G981B/DS

    *Nutzer 2*

    Die App wurde unter guten akustischen Bedingungen verwendet.
    Es fiel auf, dass der Kalibrierungsprozess zwar technisch korrekt
    funktionierte, jedoch unnötige Wiederholungen enthielt: Nachdem der
    Zustand der Gitarre nach dem Verstimmen einer Saite gemessen wurde,
    könnte dieser Zustand direkt als Ausgangslage für die Messung der
    nächsten Saite weiterverwendet werden. Aktuell wird dieser Schritt
    manuell ausgelöst.

    Darüber hinaus zeigte sich ein grundlegenderes Problem: Beim Stimmen
    einer Saite mithilfe der App wurden zunächst die korrekten
    Zielabweichungen $Delta f$ angezeigt. Sobald jedoch eine Saite aktiv
    verstimmt wurde, veränderte sich -- erwartungsgemäß aufgrund der
    Brückenkopplung -- der Zustand aller übrigen Saiten. Diese
    Zustandsänderung wurde nicht in die nachfolgende Berechnung der
    $Delta f$ einbezogen, sodass die Gitarre am Ende nicht präzise gestimmt
    war. Als Konsequenz muss der Stimmvorgang die durch jede
    Saitenänderung verursachten Folgeverstimmungen schrittweise
    vorausberechnen und kompensieren.


    Version der App: @protCreateGuita \
    Mobilgerät: Galaxy S20 5G \
    Modell: SM-G981B/DS

    *Nutzer 3*

    Nutzer 3 war mit der Darstellung roher Frequenzwerte (in Hz) überfordert
    und konnte deren Bedeutung nicht einordnen. Dies bestätigte den Bedarf
    einer abstrahierten, intuitiv verständlichen Visualisierung der
    Stimmgenauigkeit anstelle numerischer Frequenzangaben.
    Version der  App: @protoCalib

    *Nutzer 4*

    Nutzer 4 versuchte, die Gitarre unmittelbar nach dem
    Öffnen der App zu stimmen, ohne den Kalibrierungsschritt zu
    durchlaufen. Die App konnte nicht ausreichend klar vermitteln, dass
    zunächst mehrere Messreihen zur Bestimmung der Verstimmungsmatrix
    erforderlich sind. Auch das Tutorial-Video war zu dem Zeitpunkt nicht verfügbar.

    Als der Nutzer aufgefordert wurde, eine Saite gezielt zu verstimmen,
    entstand Unsicherheit darüber, in welche Richtung und um wie viel die
    Saite verstimmt werden solle -- obwohl der genaue Betrag für das
    Verfahren irrelevant ist.

    Zusätzlich hatte die App Schwierigkeiten, die tiefen Saiten korrekt zu
    messen, da die Stahlsaiten einen ausgeprägten Obertonanteil aufwiesen.
    Durch Umpositionierung des Smartphones näher am Lautsprecher sowie
    durch Betätigung des _Tone-Knobs_ -- der die Funktion eines analogen
    Tiefpassfilters erfüllt -- konnte das Problem behoben werden.

    Der abschließende Stimmvorgang verlief weitgehend erfolgreich; die
    E2-Saite wurde jedoch zu hoch gestimmt. Dies deutet darauf hin, dass
    die Einträge der Verstimmungsmatrix, die den Einfluss auf E2 beschreiben,
    den größten Messfehler aufwiesen -- Abweichung von $plus.minus$ 15 Cent. Die restlichen Saiten hatten einen Fehler von $plus.minus$ 3,2 Cent.

    Der effektive Zeitaufwand für den Stimmvorgang betrug 8 Minuten.
    Version der  App: @protoCalib \
    Mobilgerät: Galaxy S20 5G \
    Modell: SM-G981B/DS

    *Nutzer 5*

    Nutzer 5 testete die App in der finalen Version. Die Kalibrierung dauerte
    7:00 Minuten und hat sich damit im Vergleich zu älteren Versionen, in denen
    dieser Schritt in 3:30 Minuten abgeschlossen werden konnte, deutlich
    verlängert. Der anschließende Stimmprozess nahm 1:30 Minuten in Anspruch
    und war erfolgreich. Die mittlere Abweichung betrug $plus.minus$~3,3~Cent. \
    Mobilgerät: Galaxy S20 5G \
    Modell: SM-G981B/DS

    *Nutzer 6*

    Nutzer 6 benötigte 6:26 Minuten für die Kalibrierung und 5:40 Minuten für
    den Stimmprozess. Das größte Problem war die Erkennung tiefer Frequenzen
    im Bereich von 60--80~Hz. Die Ursache liegt darin, dass Vielfache dieser
    Frequenzen -- etwa 120~Hz und 160~Hz -- ebenfalls plausible Messwerte für
    benachbarte Saiten darstellen, was zu Verwechslungen führt. Daraus ergibt
    sich die Empfehlung, tiefe Frequenzen bei der Schätzung bevorzugt zu
    behandeln.

    #figure(
      table(
        columns: (auto, auto),
        stroke: (x: none, y: 0.5pt),
        table.header([*Saite*], [*Abweichung*]),
        [E2], [+15 Cent],
        [A2], [+8 Cent],
        [D3], [+5 Cent],
        [G3], [+20 Cent],
        [B3], [+7 Cent],
        [E4], [+0 Cent],
      ),
      caption: [Nutzer 6 -- Abweichungen nach dem Stimmen],
    )

    *Nutzer 7*

    Nutzer 7 testete den Wechsel von Standard-E- zur Drop-D-Stimmung, bei dem
    die tiefe E-Saite auf D2 umgestimmt wird. Der Stimmprozess dauerte
    3:00 Minuten. Auch bei diesem Test traten Schwierigkeiten bei der Erkennung
    tiefer Frequenzen auf. Der Test wurde auf einem Redmi 10 2022 durchgeführt.

    #figure(
      table(
        columns: (auto, auto, auto),
        stroke: (x: none, y: 0.5pt),
        table.header([*Saite*], [*Ausgangsfrequenz*], [*Abweichung*]),
        [D2], [82,97 Hz], [+0 Cent],
        [A2], [110,4 Hz], [+6 Cent],
        [D3], [147,4 Hz], [+3 Cent],
        [G3], [198,4 Hz], [+12 Cent],
        [B3], [247,3 Hz], [+2 Cent],
        [E4], [329,9 Hz], [+4 Cent],
      ),
      caption: [Nutzer 7 -- Ausgangsfrequenzen und Abweichungen nach dem Stimmen],
    )
    Mobilgerät: Redmi 10 2022 \
    Modell: ~22011119UY

    *Nutzer 8*

    Nutzer 8 führte Kalibrierung und Stimmvorgang durch, wobei die Saiten
    nach oben verstimmt wurden. Die Kalibrierung dauerte 5:18 Minuten, der
    Stimmprozess 3:20 Minuten.

    #figure(
      table(
        columns: (auto, auto, auto),
        stroke: (x: none, y: 0.5pt),
        table.header([*Saite*], [*Ausgangsfrequenz*], [*Abweichung*]),
        [E2], [85,49 Hz], [+4 Cent],
        [A2], [118,6 Hz], [+15 Cent],
        [D3], [147,63 Hz], [+10 Cent],
        [G3], [202,85 Hz], [+20 Cent],
        [B3], [250,3 Hz], [+13 Cent],
        [E4], [334,0 Hz], [+10 Cent],
      ),
      caption: [Nutzer 8 -- Ausgangsfrequenzen und Abweichungen nach dem Stimmen],
    )
    Mobilgerät: Redmi 10 2022 \
    Modell: ~22011119UY

    *Nutzer 9*

    Nutzer 9 führte Kalibrierung und Stimmvorgang durch, wobei die Saiten
    nach unten verstimmt wurden. Die Kalibrierung dauerte 5:18 Minuten, der
    Stimmprozess 2:29 Minuten. Nach einer zweiten Iteration lagen alle Saiten
    innerhalb einer Abweichung von maximal $plus.minus$~5~Cent. Der Test wurde
    auf einem Redmi~10 (2022, Modell~22011119UY) durchgeführt.

    #figure(
      table(
        columns: (auto, auto, auto, auto, auto),
        stroke: (x: none, y: 0.5pt),
        table.header(
          [*Saite*],
          [*Ausgangs- \ frequenz*],
          [*Abweichung \ Iteration 1*],
          [*End- \ frequenz*],
          [*Abweichung \ Iteration 2*],
        ),
        [E2], [84,0 Hz], [+0 Cent], [82,5 Hz], [$lt.eq$ 5 Cent],
        [A2], [106,2 Hz], [+5 Cent], [111,3 Hz], [$lt.eq$ 5 Cent],
        [D3], [144,96 Hz], [+8 Cent], [147,8 Hz], [$lt.eq$ 5 Cent],
        [G3], [192,5 Hz], [+6 Cent], [197,4 Hz], [$lt.eq$ 5 Cent],
        [B3], [232,0 Hz], [+0 Cent], [247,2 Hz], [$lt.eq$ 5 Cent],
        [E4], [312,58 Hz], [+0 Cent], [330,1 Hz], [$lt.eq$ 5 Cent],
      ),
      caption: [Nutzer 9 -- Ausgangsfrequenzen, Abweichungen und Endfrequenzen nach zwei Iterationen],
    )
    Mobilgerät: Redmi 10 2022 \
    Modell: ~22011119UY
  ]
}
= Fazit <fazit>

Diese Arbeit hatte zum Ziel, das Kopplungsverhalten einer
Floyd-Rose-Gitarre mathematisch zu modellieren und auf dieser Grundlage
eine mobile Applikation zu entwickeln, die den Stimmvorgang gegenüber
dem rein manuellen Verfahren vereinfacht.

*Zum physikalischen Modell:*
Das entwickelte Modell beschreibt die Floyd-Rose-Gitarre als nichtlineares
System, in dem die Aufwickelstrecken aller sechs Saiten die Frequenzen
des gesamten Instruments beeinflussen. Für kleine Verstimmungen lässt
sich dieses System durch eine gitarrenspezifische Verstimmungsmatrix $C$
linearisieren. Die Linearitätsannahme wurde experimentell mit Beträgen von
Pearson-Korrelationskoeffizienten von über $0,98$ für alle Saiten
bestätigt. Die Matrixinversion liefert die erforderlichen
Verstimmungsbeträge; die sequentielle Zwischenzielfrequenzformel macht diese
für den Nutzer direkt anwendbar, ohne mentale Zwischenrechnungen.

*Zur Applikation:*
Die Applikation wurde als plattformübergreifende Flutter-App für Android
und iOS realisiert. Sie unterstützt den vollständigen Workflow:
einmalige Kalibrierung der gitarrenspezifischen Verstimmungsmatrix,
Messung des aktuellen Gitarrenzustands und geführtes saitenweises
Stimmen auf die berechneten Zielfrequenzen. Ergänzend steht ein
Standard-Stimmgerät zur abschließenden Überprüfung bereit.

Die Nutzertests zeigen, dass das Verfahren unter kontrollierten
akustischen Bedingungen funktioniert: Die Gitarre konnte erfolgreich
gestimmt werden, und der Gesamtaufwand lag bei 7 bis 8 Minuten.
Damit ist die Applikation bereits in ihrer aktuellen Form für
strukturierte Stimmvorgänge in ruhigen Umgebungen einsetzbar.

*Zu den Grenzen:*
Unter lauten Umgebungsbedingungen oder bei Gitarren mit ausgeprägtem
Obertonanteil -- etwa durch Verzerrungseffekte -- war die
Fundamentalfrequenzschätzung nicht zuverlässig genug, um den
Stimmvorgang abzuschließen. Darüber hinaus akkumulieren sich
Messungenauigkeiten über die Kalibrierungs- und Stimmschritte hinweg,
was in einzelnen Fällen zu Abweichungen von bis zu 20~Cent führte.
Dieser Wert liegt an der Wahrnehmungsgrenze ungeübter Ohren und sollte
in einer Weiterentwicklung reduziert werden.

Mehrere SOLL-Anforderungen -- darunter benutzerdefinierte Stimmungen
und Erklärvideos -- wurden im Rahmen dieser Arbeit nicht implementiert.

*Zur Forschungsfrage:*
Die Forschungsfrage lässt sich positiv beantworten: Das
Kopplungsverhalten einer Floyd-Rose-Gitarre lässt sich durch eine
kalibrierte Verstimmungsmatrix hinreichend genau linearisieren, um
darauf eine funktionsfähige mobile Applikation aufzubauen. Das
Verfahren ist korrekt und in seiner Kernfunktion einsatzbereit. In
Nutzertests konnte zudem ein Effizienzgewinn nachgewiesen werden, wobei
der Stimmvorgang typischerweise zwischen fünf und acht Minuten in
Anspruch nimmt. Das Ergebnis ist zufriedenstellend: Bei einmaliger
Iteration beträgt die Abweichung in der Regel nicht mehr als
$plus.minus$~20~Cent, bei zweimaliger Iteration nicht mehr als
$plus.minus$~5~Cent.
Die verbleibenden Schwächen liegen nicht im mathematischen Modell,
sondern in der Robustheit der Signalverarbeitung und der
Vollständigkeit der Implementierung -- beides adressierbare Punkte
für eine Weiterentwicklung.
= Ausblick<ausblick>

== Optimierung der Fundamentalfrequenzschätzung

Die Nutzertests (@nutzerTests) zeigten, dass der YIN-Algorithmus unter
zwei Bedingungen zur Erkennung von Obertönen statt der Fundamentalfrequenz
neigt: bei hohem Umgebungspegel (Nutzer 1) sowie bei Saiten mit ausgeprägtem
Obertonanteil wie tiefen Stahlsaiten (Nutzer 4). In beiden Fällen wurde
der erste Oberton -- also die doppelte Grundfrequenz -- als Schätzwert
ausgegeben.

Für stärker verrauschte Signale oder höhere Obertöne
(Faktor 3, 4, ...) greift sie nicht zuverlässig.

Eine robustere Alternative wäre das _Harmonic Product Spectrum_ (HPS):
Dabei wird das Frequenzspektrum des Signals mit sich selbst bei
schrittweise halbierten Frequenzachsen multipliziert, wodurch die
Grundfrequenz als gemeinsamer Teiler aller Partialtöne verstärkt
hervortritt. @req-fsa-01 schreibt den YIN-Algorithmus nicht zwingend
vor -- eine Ersetzung oder Ergänzung durch HPS wäre im Rahmen einer
Weiterentwicklung prüfenswert.

== Umsetzung und Testen der verbleibenden Anforderungen

Das Requirements Engineering hat eine Vielzahl klar abgegrenzter
Arbeitspakete hervorgebracht. Die verbleibenden Anforderungen zu
implementieren, zu verfeinern und durch automatisierte Tests abzusichern
würde die Qualität und Zuverlässigkeit der Applikation deutlich
verbessern.

== Gleichzeitiges Messen aller Saiten

Derzeit muss der Nutzer jede Saite einzeln anspielen. Durch den Einsatz
einer Fourier-Transformation ließe sich das vollständige Frequenzspektrum
eines Akkords analysieren, die sechs saitenspezifischen Grundfrequenzen
als lokale Maxima identifizieren und harmonische Obertöne herausrechnen.
Der Nutzer könnte so alle Saiten gleichzeitig anschlagen, was den
Messvorgang erheblich beschleunigen würde.

== Automatische Saitenerkennung beim Stimmen

Wenn der Nutzer während des Stimmvorgangs eine Saite anspielt, könnte
die App anhand der gemessenen Frequenz automatisch erkennen, welche Saite
verändert wird, und die Anzeige entsprechend umschalten. Voraussetzung
ist, dass die Saite bereits näherungsweise auf der Zielfrequenz liegt,
sodass eine eindeutige Zuordnung möglich ist.

== Automatisches Fortfahren beim Stimmen

Aktuell muss der Nutzer nach dem Stimmen jeder Saite manuell zur
nächsten wechseln. Die App könnte stattdessen automatisch erkennen,
wann eine Saite den Zielfrequenzbereich erreicht hat, und ohne
Nutzerinteraktion zur nächsten Saite fortfahren. Dies würde den
Stimmvorgang weiter beschleunigen und ist besonders für Persona Jonas
(@hanna) relevant, der täglich mehrere Gitarren stimmt.

== Automatische Kalibrierung der Mikrofonempfindlichkeit

Derzeit muss der Nutzer den Empfindlichkeitsschwellenwert manuell über
einen Schieberegler einstellen (@req-fba-05). Die App könnte stattdessen
in einer kurzen Einmessphase den Umgebungsgeräuschpegel messen, daraus
einen Basiswert ermitteln und den Schwellenwert automatisch so setzen,
dass eine gespielte Saite ihn mit ausreichendem Abstand überschreitet.
Dies würde @req-fba-05 obsolet machen und die Einstiegshürde für
unerfahrene Nutzer wie Persona Emil weiter senken.
== Mehr Konfigurationsfreiraum

*Änderbare Referenzstimmung*

Aktuell ist die Referenzfrequenz fest auf $440 "Hz"$ eingestellt.
Manche Ensembles -- insbesondere im Orchesterkontext -- stimmen auf
abweichende Referenzwerte wie $438 "Hz"$ oder $442 "Hz"$. Eine
konfigurierbare Referenzfrequenz würde es ermöglichen, die Gitarre
präzise auf solche Ensembles abzustimmen.

*Unterstützung beliebig vieler Saiten*

Die aktuelle Implementierung setzt sechs Saiten voraus. Es gibt jedoch
Gitarren mit sieben, acht oder mehr Saiten sowie Bassgitarren mit vier
oder fünf Saiten. Zudem ist dieser Effekt auch bei Harfen beobachtbar,
da gespannte Saiten auf ähnlicher Weise in Wechselwirkung miteinander stehen.
Eine Verallgemeinerung der Verstimmungsmatrix $C$ auf $n times n$ Saiten
wäre konzeptuell umsetzbar und würde die Applikation für eine breitere
Instrumentenvielfalt nutzbar machen.

== Implementierung als DAW-Plugin

Eine Portierung der Kernlogik als VST3- oder CLAP-Plugin in C++ würde
den Einsatz in professionellen Studio-Umgebungen ermöglichen und damit
das in @hanna beschriebene Szenario von Persona Hanna adressieren.
Im Plugin-Kontext stünden zudem deutlich präzisere Audio-APIs und
geringere Latenzen zur Verfügung, was die Messgenauigkeit weiter
steigern könnte. Dieser Anwendungsfall wurde bewusst aus dem Umfang
dieser Arbeit ausgeschlossen (siehe Ausgeschlossene Anforderungen),
bleibt jedoch ein sinnvoller nächster Schritt.

== Veröffentlichung und Erweiterung auf weitere Brückensysteme

Nach einer abschließenden Qualitätssicherung könnte die Applikation
in den App Store und Google Play veröffentlicht werden. Darüber hinaus
existieren weitere Gitarrenbrücken -- etwa das Kahler-System oder
Semi-Floating-Bridges -- die ein ähnliches Kopplungsverhalten zwischen
den Saiten aufweisen. Eine Verallgemeinerung des Kalibrierungsverfahrens
auf solche Systeme würde die potenzielle Nutzerbasis erheblich
vergrößern.


#pagebreak()
#heading(depth: 1, "Glossar", numbering: none, outlined: false)
/ Bund: Ein Metallstift, der quer über den Gitarrenhals verläuft und die Saiten in Abschnitte unterteilt, um verschiedene Töne zu erzeugen, wenn die Saite auf den Bund gedrückt wird.
/ Brücke: Ein fester Punkt am Gitarrenkörper, an dem die Saiten befestigt sind (vgl. @figBegriffe).
/ CLAP: CLever Audio Plug-in
/ DAW: Digital Audio Workstation
/ E | A | D | G | B | hohe E - Saite: Die Namen der sechs Saiten einer Gitarre, von der tiefsten (E) bis zur höchsten (hohe E).

/ Floyd-Rose: Erfinder des gleichnamigen Tremolosystems, das in vielen E-Gitarren verwendet wird.

/ Sattel: Ein fester Punkt am Gitarrenhals (vgl. @figBegriffe).

/ MAUI: Multi-platform App UI

/ Saite: Ein Dünner Draht, der zwischen Sattel und Brücke einer Gitarre gespannt ist und beim Anschlagen schwingt, um Töne zu erzeugen.

/ Stimmen einer Gitarre: Der Prozess, bei dem die Spannung der Saiten angepasst wird, um die gewünschten Tonhöhen zu erreichen.
/ Stimmung: Die Stimmung im Kontext von Gitarren bezeichnet die spezifische Tonhöhe, auf die die sechs Saiten des Instruments eingestellt sind. Sie legt fest, welche Töne erklingen, wenn die Saiten leer (ohne Greifen im Bund) angeschlagen werden.
/ Stimmwirbel: ein drehbarer Stift aus Metall oder Holz an Saiteninstrumenten, um den das Ende einer Saite gewickelt wird.
/ Tremolo: Eine spezielle Art von Gitarrenbrücke, die es ermöglicht, die Tonhöhe der Saiten durch Bewegung eines Hebels zu verändern.

/ Tuning: der englische Begriff für Stimmung
/ VST: Virtual Studio Technology ist eine Programmierschnittstelle für Audio-Plug-ins. Damit können virtuelle Effekte programmiert werden.

#figure(
  image("assets/gitarren_begriffe.png", height: 30%),
  caption: [Wichtige Bauteile einer E-Gitarre mit Floyd-Rose-Tremolo],
)<figBegriffe>
#pagebreak()
#heading(depth: 1, "Abbildungsverzeichnis", numbering: none, outlined: false)
#outline(
  title: none,
  target: figure.where(kind: image),
)

#pagebreak()
// #heading(depth: 1, "Tabellenverzeichnis", numbering: none, outlined: false)
// #outline(
//   title: none,
//   target: figure.where(kind: table),
// )
// #pagebreak()

#bibliography("bib.bib")


