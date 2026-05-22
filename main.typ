#let project(
  title: "Entwicklung einer Mobilen Applikation zur effizienten Stimmung einer \n Floyd-Rose-Gitarre",
  subtitle: none,
  author: "Raphael Schütz",
  matrikelnummer: "82832",
  semester: "7",
  erstprüfer: "Prof. Konrad Schöbel",
  zweitprüfer: "Prof. Ulf Schemmert",
  date: "09.06.2026",
  logos: "assets/htwk-logo.png",
  abbildungsverzeichnis: true,
) = {
  v(0.2fr)
  align(center)[
    #image(logos, width: 50%)
  ]
  v(5fr)
  align(center)[
    #text(size: 35pt)[*Bachelor Thesis*]
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
  outline(depth: 5)
  pagebreak()
}

// Set body font family.
#set text(lang: "de")
#set math.equation(numbering: "(1)")
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

Es gibt ein Problem beim Stimmen von Floyd-Rose-Gitarren. Bei diesen Gitarren wird eine Saite zwischen dem Gitarrenkopf und einer bis zu einem gewissen Grad rotierbaren Brücke gespannt. An der Brücke halten unterhalb des Drehpunkts Federn dagegen, wenn man Saiten einspannt. Die Brücke wird gemeinhin als "Floating Bridge" bezeichnet, weil sie nicht wie herkömmliche Tremolos am Gitarrenkörper aufliegt, sondern zusätzlichen Rotationsspielraum in Richtung des Gitarrenkörpers hat.

#figure(image("assets/floydrose_frontside_neutral.jpg", height: 20%), caption: [Floyd-Rose-Tremolo Bild])<FRQuer>

Das Floyd-Rose-Tremolo hat einen Hebel, den man ziehen oder drücken kann. Beim Musizieren ändert das den Ton. Auch wenn diese Architektur beliebt ist, weil sie neue Klänge ermöglicht, erschwert sie das Stimmen der Gitarre erheblich. Beim Stimmen erhöht oder verringert man die Spannung einer Saite. Aber das führt dazu, dass die anderen Saiten verstimmt werden. Es gibt Erfahrungsberichte und Aufzeichnungen, wie man eine solche Gitarre effizient stimmen kann. Dabei dauerte das Stimmen 8 Minuten @youtube_floyd_rose_tune2026. In Foren sprachen Nutzer von einer Stimmzeit von bis zu 20-30 Minuten, je nachdem, wie sauber und wie viele Saiten sie stimmen mussten @ultimateguitar_floydrose_tuning_forum. Ziel der Arbeit ist eine App zu entwickeln, die diesen Stimmvorgang beschleunigt.

= Grundlagen (Physik der Gitarre)

Die Gitarre spannt 6 Saiten zwischen Brücke und Sattel. Die Saiten schwingen in einer bestimmten Frequenz. Beim Stimmen wickelt man die Saite um den Stimmwirbel, sodass sich Spannung und Frequenz ändert. Dass Saiten elastisch sind, wird im folgenden Experiment gezeigt:

#figure(
  image("assets/stimmwirbel.png", height: 34%),
  caption: [Gitarre Stimmwirbel],
)<figStimmwirbel>

== Experiment: Elastizität von Gitarrensaiten

Die Ergebnisse des Experiments stammen aus der Arbeit des Autors, welche im Rahmen des Moduls "Projekt 3" aus dem Telekommunikationsinformatik-Studium an der HTWK-Leipzig @Schuetz2026FloydRose angefertigt wurden.

In der folgenden Tabelle sind Bilder, die die elastische Dehnung der Saite zeigen:
#{
  let fret-row(bund, img_pac, cap_pac, img_pac_t, cap_pac_t) = (
    [#bund],
    figure(image(img_pac, width: 8.5em), caption: [#cap_pac]),
    figure(image(img_pac_t, width: 8.5em), caption: [#cap_pac_t]),
  )

  set text(size: 8.5pt)
  show figure: set block(breakable: true)
  figure(
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
    ),
    caption: [Elastizität von Gitarrensaiten],
  )
}<table1>

Die Markierungen, die sich näher am Sattel befanden, legten eine deutlich größere Strecke zurück als jene in unmittelbarer Nähe der Brücke. Die beobachtete Verschiebung nahm kontinuierlich vom Sattel in Richtung Brücke ab.

Die Kontrollmarkierungen auf den übrigen Saiten zeigten dagegen keine oder lediglich eine kaum wahrnehmbare Bewegung. Dies spricht dafür, dass die beobachtete Verschiebung nicht durch ein Verformen des Instruments verursacht wurde, sondern auf eine tatsächliche Längenänderung der gespannten Saite zurückzuführen ist. Als die Saite wieder entspannt wurde, waren die Markierungen wieder an ihrer Ausgangsposition. Die Schwingungsfrequenz der Saite war auch wieder dieselbe wie zu Beginn.

Die Beobachtungen belegen das elastische Verhalten von Gitarrensaiten.
Wird die Spannung durch Aufwickeln am Stimmwirbel erhöht, verschieben sich die aufgeklebten Markierungen entlang der Saite in unterschiedlichem Ausmaß. Markierungen in der Nähe der Brücke, die als nahezu fixer Punkt wirkt, erfahren nur eine sehr geringe Verschiebung, während weiter entfernte Markierungen deutlich stärker wandern.

== Physikalisches Modell
Im Folgenden wird ein physikalisches Modell der Gitarre beschrieben, um zu verstehen warum die Floyd-Rose-Gitarre so schwierig zu stimmen ist.

Die Gitarre wird als Abbildung modelliert, die 6 Aufwickelstrecken $arrow(Delta L) = vec(Delta L_1, dots.v, Delta L_i, dots.v, Delta L_6)$ auf einen Frequenzvektor $arrow(f) = vec(f_1, dots.v, f_i, dots.v, f_6)$ abbildet
$arrow(Delta L) -> arrow(f)$, wobei jede Komponente zu einer Saite gehört. Beim Stimmen muss $arrow(Delta L)$ so gewählt werden, dass genau die gewünschten Frequenzen erreicht werden.
Das Ziel ist die Funktion $f(arrow(Delta L))$ zu bestimmen.
Der Zusammenhang zwischen effektiver Saitenlänge $L_(S,i)$, Zugkraft $F_(S,i)$,
linearer Massendichte $mu_i$ und Frequenz $f_i$ wird durch das Mersennesche Gesetz beschrieben
@jeans1968science:

$
  f_i = 1 / (2 L_(S,i)) sqrt(F_(S,i) / mu_i)
$<eqMersenne>

Zunächst wird die Saitenkraft $F_(S,i)$ als Funktion der Aufwickelstrecken $arrow(Delta L)$ bestimmt. Die Kraft die auf die Saite wirkt, wird durch das Hooksche Gesetz beschrieben @beer2020:

$ F_(S,i) = (L_(S,i) - L_(0S,i)) dot k_(S,i) $<eqSaitenkraft>

$L_(0S,i)$ beschreibt die unbelastete Saitenlänge im Abschnitt zwischen Sattel und Brücke. Diese Länge wird durch die Aufwickelstrecke $Delta L_i$ beeinflusst. $L'_(0S,i)$ sei die initiale unbelastete Saitenlänge.

$
  L_(0S,i) = L'_(0S,i) - Delta L_i
$<eqUnbelasteteSaitenlänge>


#figure(
  image("assets/FloydRoseQuer.png"),
  caption: [Floyd-Rose-Modell Quer],
)<FRMQuer>

#figure(image("assets/floydrose_backside_neutral.jpg", height: 20%), caption: [Tremolofedern])<FRFedern>


In @FRQuer, @FRMQuer und @FRFedern ist zu sehen, wie die Brücke die Tremolofedern und die Saiten über einen Drehmoment koppelt.  Die Tremolofedern dienen unterhalb der Brücke als Gegenkraft zu der Saitenspannung.


#grid(
  columns: 2,
  inset: 6pt,
  grid.cell([
    #figure(
      image("assets/FlyodRoseTop.png"),
      caption: [Floyd-Rose-Modell Draufsicht],
    ) <FRMTop>
  ]),
  grid.cell([
    #figure(
      image("assets/FRrealTop.png"),
      caption: [Floyd-Rose Draufsicht],
    )<FRTop>
  ]),
)


In der Realität hat jede Saite ihre eigene Saitenlänge, wie in @FRMTop und @FRTop zu sehen ist. Sie variieren zwar nur minimal haben aber einen Einfluss auf die rotatorische Projektion der Kräfte.

Die Brücke wird als starrer, gewinkelter Hebel betrachtet, siehe @FRMQuer.
Die Drehachse liege im Koordinatenursprung.
Die Vektoren $arrow(h_hat(F))$ (Hebelarm der Feder) und $arrow(h_(S,i))$ (Hebelarm der Saite i)
schließen konstruktionsbedingt einen konstanten Winkel $alpha_i$ ein.
Die Beträge $h_hat(F)$ und $h_(S,i)$ sind systemspezifische Konstanten. Jede Saite erhält ihren eigenen Hebelarm $arrow(h_(S,i))$, um den Aufbau wie in @FRTop und @FRMTop korrekt zu modellieren. Die Tremolofedern erhalten in diesem Modell einen gemeinsamen Hebelarm $arrow(h_hat(F))$.

$
  arrow(h_hat(F))(beta) = h_hat(F) vec(cos(beta), sin(beta))
$


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

Nun soll die Variable $beta$ bestimmt werden, die sich aus dem Kräftegleichgewicht und der darausfolgenden Hebelposition ergibt. Nach den Gesetzen der Statik trägt ausschließlich der zur jeweiligen Hebelarmrichtung orthogonale Kraftanteil zum Drehmoment bei @tipler2015.
Im stationären Gleichgewicht gilt das Drehmomentgleichgewicht:

$
  sum^6_(i=1) F_(S,i, bot h_(S,i)) dot h_(S,i) = F_(hat(F) bot h_hat(F)) dot h_hat(F)
$ <eqBrückenkraftgleichgewicht>

Dabei bezeichnen $F_(S,i, bot h_(S,i))$ und  $F_(hat(F) bot h_hat(F))$ jeweils die Anteile der Kräfte
$arrow(F_(S,i))$ und $arrow(F_hat(F))$, die orthogonal zu den Hebelarmen $arrow(h_(S,i))$ und $arrow(h_hat(F))$ wirken. Auf der linken Seite von @eqBrückenkraftgleichgewicht müssen die Kräfte der 6 Saiten aufaddiert werden, da sich die Kräfte parallelgeschalteter Federn addieren @beer2020.

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
Aus der orthogonalen Projektion eines Vektors $arrow(a)$ bezüglich eines Vektors $arrow(b)$ folgt @Glaister01032001:

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

Dabei bezeichnet $m_i$ die Gesamtmasse und $L_"S,i,Total"$ die Gesamtlänge der Saite $i$.
Die Gesamtlänge setzt sich zusammen aus der effektiven Saitenlänge $L_(S,i)$ und der Teil der Saite der hinter dem Sattel liegt,
wie in @figStimmwirbel und @FRMTop zu sehen ist.

Diese Strecke sei $L_(M,i) = L_(0M,i)+Delta L_i$.

$
  L_"S,i,Total" (arrow(Delta L)) = L_(S,i) (arrow(Delta L)) + L_(0M,i) + Delta L_i
$

Beim Aufwickeln der Saite erhöht sich die Strecke hinter dem Sattel um $Delta L_i$. Die zusätzliche Strecke, die durch die Dehnung entsteht steckt in $Delta L_(S,i)(arrow(Delta L))$.

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

Beim Stimmen werden die Aufwickelstrecken nur in kleinen Schritten verändert. In diesem Fall verhält sich das System näherungsweise linear. Da das System physikalisch ist, können wir das System als stetig betrachten.

== Experiment: Nachweis Linearität
Diese Linearität wurde bereits experimentell in der _Projekt 3_ Arbeit des Autors @Schuetz2026FloydRose überprüft.

=== Vorgehensweise
Zunächst wurde jede Saite in eine Ausgangsposition gebracht. Die Ausgangsfrequenzen der Saiten wurden in Hertz gemessen.
Anschließend wurde jeweils eine Saite um ein beliebiges $Delta$ (in Hertz) verstimmt. Dieses $Delta$ wurde so gewählt, dass die Verstimmung deutlich hörbar ist. Für jeden Schritt wurde die Frequenz aller anderen Saiten gemessen.

#figure(
  table(
    columns: (auto, auto, auto),
    inset: 8pt,
    stroke: .5pt,
    [*Nr.*], [*Saite*], [*Frequenz*],
    [1], [E2 = E-Saite], [82.41 Hz],
    [2], [A2 = A-Saite], [110 Hz],
    [3], [D3 = D-Saite], [146.83 Hz],
    [4], [G3 = G-Saite], [196 Hz],
    [5], [B3 = B-Saite], [246.94 Hz],
    [6], [E4 = hohe E-Saite], [329.63 Hz],
  ),
  caption: "Saitennamen mit Frequenzen",
)<tableSaitenNamen>
=== Ergebnisse
==== Relative Visualisierung der Frequenzänderungen
#grid(
  columns: 2,
  inset: 6pt,
  grid.cell([
    #figure(
      image("assets/plot_E2_relative Hz.png"),
      caption: [Relativer Einluss der E2 Saite auf die anderen Saiten],
    ) <relativeE2>
  ]),
  grid.cell([
    #figure(
      image("assets/plot_A2_relative Hz.png"),
      caption: [Relativer Einluss der A2 Saite auf die anderen Saiten],
    ) <relativeA2>
  ]),
  grid.cell([
    #figure(
      image("assets/plot_D3_relative Hz.png"),
      caption: [Relativer Einluss der D3 Saite auf die anderen Saiten],
    ) <relativeD3>
  ]),
  grid.cell([
    #figure(
      image("assets/plot_G3_relative Hz.png"),
      caption: [Relativer Einluss der G3 Saite auf die anderen Saiten],
    ) <relativeG3>
  ]),
  grid.cell([
    #figure(
      image("assets/plot_B3_relative Hz.png"),
      caption: [Relativer Einluss der B3 Saite auf die anderen Saiten],
    ) <relativeB3>
  ]),
  grid.cell([
    #figure(
      image("assets/plot_E4_relative Hz.png"),
      caption: [Relativer Einluss der E4 Saite auf die anderen Saiten],
    ) <relativeE4>
  ]),
)
==== Korrelationskoeffizienten und Fehler

#figure(
  image("assets/pearson_correlation.png"),
  caption: [Pearson-Korrelationskoeffizienten der Messdaten],
) <correlations>

Während der Durchführung des Experiments fiel auf, dass beim Zurückbringen einer Saite in ihre Ausgangsposition alle anderen Saiten ebenfalls wieder ihre ursprüngliche Frequenz annahmen.

=== Diskussion der Ergebnisse
Das System ist elastisch, da Ausgangs- und Endfrequenzen nach jedem Durchgang gleich sind.

Die Linearität des Systems ist nicht perfekt, aber hinreichend gut für kleine Verstimmungen. Sie lässt sich quantitativ mit dem Korrelationskoeffizienten nach Bravais-Pearson @pearson1896 zwischen gemessenen und erwarteten Frequenzänderungen jeder Saite bestimmen.
In @correlations sind die Korrelationskoeffizienten für jede Saite dargestellt. Der Betrag aller Werte liegt über 0.98, was auf eine sehr starke positive Korrelation hinweist. Das rechtfertigt die Annahme einer linearen Beziehung für kleine Änderungen.

== Mathematische Lösung
Die Frequenzen der Saiten können als Vektor dargestellt werden:

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
- $C$: Verstimmungsmatrix, wobei $c_"ij"$ den Verstimmungsfaktor der Saite $i$ angibt, wenn die Saite $j$ um 1Hz verstimmt wird
- $arrow(g)$: Ziel-Frequenzen nach der Verstimmung

Die Verstimmungsmatrix aus dem Experiment ist in @distortionMatrix dargestellt:

#figure(
  image("assets/detuning_matrix_example.png", height: 40%),
  caption: [Verstimmungsmatrix Beispiel],
) <distortionMatrix>
Der Vektor

$
  arrow(Delta) = vec(Delta_"E2", Delta_"A2", Delta_"D3", Delta_"G3", Delta_"B3", Delta_"E4")
$

gibt an, um wie viel Hertz jede Saite verstimmt werden muss.

Die effektive Verstimmung wird durch die Multiplikation mit der Verstimmungsmatrix berechnet:

$
  C dot arrow(Delta) = arrow(Delta)_"effective"
$

Damit die Ziel-Frequenzen $arrow(g)$ erreicht werden, gilt:

$
  arrow(g) = arrow(f_0) + arrow(Delta)_"effective" quad arrow quad arrow(Delta)_"effective" = arrow(g)-arrow(f_0)
$

Um die Eingangsverstimmung $arrow(Delta)$ zu bestimmen, muss das Inverse der Matrix $C$ gebildet werden:

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

== Praktische Umwandlung

Für die praktische Anwendung ist die absolute Zielfrequenz jeder Saite entscheidend, da ein Musiker direkt auf einen Frequenzwert stimmen kann, ohne eine mentale Addition durchführen zu müssen.

Da die Saiten sequentiell in der Reihenfolge E2 $arrow$ A2 $arrow$ D3 $arrow$
G3 $arrow$ B3 $arrow$ E4 gestimmt werden, beeinflusst jede Verstimmung einer
Saite $j$ über die Verstimmungsmatrix $C$ alle nachfolgenden Saiten $i >= j$.
Dieser Kaskadeneffekt muss bei der Berechnung der absoluten Zielfrequenzen
berücksichtigt werden.

Für die erste Saite E2 ergibt sich die Zielfrequenz zu:

$
  f_"E2" = f_"0,E2" + Delta_"E2" dot C_"11"
$

Da E2 bereits auf den Sollwert gestimmt wurde, muss dessen Einfluss auf alle
nachfolgenden Saiten eingerechnet werden. Die Zielfrequenz von A2 lautet
dementsprechend:

$
  f_"A2" = f_"0,A2" + Delta_"A2" dot C_"22" + Delta_"E2" dot C_"21"
$

Analog ergibt sich für D3:

$
  f_"D3" = f_"0,D3" + Delta_"D3" dot C_"33" + Delta_"A2" dot C_"32"
  + Delta_"E2" dot C_"31"
$

Dieses Muster lässt sich verallgemeinern. Die absolute Zielfrequenz der $N$-ten
Saite berechnet sich als:

$
  f_N = f_"0,N" + sum_(i=1)^(N) Delta_i dot C_(N\,i)
$<eqFloydRoseTuner>

Hierbei wird vorausgesetzt, dass die Saiten stets in aufsteigender Reihenfolge
von E2 nach E4 gestimmt werden, sodass die Verstimmungseinflüsse bereits
gestimmter Saiten vollständig bekannt sind und in die Berechnung der
nachfolgenden Zielfrequenzen einfließen können.
= Ablauf eines Stimmvorgangs

Im Folgenden wird der Ablauf zum Stimmen einer Floyd-Rose-Gitarre beschrieben
sowie die dafür erforderlichen Verfahren erläutert.

== Initiierung -- Bestimmung der Verstimmungsmatrix
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

== Stimmvorgang

Zunächst wird die gewünschte Zielstimmung festgelegt. Gitarren werden je nach
musikalischem Kontext in verschiedenen Stimmungen gespielt, da bestimmte
Akkordgriffe in alternativen Stimmungen vereinfacht oder erst ermöglicht werden.

Anschließend wird der aktuelle Zustand der Gitarre durch eine einmalige
Frequenzmessung aller Saiten erfasst, um den Frequenzvektor $arrow(f_0)$ zu
bestimmen. Mithilfe von @eqFloydRoseTuner wird dann für jede Saite die absolute
Zielfrequenz berechnet, auf die sie gestimmt werden muss.

== Überprüfung
Abschließend wird mithilfe eines herkömmlichen Stimmgeräts verifiziert, ob alle
Saiten die berechneten Zielfrequenzen erreicht haben und die Gitarre korrekt
gestimmt ist.

= Grundlegende Verfahren
Im Folgenden werden die Verfahren beschrieben, die für die Umsetzung des
Stimmvorgangs erforderlich sind.
== Bestimmung der Fundamentalfrequenz

Für die Implementierung eines Stimmgeräts auf mobilen Geräten ist die präzise
und effiziente Bestimmung der Grundfrequenz (Fundamental Frequency, F0)
entscheidend. Im Folgenden werden gängige Verfahren vorgestellt und hinsichtlich
Genauigkeit, Rechenaufwand und Anwendungsbereich bewertet.


=== Autokorrelation
Die Grundidee der Autokorrelation beruht darauf, dass ein periodisches Signal
mit der Periode $tau$, wenn es mit einer zeitverschobenen Version seiner selbst
multipliziert wird, bei ganzzahligen Vielfachen von $tau$ Maxima aufweist. Das
erste von null verschiedene lokale Maximum bestimmt die gesuchte Periode $tau$;
ihr Kehrwert liefert die Grundfrequenz des Signals.

$
  r_t (tau) = sum_(j=t+1)^(t+W) x_j dot x_(j+tau)
$

Dabei bezeichnet $r_t (tau)$ den Autokorrelationswert für die Verzögerung $tau$
zum Zeitindex $t$ und $W$ die Fenstergröße der Integration. @YIN

=== YIN-Algorithmus

Der YIN-Algorithmus stellt eine Weiterentwicklung der klassischen
Autokorrelation dar. Durch zusätzliche Fehlerreduktionsschritte wird die
Robustheit gegenüber Amplitudenschwankungen verbessert; die sogenannte
_Difference Function_ filtert dabei unplausible Perioden $tau$ heraus. @YIN
Aufgrund dieser Eigenschaften findet der Algorithmus breite Anwendung in
kommerziellen Stimmgeräten.
=== Fourier- und Cepstrum-Analyse

Bei der Fourier-Analyse wird das Zeitsignal in den Frequenzbereich transformiert
und das resultierende Spektrum nach der Grundfrequenz durchsucht. Studien zeigen
jedoch, dass Fourier-basierte Verfahren fehleranfällig sind und hohe
Abtastraten erfordern. @FFT_NEEDS_HIGH_SAMPLING

Die Cepstrum-Analyse erweitert diesen Ansatz, indem das logarithmierte Spektrum
erneut transformiert wird, um periodische Muster zu detektieren. Ein Vorteil
ist die Robustheit gegenüber harmonischen Obertönen sowie die gute Integration
in digitale Signalverarbeitungssysteme. Nachteilig wirkt sich die eingeschränkte
Genauigkeit bei niedrigen Frequenzen und verrauschten Signalen aus, da das
Verfahren Periodizität und harmonische Obertöne voraussetzt -- Annahmen, die in
realen Umgebungen nicht immer erfüllt sind. @Noll1967Cepstrum

=== Moderne Deep-Learning-Ansätze

Neuronale Netze wie CREPE oder DeepPitch nutzen Convolutional Neural Networks
oder Recurrent Neural Networks, um die Grundfrequenz direkt aus Roh-Audio oder
Spektrogrammen zu schätzen. Vorteile sind die hohe Robustheit gegenüber
Polyphonie, Hintergrundgeräuschen und verschiedenen Instrumenten. Nachteilig
sind der erhebliche Rechenaufwand, der Bedarf an großen Trainingsdatensätzen
sowie die eingeschränkte Eignung für ressourcenbeschränkte Mobilgeräte.
@Kim2019CREPE

=== Auswahl des Verfahrens
Für die Implementierung wird der YIN-Algorithmus gewählt, da er eine
ausgewogene Balance zwischen Genauigkeit und Rechenaufwand bietet. Er ist
speziell für die Schätzung monophoner Grundfrequenzen entwickelt worden, zeigt
robuste Leistung unter variierenden Signalbedingungen und ist in zahlreichen
Programmiersprachen bereits als Bibliothek verfügbar.

== Signal-Filter
Um die Zuverlässigkeit der Grundfrequenzschätzung zu erhöhen, wird Ein- und Ausgangssignal gefiltert und konditioniert.
=== Bandpassfilterung durch Parameteranpassung
Da der YIN-Algorithmus verwendet wird, lässt sich eine implizite
Bandpassfilterung durch gezielte Anpassung seiner Parameter erreichen. Durch
Reduktion der Abtastrate werden Frequenzen oberhalb der halben Nyquist-Frequenz
nicht mehr erfasst, was dem Nyquist-Shannon-Abtasttheorem entspricht.
@oppenheim1999discrete

Die untere Grenzfrequenz wird durch die maximale Fensterlänge $W$ begrenzt.
Gemäß $f = 1 slash T$ darf die Fensterlänge den Wert $T_"max" = 1 slash f_"min"$ #footnote[Mit "min" ist das Minimum gemeint.]
nicht überschreiten. Da der Frequenzbereich von Gitarrensaiten näherungsweise
$50 "Hz"$ bis $350 "Hz"$ umfasst, lassen sich die Parameter entsprechend
dimensionieren.
=== Gleitender Mittelwert für Streaming-Messdaten
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

= Software Entwicklung/Implementierung

Die Methodik der Softwareentwicklung wurde primär durch das Buch "Mobile App Engineering" @mobileAppEngineering inspiriert.

Das Buch beschäftigt sich mit der Entwicklung von _Enterprise Apps_. Die in diesem Rahmen entwickelte App ist zwar keine _Enterprise App_, aber die Prinzipien der Softwareentwicklung, die in diesem Buch beschrieben werden, sind dennoch anwendbar. Es werden insbesondere die Prinzipien der Anforderungsanalyse und der nutzerzentrierten Gestaltung übernommen.

Wie im Buch beschrieben, werden Mobile Applikationen in iterativen Prozessen entwickelt. Daher werden manche Designentscheidungen mit Usertests begründet, die mit einer älteren Version der App durchgeführt wurden.

== Requirements Engineering
Dieses Kapitel wurde mit Hilfe des Buchs "Mobile App Engineering" @mobileAppEngineering entwickelt. Die Ergebnisse folgen aus der befolgung des Kapitel 4 "Requirements Engineering".

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

=== Personas

Um die Anforderungen der Zielgruppe greifbar zu machen, wurden auf
Basis der
Zielgruppensegmente vier repräsentative Personas entwickelt.

==== Emil -- Gitarren-Einsteiger

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

==== Matilda -- Professionelle Gitarristin

Matilda ist 38 Jahre alt und verdient ihren Lebensunterhalt als Gitarristin
ihrer Metalband „Fire Hawks". Sie spielt seit 20 Jahren E-Gitarre und besitzt
eine Sammlung mehrerer Instrumente, darunter ihre bevorzugte Music Man
Silhouette mit Floyd-Rose-Tremolo.

Da sie ihre Saiten aufgrund intensiver Bespielung regelmäßig wechselt, ist
das Neustimmen für sie Routine. Matilda wechselt häufig zwischen Standard- und
Drop-D-Stimmung und schätzt dabei Effizienz. Sie kommuniziert per E-Mail,
Telefon und WhatsApp; als Musikerin nutzt sie bewusst Streaming-Plattformen,
die Künstler stärker vergüten als marktführende Dienste.

*Relevanz:* Matilda repräsentiert erfahrene Nutzerinnen, die schnelle Workflows
und die Unterstützung mehrerer Stimmungen priorisieren.

==== Jonas -- Gitarrentechniker <jonasGit>

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

==== Hanna -- Home-Producerin

Hanna ist 30 Jahre alt und betreibt ein eigenes Heimstudio, in dem sie
regelmäßig Bands aufnimmt und mischt -- darunter die Band „Fire Hawks". Sie
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

==== Szenario 1 -- Emils erster Versuch

*Normaler Ablauf:*
Emil kommt nach einem langen Arbeitstag nach Hause und möchte zur Entspannung
Gitarre spielen. Über eine YouTube-Empfehlung wird er auf die Applikation
aufmerksam und hofft, damit den Kauf einer neuen Gitarre vermeiden zu können.
Er lädt die App herunter, setzt sich mit der Gitarre auf den Boden seines
Wohnzimmers und legt das Smartphone vor sich.

Nach dem Start der Applikation kann er eine Zielstimmung sowie ein
Gitarrenprofil auswählen. Da noch kein Profil existiert, legt er über einen
prominenten Button eine neue Gitarre an und benennt sie „Onkel Ullies Gitarre".
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

==== Szenario 2 -- Matilda auf einer Jam-Session

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

// ============================================================
// Hilfsfunktion: eine einzelne Anforderung als referenzierbaren
// Block rendern. Aufruf:
//   #req("FBA-01", "MUSS", [Inhalt]) <req-fba-01>
// Referenz im Text:
//   @req-fba-01
// ============================================================

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

==== Funktionale Benutzeranforderungen

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
  [Ein Nutzer sollte die Prezision des Stimmungsprozesses erhöhen können],
) <req-fba-16>
==== Funktionale Systemanforderungen

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
  [Das System muss nach einer vollständigen Zustandsmessung aller Saiten ($arrow(f_0)$) für jede Saite $N$ die absolute Zielfrequenz gemäß
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

==== Nichtfunktionale Anforderungen

===== Messgenauigkeit

#req(
  "NFA-MG-01",
  "MUSS",
  [Das System muss die Grundfrequenz einer Gitarrensaite mit einer Abweichung von maximal $±0.2 "Hz"$ vom wahren Wert schätzen, gemessen unter kontrollierten akustischen Bedingungen.],
) <req-nfa-mg-01>

#req(
  "NFA-MG-02",
  "MUSS",
  [Das System muss harmonische Obertöne von der Grundfrequenz unterscheiden und darf diese nicht als Grundfrequenz ausgeben, sofern der Signalpegel des Grundtons den Schwellenwert überschreitet.],
) <req-nfa-mg-02>

#req(
  "NFA-MG-03",
  "SOLL",
  [Das System sollte auch bei unverstärktem Spiel eine Messgenauigkeit von $±0.1 "Hz"$ einhalten.#footnote([Da Töne logarithmisch wahrgenommen werden, steigt die geforderte absolute Genauigkeit mit sinkender Frequenz.])],
) <req-nfa-mg-03>

===== Latenz

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

===== Robustheit

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

===== Bedienbarkeit

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

===== Kompatibilität

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

===== Datenschutz und Betrieb

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

==== Ausgeschlossene Anforderungen

Die folgenden Anwendungsfälle liegen explizit außerhalb des definierten
Projektumfangs und werden nicht berücksichtigt:

- Integration in professionelle Musikstudio-Umgebungen
- Verwendbarkeit als Plugin für Digital Audio Workstations (DAW)
- Netzwerkbasierte Funktionen wie Cloud-Synchronisation oder
  Mehrgeräte-Unterstützung

==== Hinweis

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
warten. Cross-Platform-Entwicklung mit _Flutter_ vermeidet diese
Redundanz durch eine gemeinsame Codebasis, aus der plattformspezifische
Artefakte für iOS und Android erzeugt werden.

Da die Applikation gemäß @req-nfa-dp-01 und @req-nfa-dp-02 vollständig
lokal und ohne Netzwerkzugriff betrieben wird, entfallen die
Hauptargumente gegen Cross-Platform-Ansätze: Es gibt keine
plattformspezifischen Push-Benachrichtigungen, keine
hardwarenahen Hintergrunddienste und keine nativen
Zahlungsschnittstellen. Der einzige plattformnahe Zugriff -- das
Gerätmikrofon -- wird von _Flutter_ über eine stabile,
plattformübergreifende API abgedeckt. Der Effizienzgewinn einer
gemeinsamen Codebasis überwiegt daher den Mehraufwand einer rein
nativen Implementierung deutlich.

== Konzeption und Design
=== Informationsarchitektur
#figure(image("assets/infoarch.png"), caption: [Informationsarchitektur der Floyd-Rose-Tuner-App]) <infArch>

In @infArch ist die Informationsarchitektur zu sehen. Auf höchster Ebene soll der Kern zufinden Sein. Die Initiierung des Stimmvorgangs. In dieser sollen die Wichtigsten Informationen erreichbar sein.
1. Hilfe
2. Gitarre Auswählen für den Stimmprozess
3. Standard Tuner da evtl nur geprüft werden soll ob eine gitarre in Stimmung ist.
4. Stimmung Auswählen
5. Gitarre Anlegen (Da die Persona Jonas -- Gitarrentechniker aus @jonasGit) täglich neue Gitarren stimmen muss.
6. Floyd-Rose-Stimmen -- Das Herz der App

Wird eine Gitarre Ausgewählt sollte man sie Editieren(umbennenen und rekalibrieren) und Löschen können.

Wird eine Gitarre Angelegt soll sie auch Benannt und Kalibriert werden.

=== Interaktionsdesign
#figure(image("assets/interaktionsdesign.png"), caption: [Interaktionsdesign mit _visuelles Vokabular_])<visVoc>

#figure(image("assets/interaktionsdesign2.png"), caption: [Interaktionsdesign für Kalibrierung.])

In @visVoc wurde die Grafische Sprache _visuelles Vokabular_ erstellt nach @Garrett2012 zur erstellung des Interaktionsdesigns verwendet.

Man startet auf der Floyd-Rose-Initierungsseite von der man auf die Hilfspage, die Standard Stimmgerät Page, die Gitarren bennen Page, die Kalibrierungsapage auf der man die Verstimmungsmatrix bestimmt, auf die gitarren Messpage mit der man jede Gitarren Saite anspielt und misst.
Nach dem man die gitarre Gemessen hat, kann man diese Information nutzen direkt zum Floyd-Rose-Stimmgerät navigieren. Vom Floyd-Rose-Stimmgerät kommt man wiederum zum Standard-Stimmgerät um das Ergebnis des Floyd-Rose-Stimmgeräts zu überprüfen.


=== Visuelles Konzept
Da die App zunächst nur auf Android getestet werden kann, werden die Gestaltungsrichtlinien und Componenten von Google, das Material 3 Designsystem verwendet. Dies Beinhaltet bereits standarts für Schriftgrößen, Farben, Icons, Buttonzuständen und Navigationsleisten.

Da später flutter verwendet wird, ist von haus aus Material 3 komponenten importierbar. Außerdem werden für Konzept und Design entwicklung Figma benutzt, wo ebenfalls Material 3 Komponenten einfach importierbar und verwendbar sind.
=== Prototypen
Die App wirde zunächst als sogenannten vertikalen Protyp entwickelt. Dabei wurde zuerst überprüft ob die Anforderung @req-fba-01 überhaupt umsetzbar ist. Anschließend wurde die UI überarbeitet, dass auch weniger technische Leute die App benutzen konnten.

Screenshots von älteren versionen.
#image("assets/prototyp_create_guitar.png")

#image("assets/prototyp_calibration.png")
=== Finale Wireframes
#grid(
  columns: 3,
  inset: 6pt,
  grid.cell([
    #figure(
      image("assets/wf_landing.png"),
      caption: [Wireframe: Initiierungspage für Floyd-Rose-Stimmgerät],
    ) <wfLanding>
  ]),
  grid.cell([
    #figure(
      image("assets/wf_gitarren_editierung.png"),
      caption: [Wireframe: Gitarre Editierungspage],
    ) <wfGitarreEdit>
  ]),
  grid.cell([
    #figure(
      image("assets/wf_kalibrierung1.png"),
      caption: [Wireframe: Kalibrierungspage Saite messen],
    ) <wfKalMessen>
  ]),
  grid.cell([
    #figure(
      image("assets/wf_kalibrierung2.png"),
      caption: [Wireframe: Kalibrierungspage Messungprüfen],
    ) <wfKalPrüf>
  ]),
  grid.cell([
    #figure(
      image("assets/wf_kalibrierung3.png"),
      caption: [Wireframe: Kalibrierungspage Saite verändern],
    ) <wfKalVerändern>
  ]),
  grid.cell([
    #figure(
      image("assets/wf_check_kalibrierung.png"),
      caption: [Wireframe: Überprüfung der Messwerte Seite],
    ) <wfStandardTuner>
  ]),
  grid.cell([
    #figure(
      image("assets/wf_hilfe_page.png"),
      caption: [Wireframe: Hilfsseite],
    ) <wfHelp>
  ]),
  grid.cell([
    #figure(
      image("assets/wf_standard_tuner.png"),
      caption: [Wireframe: Standard Stimmgerärtseite],
    ) <wfStandardTuner>
  ]),
)
=== Seitenspezifikation

==== First Load

//#figure(image("assets/image-2.png", height: 40%), caption: [Landing Page])<appLanding>
Wenn man die App startet, sieht man als erstes die Möglichkeit das _Tuning_ einzustellen, die bereits auf die standartmäßige Stimmung _E-A-D-G-H-e_ eingestellt ist //(Siehe @appLanding).
//#figure(image("assets/image-3.png", height: 40%), caption: [Selecting Tuning Page])<appSelectTuning>
Versucht man ein anderes _Tuning_ auszuwählen, sieht man wie in //@appSelectTuning eine größere Auswahl von herkömmlichen Stimmungen.

Da die App noch keine Gitarre erlernt hat, wird in der Auswahl die Aufforderung angezeigt, eine Gitarre auszuwähle//n (@appLanding). Zu beginn der das Dropdown Menu enthält zunächst keine Gitarre. Allerdings kann, der Nutzer auf den Button "Add A New Guitar" klicken und kommt nun zur _Detuning Matrix Measure Page_.

=== Detuning Matrix Measure Page
Auf dieser Saite, nimmt man die Messdaten auf um die Verstimmungsmatrix zu bestimmen.


//#figure(image("assets/image-4.png", height: 40%), caption: [Measure Detuning Matrix Page])<appDetuningMatrixPage>

Diese Seite ist die Komplizierteste. Ganz oben ist ein Zufällig generierter Name für die Gitarre. Beim öffnen der Saite kann man direkt den Namen der Gitarre einstellen. Der Textinput ist direkt fokussiert. Das passiert nicht wenn man die Gitarre Editiert was in @editingGuitar näher erleutert wird.

=== Editing GuitarConfig <editingGuitar>

Screenshots von der App einfügen
//#image("assets/image.png")
das hatte zuviele buttons, buttons werden reduziert und usability verbessert, allerdings sind jetzt die schritte nicht mehr offensichtlich
== Architektur
mvc oder mvp oder mvvm,

Backend der App konzipieren. Pipeline Modelletc
== Implementierung

=== Auswahl des Cross-Platform-Frameworks

Da die App gemäß @req-nfa-ko-01 auf iOS und Android lauffähig sein muss,
wird ein Cross-Platform-Framework eingesetzt, um eine gemeinsame Codebasis
für beide Plattformen zu erhalten. Zur Auswahl standen React Native
@reactnative_dev, .NET MAUI @dotnet_maui und Flutter @flutter_dev.

==== Umsetzungsgeschwindigkeit komplexer Anforderungen

Flutter bietet mit seinem Widget-System und dem integrierten
Rendering-Stack eine durchgängige Abstraktionsebene, auf der sich
komplexe UI-Zustände -- wie die Echtzeit-Visualisierung der
Stimmgenauigkeit -- direkt und ohne Umwege über plattformspezifische
APIs umsetzen lassen. React Native erfordert bei komplexeren
Anforderungen häufiger den Rückgriff auf native Module oder externe
Bibliotheken, was den Entwicklungsaufwand erhöht. .NET MAUI zeigte in
eigenen Experimenten bei plattformübergreifenden UI-Komponenten
Inkonsistenzen, die zusätzlichen Abstimmungsaufwand erzeugten.

==== Einstiegshürde

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

==== Codestabilität

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

==== UI-Komponenten mit Material 3

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

==== Entscheidung

Aufgrund eigener praktischer Erfahrungen mit allen drei Frameworks sowie
der beschriebenen Eigenschaften wurde Flutter gewählt. Es bietet bessere
Performance als React Native, ein kohärenteres Entwicklungserlebnis als
.NET MAUI und ermöglicht eine plattformübergreifende Darstellung, die
auf jedem Gerät identisch aussieht. Nachteile von
Cross-Compiling-Ansätzen, die in @mobileAppEngineering (2017) beschrieben
werden, sind durch Flutters AOT-Kompilierung, eigenständiges Rendering
und die direkte Integration von Material 3 heute weitgehend überholt.
=== Abhängigkeiten

Die App verwendet folgende Laufzeit-Abhängigkeiten:

/ `flutter_riverpod` \^3.0.0: State-Management-Framework. Ermöglicht
  das Bereitstellen von gemeinsamem Zustand über mehrere Widgets hinweg
  und bildet die Grundlage für Model und Controller im gewählten
  Architekturmuster.

/ `riverpod_annotation` \^4.0.0: Annotationspaket für Riverpod;
  wird zur Code-Generierung benötigt.

/ `shared_preferences` \^2.3.3: Plattformübergreifende Persistenz
  einfacher Schlüssel-Wert-Paare. Wird verwendet, um Gitarrenprofile
  und Stimmungen dauerhaft auf dem Gerät zu speichern (@req-fsa-10,
  @req-fsa-13).

/ `json_annotation` \^4.9.0: Annotationspaket für JSON-Serialisierung;
  ermöglicht das Speichern komplexer Datenobjekte als JSON-String in
  `shared_preferences`.

/ `record` \^6.1.1: Plattformunabhängiger Zugriff auf das Gerätmikrofon
  für iOS und Android (@req-fsa-01).

/ `pitch_detector_dart` \^0.0.7: Implementierung des YIN-Algorithmus
  zur Grundfrequenzschätzung (@req-fsa-01).

/ `buffered_list_stream` \^1.3.0: Puffert den kontinuierlichen
  Audiodatenstrom des Mikrofons zu Blöcken, die der YIN-Algorithmus
  verarbeiten kann.

/ `ml_linalg` \^13.12.6: Optimierte Matrizenoperationen (Multiplikation,
  Inversion) für die Berechnung der Verstimmungsmatrix und der
  Zielfrequenzen (@req-fsa-07, @req-fsa-03).

/ `statistics` \^1.2.1: Hilfsfunktionen für Listenoperationen, die in
  der Signalverarbeitung und Plausibilitätsprüfung eingesetzt werden.

/ `async` \^2.13.0: Erweiterungen für asynchrone Programmierung und
  Parallelverarbeitung des Audiostreams.

/ `flutter_sound` \^9.30.0: Wiedergabe eines Referenztons zur
  auditiven Überprüfung der Stimmung.

/ `auto_route` \^11.1.0: Typsicheres Routing mit reduziertem
  Boilerplate-Code.

/ `url_launcher` \^6.3.2: Öffnet externe URLs; wird verwendet, um
  Hilfevideos auf YouTube zu verlinken (@req-fba-06, @req-nfa-be-04).

Folgende Abhängigkeiten werden ausschließlich zur Entwicklungszeit
benötigt und sind nicht Teil des ausgelieferten Artefakts:

/ `riverpod_generator` \^4.0.0+1: Generiert Riverpod-Provider aus
  Annotationen.

/ `riverpod_lint` \^3.0.0: Statische Analyse für korrekte
  Riverpod-Verwendung.

/ `json_serializable` \^6.11.1: Generiert JSON-Serialisierungscode
  aus `json_annotation`-Annotationen.

/ `auto_route_generator` \^10.2.4: Generiert Routing-Code aus
  `auto_route`-Annotationen.

/ `build_runner` \^2.7.1: Führt alle Code-Generatoren aus.

/ `flutter_lints` \^6.0.0: Offizielles Lint-Regelwerk für Flutter;
  stellt statische Codequalität sicher.

=== Quellcode

Die App wurde mit Git versioniert und ist öffentlich auf GitHub verfügbar:
#link("https://github.com/Raphael2b3/floyd_rose_tuner")

== Tests während der Entwicklung

=== Manuelle Tests

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

=== Unit-Tests

Für die mathematisch verifizierbaren Kernanforderungen wurden
automatisierte Unit-Tests implementiert:

- @req-fsa-03: Korrektheit der Zielfrequenzberechnung anhand bekannter
  Eingabe- und Ausgabewerte
- @req-fsa-07, @req-fsa-08: Schätzung der Verstimmungsmatrix mittels
  Deming-Regression, überprüft gegen synthetische Messdaten mit
  bekannter Steigung

=== Nicht getestet

Die folgenden Anforderungen wurden im Rahmen dieser Arbeit nicht
getestet und stellen offene Punkte für eine Weiterentwicklung dar:

- @req-nfa-la-01, @req-nfa-la-02: Latenzmessung erfordert eine
  instrumentierte Testumgebung zur präzisen Zeiterfassung
- @req-nfa-ro-01: Systematischer Test bei definiertem Umgebungspegel
  von $70 "dB(A)"$ war messtechnisch nicht umsetzbar
- @req-nfa-ko-01 bis @req-nfa-ko-03: Kompatibilitätstests auf
  verschiedenen Geräten und Betriebssystemversionen stehen aus

= Evaluation

== Funktionsfähigkeit des Algorithmus

Das zentrale Ziel der Arbeit -- eine Floyd-Rose-Gitarre mithilfe der
Applikation korrekt zu stimmen -- wurde erreicht. In den Nutzertests
(@nutzerTests) konnte die Gitarre unter geeigneten akustischen
Bedingungen erfolgreich gestimmt werden. Die Verstimmungsmatrix wurde
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
  [@req-fba-16], [Prezision der Kalibrierung erhöhen], [Teilweise],
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
  [@req-nfa-mg-01], [Grundfrequenz mit max. $±0.2 "Hz"$ Abweichung], [Nein],
  [@req-nfa-mg-02], [Obertöne nicht als Grundfrequenz ausgeben], [Teilweise],
  [@req-nfa-mg-03], [Bei unverstärktem Spiel max. $±0.1 "Hz"$ Abweichung], [Nein],

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
  [@req-nfa-ko-01], [Lauffähig auf iOS ≥ 16 und Android ≥ 10], [Nicht Überprüft],
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
== Nutzertests <nutzerTests>

=== Nutzer 0

Die App wurde in einem ruhigen Zimmer mit verstärkter Gitarre ohne
Verzerrungseffekt getestet. Die Frequenzen aller Saiten wurden korrekt
erkannt und die Gitarre konnte erfolgreich gestimmt werden. Es traten
vereinzelte Schwankungen bei der Erkennung der Fundamentalfrequenz auf,
die den Prozess geringfügig verlangsamten.

Die Bestimmung der Verstimmungsmatrix inklusive anschließender
Überprüfung der Messdaten dauerte 3:47 Minuten; der gesamte
Stimmvorgang war nach ca. 7 Minuten abgeschlossen.

=== Nutzer 1

Die App wurde auf einer Jam-Session vorgestellt. Beim Versuch, die
Frequenzen der E-Gitarre zu messen, wurde nicht die Fundamentalfrequenz,
sondern der erste Oberton (Faktor 2) erkannt. Als Ursache kommen zwei
Faktoren zusammen: die laute Umgebung sowie ein aktiver
Verzerrungseffekt, der den Obertonanteil des Signals verstärkte. Der
Stimmvorgang musste abgebrochen werden.

Dieser Test macht deutlich, dass die Fundamentalfrequenzerkennung unter
ungünstigen akustischen Bedingungen robuster gestaltet werden muss.

=== Nutzer 2

Die App wurde zu Hause unter guten akustischen Bedingungen verwendet.
Es fiel auf, dass der Kalibrierungsprozess zwar technisch korrekt
funktionierte, jedoch unnötige Wiederholungen enthielt: Nachdem der
Zustand der Gitarre nach dem Verstimmen einer Saite gemessen wurde,
könnte dieser Zustand direkt als Ausgangslage für die Messung der
nächsten Saite weiterverwendet werden. Aktuell wird dieser Schritt
manuell ausgelöst.

Darüber hinaus zeigte sich ein grundlegenderes Problem: Beim Stimmen
einer Saite mit Hilfe der App wurden zunächst die korrekten
Zielabweichungen $Delta f$ angezeigt. Sobald jedoch eine Saite aktiv
verstimmt wurde, veränderte sich -- erwartungsgemäß aufgrund der
Brückenkopplung -- der Zustand aller übrigen Saiten. Diese
Zustandsänderung wurde nicht in die nachfolgende Berechnung der
$Delta f$ einbezogen, sodass die Gitarre am Ende nicht präzise gestimmt
war. Als Konsequenz muss der Stimmvorgang die durch jede
Saitenänderung verursachten Folgeverstimmungen schrittweise
vorausberechnen und kompensieren.

=== Nutzer 3

Nutzer 3 war mit der Darstellung roher Frequenzwerte (in Hz) überfordert
und konnte deren Bedeutung nicht einordnen. Dies bestätigte den Bedarf
einer abstrahierten, intuitiv verständlichen Visualisierung der
Stimmgenauigkeit anstelle numerischer Frequenzangaben.

=== Nutzer 4

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
den größten Messfehler aufwiesen.

Der effektive Zeitaufwand für den Stimmvorgang betrug 8 Minuten.


= Ausblick

== Optimierung der Fundamentalfrequenzschätzung

Die Nutzertests (@nutzerTests) zeigten, dass der YIN-Algorithmus unter
zwei Bedingungen zur Erkennung von Obertönen statt der Fundamentalfrequenz
neigt: bei hohem Umgebungspegel (Nutzer 1) sowie bei Saiten mit ausgeprägtem
Obertonanteil wie tiefen Stahlsaiten (Nutzer 4). In beiden Fällen wurde
der erste Oberton -- also die doppelte Grundfrequenz -- als Schätzwert
ausgegeben.

Als Gegenmaßnahme wurde gemäß @req-fsa-12 eine Plausibilitätsprüfung
implementiert: Liegt der geschätzte Wert außerhalb des erwarteten
Frequenzbereichs der jeweiligen Saite, wird durch Halbierung auf die
Grundfrequenz rückgeschlossen. Diese Heuristik behebt den Oktavfehler in
den beobachteten Fällen, setzt jedoch voraus, dass der Fehler genau eine
Oktave beträgt. Für stärker verrauschte Signale oder höhere Obertöne
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

== Automatische Saiten­erkennung beim Stimmen

Wenn der Nutzer während des Stimmvorgangs eine Saite anspielt, könnte
die App anhand der gemessenen Frequenz automatisch erkennen, welche Saite
verändert wird, und die Anzeige entsprechend umschalten. Voraussetzung
ist, dass die Saite bereits näherungsweise auf der Zielfrequenz liegt,
sodass eine eindeutige Zuordnung möglich ist.

== Mehr Konfigurationsfreiraum

=== Änderbare Referenzstimmung

Aktuell ist die Referenzfrequenz fest auf $440 "Hz"$ eingestellt.
Manche Ensembles -- insbesondere im Orchesterkontext -- stimmen auf
abweichende Referenzwerte wie $438 "Hz"$ oder $442 "Hz"$. Eine
konfigurierbare Referenzfrequenz würde es ermöglichen, die Gitarre
präzise auf solche Ensembles abzustimmen.

=== Unterstützung beliebig vieler Saiten

Die aktuelle Implementierung setzt sechs Saiten voraus. Es gibt jedoch
Gitarren mit sieben, acht oder mehr Saiten sowie Bass­gitarren mit vier
oder fünf Saiten. Eine Verallgemeinerung der Verstimmungsmatrix $C$ auf
$n times n$ wäre konzeptuell straightforward und würde die Applikation
für eine deutlich breitere Instrumentenvielfalt nutzbar machen.

== Implementierung als DAW-Plugin

Eine Portierung der Kernlogik als VST3- oder CLAP-Plugin in C++ würde
den Einsatz in professionellen Studio-Umgebungen ermöglichen und damit
das in @req-fba-10 beschriebene Szenario von Persona Hanna adressieren.
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

/ Sattel: Ein fester Punkt am Gitarrenhals (vgl. @figBegriffe).
/ Brücke: Ein fester Punkt am Gitarrenkörper, an dem die Saiten befestigt sind (vlg. @figBegriffe).
/ Saite: Ein Dünner Draht, der zwischen Sattel und Brücke einer Gitarre gespannt ist und beim Anschlagen schwingt, um Töne zu erzeugen.
/ Tremolo: Eine spezielle Art von Gitarrenbrücke, die es ermöglicht, die Tonhöhe der Saiten durch Bewegung eines Hebels zu verändern.
/ Floyd-Rose: Erfinder des gleichnamigen Tremolosystems, das in vielen E-Gitarren verwendet wird.
/ Stimmen einer Gitarre: Der Prozess, bei dem die Spannung der Saiten angepasst wird, um die gewünschten Tonhöhen zu erreichen.
/ Stimmwirbel: ein drehbarer Stift aus Metall oder Holz an Saiteninstrumenten, um den das Ende einer Saite gewickelt wird.
/ E | A | D | G | B | hohe E - Saite: Die Namen der sechs Saiten einer Gitarre, von der tiefsten (E) bis zur höchsten (hohe E).

/ Bund: Ein Metallstift, der quer über den Gitarrenhals verläuft und die Saiten in Abschnitte unterteilt, um verschiedene Töne zu erzeugen, wenn die Saite auf den Bund gedrückt wird.

/ MAUI: Multi-platform App UI
/ Stimmung: Die Stimmung im Kontext von Gitarren bezeichnet die spezifische Tonhöhe, auf die die sechs Saiten des Instruments eingestellt sind. Sie legt fest, welche Töne erklingen, wenn die Saiten leer (ohne Greifen im Bund) angeschlagen werden.
/ Tuning: der englische Begriff für Stimmung
/ DAW: Digital Audio Workstation
/ VST: Virtual Studio Technology ist eine Programmierschnittstelle für Audio-Plug-ins. Damit können virtuelle Effekte programmiert werden.
/ CLAP: CLever Audio Plug-in
#figure(
  image("assets/gitarren_begriffe.png", height: 34%),
  caption: [Begriffe einer Gitarre],
)<figBegriffe>
#pagebreak()
#heading(depth: 1, "Abbildungsverzeichnis", numbering: none, outlined: false)
#outline(
  title: none,
  target: figure.where(kind: image),
)

#pagebreak()
#heading(depth: 1, "Tabellenverzeichnis", numbering: none, outlined: false)
#outline(
  title: none,
  target: figure.where(kind: table),
)
#pagebreak()

#bibliography("bib.bib")

