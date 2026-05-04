// The project function defines how your document looks.
// It takes your content and some metadata and formats it.
// Go ahead and customize it to your liking!
#set math.equation(numbering: "(1)")
#set heading(numbering: "1.1")
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
= Glossar

/ Sattel: Ein fester Punkt am Gitarrenhals (vlg. @figBegriffe).
/ Brücke: Ein fester Punkt am Gitarrenkörper, an dem die Saiten befestigt sind (vlg. @figBegriffe).
/ Saite: Ein Dünner Draht, der zwischen Sattel und Brücke einer Gitarre gespannt ist und beim Anschlagen schwingt, um Töne zu erzeugen.
/ Tremolo: Eine spezielle Art von Gitarrenbrücke, die es ermöglicht, die Tonhöhe der Saiten durch Bewegung eines Hebels zu verändern.
/ Floyd-Rose: Erfinder des gleichnamigen Tremolosystems, das in vielen E-Gitarren verwendet wird.
/ Stimmen einer Gitarre: Der Prozess, bei dem die Spannung der Saiten angepasst wird, um die gewünschten Tonhöhen zu erreichen.
/ Stimmwirbel: ein drehbarer Stift aus Metall oder Holz an Saiteninstrumenten, um den das Ende einer Saite gewickelt wird.
/ E | A | D | G | B | hohe E - Saite: Die Namen der sechs Saiten einer Gitarre, von der tiefsten (E) bis zur höchsten (hohe E).

/ Bund: Ein Metallstift, der quer über den Gitarrenhals verläuft und die Saiten in Abschnitte unterteilt, um verschiedene Töne zu erzeugen, wenn die Saite auf den Bund gedrückt wird.
#figure(
  image("assets/gitarren_begriffe.png", height: 34%),
  caption: [Begriffe einer Gitarre],
)<figBegriffe>

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

#pagebreak()
== Experiment: Elastizität von Gitarrensaiten

Dieses Experiment stammt aus meiner Arbeit für das Modul "Projekt 3" aus dem Telekommunikationsinformatik-Studium an der HTWK-Leipzig @Schuetz2026FloydRose. Es wird hier erneut präsentiert, um die elastischen Eigenschaften von Gitarrensaiten zu demonstrieren.

In diesem Experiment
wird untersucht, ob Stahlsaiten elastische Eigenschaften besitzen, vergleichbar mit einem sehr steifen Gummiband. Beim Stimmen der Saite, die im Wesentlichen aus Stahldraht besteht, wird diese um den Stimmwirbel aufgewickelt.

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


== Physikalisches Modell
Im Folgenden wird ein physikalisches Modell der Gitarre beschrieben, um zu verstehen warum die Floyd-Rose-Gitarre so schwierig zu stimmen ist.

Die Gitarre wird als Abbildung modelliert, die 6 Aufwickelstrecken $arrow(Delta L) = vec(Delta L_1, dots.v, Delta L_i, dots.v, Delta L_6)$ auf einen Frequenzvektor $arrow(f) = vec(f_1, dots.v, f_i, dots.v, f_6)$ abbildet
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


=== Fazit
Es wird ersichtlich, dass die Aufwickelstrecken der Saiten die Frequenzen aller Saiten beeinflussen. Das erklärt, warum das Stimmen einer Floyd-Rose-Gitarre so schwierig ist.

Beim Stimmen werden die Aufwickelstrecken nur in kleinen Schritten verändert. In diesem Fall verhält sich das System näherungsweise linear. Da das System physikalisch ist, können wir das System als stetig betrachten.

== Experiment: Nachweis Linearität
Das Experiment stammt ebenfalls aus meiner Arbeit für das Modul "Projekt 3" aus dem Telekommunikationsinformatik-Studium an der HTWK-Leipzig @Schuetz2026FloydRose. Der Vollständigkeit halber werden die Ergebnisse hier erneut präsentiert.

Diese Linearität soll nun experimentell überprüft werden. Hierbei werden die Frequenzänderungen der Saiten gemessen, wenn eine andere Saite verstimmt wird.

=== Vorgehensweise
Zunächst wird jede Saite in eine Ausgangsposition gebracht. Die Ausgangsfrequenzen der Saiten werden zunächst in Hertz gemessen.
Anschließend wird jeweils eine Saite um ein beliebiges $Delta$ (in Hertz) verstimmt. Dieses $Delta$ wird so gewählt, dass die Verstimmung deutlich hörbar ist. Jede Saite wird in vier Schritten nach oben und unten verstimmt. Für jeden Schritt wird die Frequenz aller anderen Saiten gemessen.

Die Messdaten wurden aus @Schuetz2026FloydRose  Experiment stammt ursprünglich aus meiner Arbeit für das Modul "Projekt 3" aus dem Telekommunikationsinformatik-Studium an der HTWK-Leipzig @Schuetz2026FloydRose. Es werden die selben Messdaten verwendet. Allerdings wurde

Die Namen der Saiten sind wie folgt definiert:
1. E2 = E-Saite
2. A2 = A-Saite
3. D3 = D-Saite
4. G3 = G-Saite
5. B3 = B-Saite
6. E4 = hohe E-Saite

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
  caption: [Pearson-Korrelationskoeffizienten zwischen gemessenen und erwarteten Frequenzänderungen],
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
  caption: [Verstimmungsmatrix Beispiel C],
) <distortionMatrix>
Der Vektor

$
  arrow(Delta) = vec(Delta_"E2", Delta_"A2", Delta_"D3", Delta_"G3", Delta_"B3", Delta_"E4")
$

gibt an, um wie viel jede Saite verstimmt werden muss.

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
= Verfahrensweise

== Ablauf eines Stimmvorgangs
Um nun eine Gitarre zu stimmen, muss zunächst die Verstimmungsmatrix, der zu stimmenden Gitarre ermittelt werden. Dazu muss zunächst die Ausgangslage der Gitarre bestimmt werden. Dann wird die 1. Saite verstimmt und der Einfluss dieser Saite auf die anderen 5. Saiten gemessen. Dann werden die nächsten Saiten nach diesem Schema verstimmt und gemessen. Anhand dieser Änderungen wird die Verstimmungsmatrix berechnet. Anschließend wird der Zustand der Gitarre ermittelt und es wird für jede Saite eine Delta-Frequenz berechnet, um die die Saiten verstimmt werden müssen. Der Nutzer muss dann jede Saite verstimmen, sodass die Delta Frequenz 0 ist.

Um das umzusetzen benötigt man ein Verfahren um die Frequenz der Angespielten Saite zu ermitteln.

== Wahl des Verfahrens für die Frequenzanalyse

Für die Implementierung eines Tuners auf mobilen Geräten ist die präzise und effiziente Bestimmung der Grundfrequenz (Fundamental Frequency, F0) entscheidend. Im Folgenden werden gängige Verfahren vorgestellt und hinsichtlich Genauigkeit, Rechenaufwand und Anwendungsbereich bewertet.


=== Autokorrelation
Die Idee der Autokorrelation besteht darin, dass ein Signal mit einer Periode von $tau$, wenn es mit sich selbst gefaltet wird, bei vielfachen von $tau$ Maxima aufweisen wird. Wenn man nun den ersten von null verschiedenen x Wert wählt, der bei einem Hochpunkt ist, hat man mit hoher Wahrscheinlichkeit, das Richtige $Tau$ und mit seinem Inversen die Frequenz des Signals.

$
  r_t(tau) = sum_(j=t+1)^(t+W) x_j x_(j+tau)
$

wobei $r_t(tau)$ die Autokorrelationsfunktion von der Verzögerung $tau$ berechnet zum Zeitindex $t$ und $W$ ist die Integrationsfenstergröße.@YIN

=== YIN-Algorithmus

Der YIN-Algorithmus ist eine Weiterentwicklung der Autokorrelation. Sie fügt extra Fehlerreduktionsschritte hinzu. So wird zum Beispiel durch die "Difference function" eine Immunität gegenüber schwankenden Amplituden erzeugt und uninteressante $tau$ werden herausgefiltert.@YIN Der Algorithmus wird in vielen Stimmgeräten verwendet.

=== Fourier- und Cepstrum-Analyse

Bei der Fourier-Analyse wird das Signal ins Frequenzspektrum transformiert, um das Spektrum nach der Grundfrequenz zu durchsuchen. Die Cepstrum-Analyse erweitert diesen Ansatz, indem das logarithmierte Spektrum erneut transformiert wird, um periodische Muster zu detektieren. Eine Analyse hat gezeigt, dass jedoch Fourier-Analysen fehleranfällig sind und eine hohe Sampling-Rate benötigen. @FFT_NEEDS_HIGH_SAMPLING
Ein Vorteil von Cepstrum ist die Robustheit gegenüber harmonischen Obertönen und eine gute Integration in digitale Signalverarbeitungssysteme.
Ein Nachteil ist die eingeschränkte Genauigkeit bei niedrigen Frequenzen oder verrauschten Signalen, da die Cepstrum-Analyse auf der Annahme basiert, dass das Signal periodisch ist und dass die Obertöne harmonisch sind. In realen Situationen können diese Annahmen jedoch nicht immer erfüllt sein, was zu Fehlern bei der Schätzung der Grundfrequenz führen kann. @Noll1967Cepstrum

=== Moderne Deep-Learning-Ansätze

Neuronale Netze wie CREPE oder DeepPitch nutzen Convolutional- oder Recurrent Neural Networks, um direkt aus Roh-Audio oder Spektrogrammen die Fundamental-Frequenz vorherzusagen.

Vorteile sind die hohe Robustheit bei Polyphonie, Hintergrundgeräuschen und unterschiedlichen Instrumenten.

Nachteile sind der hohe Rechenaufwand, die Notwendigkeit großer Trainingsdatensätze und die Ressourcenintensität auf Mobilgeräten. @Kim2019CREPE

=== Auswahl des Verfahrens
Für die Implementierung wird der YIN-Algorithmus gewählt, da er eine gute Balance zwischen Genauigkeit und Rechenaufwand bietet. Er ist speziell für die Schätzung der Grundfrequenz entwickelt worden und bietet eine robuste Leistung bei verschiedenen Signalbedingungen. Hinzu kommt, dass er bereits in vielen Stimmgeräten erfolgreich eingesetzt wird und bereits Implementierungen in verschiedenen Programmiersprachen verfügbar sind.

== Filter
TODO
1. Filterung durch die Anpassung der Parameter in Frequenzanalyse
2. Signale werden gestreamt, und müssen ausgelesen werden, deswegen wird ein moving average Filter implementiert umd die Frequenzschwankungen zu glätten und das ablesen zu erleichtern.

== Auswahl des Verfahrens zur Schätzung der Verstimmungskoeffizienten

Kleinste Quadrate (OLS): Minimiert die Summe der quadrierten vertikalen Abstände in
$Y$-Richtung zwischen den Datenpunkten und der Regressionsgeraden. Sie wird verwendet,
wenn nur die Antwortvariable $Y$
fehlerbehaftet ist und die Prädiktorvariable $X$ als exakt betrachtet wird.

Orthogonale Regression (Deming-Regression): Minimiert die Summe der quadrierten
senkrechten (orthogonalen) Abstände der Punkte von der Geraden. Sie wird angewendet,
wenn sowohl die Antwortvariable $Y$ als auch die Prädiktorvariable $X$ Messfehler enthalten. @orthogonale_regression


Da auch die $X$ Werte fehler in der Messung enthalten, wird die Orthogonale Regression verwendet.
= Software Entwicklung/Implementierung

Die Software soll nach dem Buch "Mobile App Engineering" @mobileAppEngineering entwickelt werden.

Das Buch beschäftigt sich mit der Entwicklung von _Enterprise Apps_. Die in diesem Rahmen entwickelte App ist zwar keine _Enterprise App_, aber die Prinzipien der Softwareentwicklung, die in diesem Buch beschrieben werden, sind dennoch anwendbar. Es werden insbesondere die Prinzipien der Anforderungsanalyse und der nutzerzentrierten Gestaltung.

Damit die App frühzeitig auf sovielen Geräten wie möglich verwendet werden kann, wird die App mit einem Cross-Plattform-Framework entwickelt. Es gibt verschiedene Frameworks, die für die Entwicklung von Cross-Plattform-Apps verwendet werden können, wie zum Beispiel React Native, Dot Net Maui (ehemals Xamarin) und Flutter.

Aufgrund von eigener Erfahrungen mit React Native, Dot Net Maui (ehermals Xamarin) und Flutter wurde Flutter ausgewählt.
Flutter bot eine bessere Performance als React Native, und das Designen von Benutzeroberflächen war mit Flutter einfacher als mit Dot Net Maui. Die Developer Experience ist bei Flutter besonders gut.

== Anforderungen
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
#image("assets/image.png")
das hatte zuviele buttons, buttons werden reduziert und usability verbessert, allerdings sind jetzt die schritte nicht mehr offensichtlich
== Architektur
Backend der App konzipieren. Pipeline Modelletc
== Implementierung
Auswahl von Frameworks und Libraries:
- Flutter
- Riverpod
- etc..
Verlinkung des Gitrepositories
= Evaluation

== Funktionsfähigkeit des Algorithmuses
Mit der App konnte die Gitarre erfolgreich  gestimmt werden.
== Erfüllung der Requirements aus SWE
== Nutzertests
=== Nutzer 0
Die App wurde in einem ruhigen Zimmer, mit verstärkter Gitarre ohne Verzerrungseffekt getestet. Hierbei wurden die Frequenzen der Saiten korrekt erkannt und die Gitarre konnte erfolgreich gestimmt werden. Es gab kleine Schwierigkeiten bei dem Erkennen der Fundamental frequenz. Da diese etwas schwankten.

Innerhalb von ungefähr 7 Minuten war die Gitarre gestimmt.

=== Nutzer 1
Hierbei wurde die App auf einer Jam Session vorgestellt. Beim Versuch, die Frequenz der E Gitarre zu messen, wurde nicht die korrekte Fundamentalfrequenz erkannt, sondern der Oberton mit Faktor 2. Gerade weil es in der Umgebung laut war und die Gitarre einen Verzerrungseffekt hatte, bei dem Obertöne verstärkt werden.
Der Stimmvorgang wurde abgebrochen.

Für so ein Szenario muss die Erkennung der Fundamentalfrequenz stabiler sein.


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

= Literatur
Buch- Mobile App Engineering


#bibliography("bib.bib")
