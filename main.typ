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

Nun soll die Variable $beta$ bestimmt werden, die sich aus dem Kräftegleichgewicht und der darausfolgenden Hebelposition ergibt. Nach den Gesetzen der Statik trägt ausschließlich der zur jeweiligen Hebelarmrichtung orthogonale Kraftanteil zum Drehmoment bei @hebel_wikipedia.
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

Die Linearität des Systems ist nicht perfekt, aber hinreichend gut für kleine Verstimmungen. Sie lässt sich quantitativ mit dem Korrelationskoeffizienten nach Bravais-Pearson @wiki_bravais_pearson zwischen gemessenen und erwarteten Frequenzänderungen jeder Saite bestimmen.
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

== Initierung -- Bestimmung der Verstimmungsmatrix
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
  @orthogonale_regression

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
@nyquist_shannon_wikipedia

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

Die Software soll nach dem Buch "Mobile App Engineering" @mobileAppEngineering entwickelt werden.

Das Buch beschäftigt sich mit der Entwicklung von _Enterprise Apps_. Die in diesem Rahmen entwickelte App ist zwar keine _Enterprise App_, aber die Prinzipien der Softwareentwicklung, die in diesem Buch beschrieben werden, sind dennoch anwendbar. Es werden insbesondere die Prinzipien der Anforderungsanalyse und der nutzerzentrierten Gestaltung übernommen.

Wie im Buch beschrieben, werden Mobile Applikationen in Iterativen Prozessen entwickelt. Daher werden manche Design entscheidungen mit Usertests begründet die mit einer Älteren Version der App durch geführt wurden.

== Requirements Enginnering
Im Rahmen der Anforderungsanalyse und der nutzerzentrierten Gestaltung der mobilen Tuning-App wurden drei repräsentative User Journeys erarbeitet. Diese beschreiben typische Nutzungsszenarien unterschiedlicher Nutzergruppen und dienen der Validierung der funktionalen sowie der interaktionsbezogenen Anforderungen. Die Journeys wurden auf Basis der erstellten Personas und der identifizierten Pain Points entwickelt und berücksichtigen sowohl Erstnutzung als auch wiederkehrende Nutzungsszenarien.
== User Journeys

=== Gerhard Gitarrist (Erstnutzer mit Floyd-Rose-Tremolo-Gitarre)
Gerhard Gitarrist besitzt eine Floyd-Rose-Tremolo-Gitarre und möchte diese präzise stimmen.
Er hat von der App erfahren und lädt sie aus dem App Store herunter.
Beim erstmaligen Start der App gelangt er auf eine Onboarding-Seite, die ihm bewusst macht, dass er mit der Funktionsweise der App noch nicht vertraut ist.

Auf dieser Startseite werden ihm zwei Hilfsangebote prominent angezeigt: ein Link zu einem kurzen Erklärvideo (ca. 90 Sekunden) sowie ein prägnanter, textbasierter Erklärtext.
Gerhard entscheidet sich jedoch gegen beide Hilfsmittel, da er sofort mit dem Stimmvorgang beginnen möchte.
Er klickt daher auf den prominent platzierten Button „Direkt zum Stimmgerät“, der ihn ohne weitere Verzögerung auf die Tuning-Seite führt.Die App informiert ihn nun klar und strukturiert darüber, dass zunächst eine einmalige Konfiguration des Stimmgeräts für seine Floyd-Rose-Gitarre notwendig ist.
Der Konfigurationsprozess beginnt automatisch:
Die App fordert Gerhard auf, nacheinander alle sechs Saiten einmal anzuspielen, um die aktuelle Grundstimmung und die Saitenreihenfolge zu erfassen.
Anschließend wird er aufgefordert, die tiefe E-Saite bewusst um einen definierten Betrag zu verstimmen (z. B. um eine Terz).
Sobald die gewünschte Verstimmung erreicht ist, erhält er ein positives visuelles und akustisches Feedback.
Danach muss er jede weitere Saite einmal einzeln anspielen. Spielt er versehentlich eine falsche Saite an, kann er über einen deutlich sichtbaren Button „Vorherige Saite“ zum vorherigen Schritt zurückkehren.

Der Vorgang wiederholt sich analog für alle Saiten.
Nach Abschluss der Kalibrierung erscheint ein Dialog, der Gerhard fragt, ob er diese Konfiguration speichern möchte, um den Prozess künftig zu überspringen. Neben einem Textfeld zur freien Benennung der Konfiguration (z. B. „Meine Floyd Rose – Standard“) stehen die beiden Buttons „Speichern“ und „Abbrechen“ zur Verfügung.Nach Bestätigung öffnet sich das eigentliche Stimmgerät.
Oben in der Kopfzeile wird die gerade ausgewählte Konfiguration angezeigt.
Gerhard wird nun aufgefordert, jede Saite einzeln auf die exakte Zieltonhöhe (in Hz) zu stimmen.
Sobald alle Saiten korrekt gestimmt sind, erhält er eine abschließende Bestätigung „Gitarre erfolgreich gestimmt“ und kann die App beenden.
=== Arnold Abbrecher (Wiederholungsnutzer mit Abbruchwunsch)
Arnold Abbrecher ist bereits Nutzer der App und besitzt ebenfalls eine Floyd-Rose-Tremolo-Gitarre. Beim Start der App gelangt er direkt in das Stimmgerät, das automatisch die zuletzt verwendete Konfiguration lädt.
Bevor er mit dem eigentlichen Stimmen beginnt, bemerkt er einen Hinweis-Text, der ihn darauf aufmerksam macht, dass bei neuen Saiten oder bei einer anderen Gitarre eine erneute Konfiguration des Stimmgeräts erforderlich ist.
Arnold entscheidet sich dafür, eine neue Konfiguration anzulegen, und klickt auf den Button „Neue Konfiguration erstellen“.Der Konfigurationsprozess startet wie bei Gerhard Gitarrist. Nach einigen Schritten wird Arnold jedoch durch äußere Einflüsse (z. B. ein Telefonat oder Zeitmangel) unterbrochen.
Er möchte den Vorgang an dieser Stelle abbrechen und klickt auf den jederzeit sichtbaren und gut erreichbaren Button „Konfiguration abbrechen“.
Die App fragt sicherheitshalber noch einmal nach einer Bestätigung („Möchten Sie den Konfigurationsprozess wirklich abbrechen? Die bisherigen Daten gehen verloren.“).
Nach Bestätigung wird Arnold zurück zur Startseite des Stimmgeräts geleitet; die bisherigen Konfigurationsdaten werden verworfen und die zuletzt gespeicherte Konfiguration bleibt erhalten.
=== Norman Normaler (Nutzer einer Standard-Gitarre ohne Tremolo)
Norman Normaler ist Gitarrist mit einer herkömmlichen E-Gitarre ohne Floyd-Rose-Tremolo-System.
Er besitzt die App bereits und startet sie.
Wie bei Arnold öffnet sich direkt das Stimmgerät mit der zuletzt verwendeten Konfiguration.Da Norman keine Floyd-Rose-Gitarre stimmen möchte, sondern lediglich eine schnelle Standardstimmung benötigt, navigiert er über die untere Navigationsleiste zum Menüpunkt „Standard Tuner“. Die App wechselt nahtlos in den vereinfachten Stimmmodus, der auf die klassische chromatische Stimmfunktion ohne spezielle Floyd-Rose-Kalibrierung zurückgreift.Norman spielt nun nacheinander die Saiten an und stimmt sie manuell auf die Standardtonhöhen (E-A-D-G-H-e).
Die App zeigt dabei in Echtzeit die aktuelle Frequenz sowie eine visuelle Hilfestellung (Zeiger bzw. Farbverlauf). Sobald alle Saiten korrekt gestimmt sind, erhält er eine Erfolgsmeldung. Norman kann die App anschließend direkt schließen, ohne weitere Konfigurationsschritte durchlaufen zu müssen.

== Anforderungen
Aus User Journeys ableiten
== Konzeption und Design
Screenshots von der App einfügen
//#image("assets/image.png")
das hatte zuviele buttons, buttons werden reduziert und usability verbessert, allerdings sind jetzt die schritte nicht mehr offensichtlich
== Architektur
Backend der App konzipieren. Pipeline Modelletc
== Implementierung
Auswahl von Frameworks und Libraries:
- Flutter
- Riverpod
- etc..
Verlinkung des Git-Repositories
= Floyd-Rose-Tuner App
Im folgendem wird die App, wie sie zum Zeitpunkt der Abgabe der Bachelorarbeit war, vorgestellt.

== First Load

#figure(image("assets/image-2.png", height: 40%), caption: [Landing Page])<appLanding>
Wenn man die App startet, sieht man als erstes die Möglichkeit das _Tuning_ einzustellen, die bereits auf die standartmäßige Stimmung _E-A-D-G-H-e_ eingestellt ist (Siehe @appLanding).
#figure(image("assets/image-3.png", height: 40%), caption: [Selecting Tuning Page])<appSelectTuning>
Versucht man ein anderes _Tuning_ auszuwählen, sieht man wie in @appSelectTuning eine größere Auswahl von herkömmlichen Stimmungen.

Da die App noch keine Gitarre erlernt hat, wird in der Auswahl die Aufforderung angezeigt, eine Gitarre auszuwählen (@appLanding). Zu beginn der das Dropdown Menu enthält zunächst keine Gitarre. Allerdings kann, der Nutzer auf den Button "Add A New Guitar" klicken und kommt nun zur _Detuning Matrix Measure Page_.

== Detuning Matrix Measure Page
Auf dieser Saite, nimmt man die Messdaten auf um die Verstimmungsmatrix zu bestimmen.


#figure(image("assets/image-4.png", height: 40%), caption: [Measure Detuning Matrix Page])<appDetuningMatrixPage>

Diese Seite ist die Komplizierteste. Ganz oben ist ein Zufällig generierter Name für die Gitarre. Beim öffnen der Saite kann man direkt den Namen der Gitarre einstellen. Der Textinput ist direkt fokussiert. Das passiert nicht wenn man die Gitarre Editiert was in @editingGuitar näher erleutert wird.

== Editing GuitarConfig <editingGuitar>
= Evaluation

== Funktionsfähigkeit des Algorithmuses
Mit der App konnte die Gitarre erfolgreich  gestimmt werden.
== Erfüllung der Requirements aus SWE
== Nutzertests
=== Nutzer 0
Die App wurde in einem ruhigen Zimmer, mit verstärkter Gitarre ohne Verzerrungseffekt getestet. Hierbei wurden die Frequenzen der Saiten korrekt erkannt und die Gitarre konnte erfolgreich gestimmt werden. Es gab kleine Schwierigkeiten bei dem Erkennen der Fundamental frequenz. Da diese etwas schwankten.
Dabei dauerte der Prozess um die Matrix zu bestimmen und die Messdaten nocheinmal zu überprüfen 3:47 Minuten.
Innerhalb von ungefähr 7 Minuten war die Gitarre gestimmt.

=== Nutzer 1
Hierbei wurde die App auf einer Jam Session vorgestellt. Beim Versuch, die Frequenz der E-Gitarre zu messen, wurde nicht die korrekte Fundamentalfrequenz erkannt, sondern der Oberton mit Faktor 2. Gerade weil es in der Umgebung laut war und die Gitarre einen Verzerrungseffekt hatte, bei dem Obertöne verstärkt wurden.
Der Stimmvorgang wurde abgebrochen.

Für so ein Szenario muss die Erkennung der Fundamentalfrequenz stabiler sein.

=== Nutzer 2
Die App wurde Zuhause unter guten Bedingungen verwendet.
Es viel auf, dass das Erlernen der Verstimmungmatrix zwar technisch funktionierte, aber im protzess einige repetitive Aktionen getätigt werden mussten. Denn wenn man den Zustand der gitarre gemessan hatte nach dem eine Saite verstimmt wurde, könnte man diesen Zustand auch schon als ausgangslage der nächsten Saite speichern. Aktuell wird das noch manuell gemacht.


Es hat sich gezeigt, dass die Gitarre doch nicht prezise gestimmt wird. Denn beim verstimmen der Gitarre, wurden zwar zunächst die korrekten $Delta f$ angezeigt. Doch wenn man eine Saite mit hilfe der App verstimmt, verändert sich der gemessene Zustand der aktuell ausgewählten Saite und auch aller anderen. Diese änderung wurden nicht mit eineberechnet in der Folgenden berechnung der $Delta f$.

Deswegen muss schritt weise die änderung vorhergesehen werden im Stimmprozess.

=== Nutzer 3

Nutzer 3 war verwirrt, was die Zahlen bedeutet (Frequenzen). Das verstärkte den Bedarf einer Erklärung.

=== Nutzer 4
13:50 - Nutzer fängt an, und will direkt die gitarre Stimmen. Die App konnte nicht klar kommunizieren, dass zu erst die Saiten der Gitarre gemessen werden mussten, mehr mals um die Verstimmungsmatrix zu bestimmen. Als dass im Tutorial Video erklärt wurde. War nicht klar, als die Saite zum testen verstimmt werden sollte, wohin die Gitarre verstimmt werden sollte. Auch wenn es egal ist wohin, hat das unsicherheiten ausgelöst. Als das erklärt wurde, hatte die App Schwierigkeiten, die tiefen Saiten korrekt zu messen. Da die Stahlsaiten starke obertöne aufwies. Durch umpositionierung des Handys näher am Lautsprecher, und durch betätigung des _Tone Nobs_ der die Funktion eines Analogen Lowpass Filter erfüllt. Ging es dann. Zum Schluss wurde die Gitarre gestimmt. wobei Allerding die E Saite zu Hoch war, was darauf hindeutet, dass die Der Einfluss auf die E-Saite die meisten Messfehler aufwies.

Das Stimmen dauerte effektiv 8 Minuten.
= Ausblick
== Usability Verbessern
Die App nutzt noch zu komplizierte Begriffe für die Nutzer.
== Indikator was noch nicht überprüft wurde
Ein Indikator könnte sein, dass die App anzeigt, welche Saiten bereits überprüft wurden.
== Mehrere Saiten gleichzeitig Messen
Fourier Transformation, 6 Peaks erkennen und die obertöne rausrechnen.
== Implementierung für VST und Digital Audio Workstations (Plugin)
VST und CLAP Plugin implementieren, in C++
== Synthetischen Ton zur Kontrolle abspielen um zu hören ob die korrekte Frequenz erfasst wurde.
== Erkennen welche Saite gespielt wird, annahme 6 Saiten
Wenn der Nutzer die Gitarre stimmt, dann wollen wir erkennen welche Saite er verändert und automatisch switchen. Annahme ist, dass er bereits ungefähr an der richtigen Frequenz ist.
== Mehr Konfigurationsfreiraum
=== Mehr Samples zur bestimmung der Steigungen verwendeten
Dieses Feature ist tatsächlich schon implementiert. Allerdings wurde es deaktiviert, um die Benutzeroberfläche einfacher zu gestalten. Weniger Ablenkung, da weniger Knöpfe.

=== Referenzstimmung 440 Hz ändern
Zukünftig könnte es sinnvoll sein, die Referenzstimmung von 440 Hz ändern zu können. Manchmal gibt es Instrumente die um zum Referenzton A mit 438 Hz gestimmt sind. So könnte man die Gitarre auch auf diese Instrumente stimmen.

=== Erstellen eigener Stimmungen
Außerdem kann man bisher keine eigenen Tunings definieren. Es wäre flexibeler wenn der Nutzer selbst bestimmen könnte, auf welche Frequenzen er Seine Gitarre Stimmen möchte.

=== Support von Gitarren mit beliebig vielen Saiten
Desweiteren gibt es in sehr Seltenen Fällen Gitarren die nicht 6 Saiten haben, sondern mehr oder weniger. Für diesen Fall wäre gut wenn, man auch solche Gitarren stimmen kann. Momentan wird angenommen, dass es nur 6 Saiten gibt.


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

