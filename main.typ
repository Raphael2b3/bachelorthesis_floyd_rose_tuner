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
  logos: ("assets/htwk-logo.png")
,
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
  "String" : "String",
)

= Motivation

Es gibt ein Problem beim Stimmen von Floyd-Rose-Gitarren. Bei diesen Gitarren wird eine Saite zwischen dem Gitarrenkopf und einer bis zu einem gewissen Grad rotierbaren Brücke gespannt. An der Brücke halten unterhalb des Drehpunkts Federn dagegen, wenn man Saiten einspannt. Die Brücke wird gemeinhin als "Floating Bridge" bezeichnet, weil sie nicht wie herkömmliche Tremolos am Gitarrenkörper aufliegt sondern in der Luft schwebt. 

 #figure(image("assets/floydrose_frontside_neutral.jpg", height: 20%), caption: [Floyd-Rose-Tremolo Bild])<FRQuer>

Das Floyd-Rose-Tremolo hat einen Hebel, den man ziehen oder drücken kann. Beim Musizieren ändert das den Ton. Auch wenn diese Architektur neue Klänge ermöglicht, erschwert sie das Stimmen der Gitarre erheblich. Beim Stimmen erhöht oder verringert man die Spannung einer Saite, indem man deren Länge verändert. Demnach erhöht oder verringert sich die Auslenkung der Federn, da zum Beispiel bei geringerer Spannung der Saiten auch eine geringere Kraft auf die Federn wirkt. Das Resultat davon ist, dass sich der Winkel des Floyd-Rose-Tremolos verändert. Das führt dazu, dass die anderen Saiten verstimmt werden, wenn man eine Saite stimmt. Es gibt Erfahrungsberichte und Aufzeichnungen, wie man so eine Gitarre effizient stimmen kann. Dabei dauerte das Stimmen 8 Minuten @youtube_floyd_rose_tune2026. In Foren sprachen Nutzer von einer Stimmzeit von bis zu 20-30 Minuten, jenachdem wie Sauber und wieviele Saiten sie Stimmen mussten @ultimateguitar_floydrose_tuning_forum. Ziel der Arbeit ist eine App zu entwickeln, die diesen Stimmvorgang beschleunigt.

= Grundlagen (Physik der Gitarre)

== Physikalisches Model

Die Brücke einer Gitarre kann bei einem Floyd-Rose-Tremolo bis zu einem gewissen Grad rotieren. Ein entsprechendes vereinfachtes Model ist in der folgenden Abbildung dargestellt.

#figure(
  image("assets/FloydRoseQuer.png",height: 34%),
  caption: [Floyd-Rose-Model Quer],
  alt: "Test"
)<FRMQuer>
#figure(
  image("assets/FlyodRoseTop.png",height: 40%),
  caption: [Floyd-Rose-Model Draufsicht],
  alt: "Test"
)<FRMTop>
#figure(
  image("assets/FRrealTop.png",height: 40%),
  caption: [Floyd-Rose Draufsicht],
  alt: "Test"
)<FRTop>
=== Experiment: Sind Stahlsaiten elastisch?

In diesem Experiment wird untersucht, ob Stahlsaiten elastische Eigenschaften besitzen, vergleichbar mit einem sehr steifen Gummiband. Beim Stimmen der Saite, die im Wesentlichen aus Stahldraht besteht, wird diese um den Stimmwirbel aufgewickelt, wodurch ihre Zugspannung erhöht wird.

Plausibel wäre, dass sich Stahlsaiten dehnen können. Würde sich die Saite nicht dehnen, müsste sich stattdessen entweder die Brücke verschieben oder der Gitarrenhals elastisch verformen. In beiden Fällen wären die Bünde potenziell nicht mehr an ihrer vorgesehenen relativen Position, was zu Intonationsproblemen führen würde. 
Außerdem würden die übrigen Saiten einen Großteil ihrer Spannung verlieren.  
Aus der praktischen Erfahrung ist jedoch bekannt, dass herkömmliche Gitarren diese Probleme nicht aufweisen.

Verhält sich jedoch jede Saite näherungsweise wie eine Feder, lässt sich erklären, wie sich die Gesamtspannung auf mehrere Saiten verteilt und weshalb einzelne Saiten unterschiedliche Spannungen aufweisen können.


==== Materialien

- Gitarre mit starrer Brücke (keine Floyd-Rose-Brücke, z. B. Yamaha Pacifica)
- Tesafilm (zur Markierung der Saiten)

==== Durchführung

Zunächst wurde die hohe E-Saite etwas tiefer gestimmt, sodass sie ungefähr die Frequenz der darunterliegenden H-Saite aufwies. Dabei wurde darauf geachtet, dass die Saite weiterhin eine ausreichende Grundspannung besaß.

Anschließend wurden kleine Markierungen (Tesafilm) auf die hohe E-Saite geklebt. Die Markierungen wurden so positioniert, dass ihre Kante jeweils exakt mittig über einem Bund lag. Insgesamt wurden sechs Markierungen in unterschiedlichen Abständen zwischen Sattel und Brücke angebracht.

Zusätzlich wurde auf den übrigen Saiten jeweils eine Kontrollmarkierung auf denselben Bund angebracht. Dies diente als Referenz, um mögliche Verschiebungen infolge des Stimmvorgangs beurteilen zu können. Die Bundstäbe fungierten dabei als feste Referenzpositionen.

Im nächsten Schritt wurde die Spannung der hohen E-Saite erhöht, bis die dem Sattel nächstgelegene Markierung einen deutlich sichtbaren Abstand zum darunterliegenden Bund aufwies. Anschließend wurde untersucht, wie stark sich die übrigen Markierungen relativ zu ihren jeweiligen Referenzbünden verschoben hatten.

In der folgenden Tabelle sind Bilder, die Verschiebungen der Markierungen zeigen.
#{
  
let fret-row(bund, img_pac, cap_pac, img_pac_t, cap_pac_t) = (
  [#bund],
  figure(image(img_pac, width: 8.5em), caption: [#cap_pac]),
  figure(image(img_pac_t, width: 8.5em), caption: [#cap_pac_t])
)

  set text(size: 8.5pt)


table(
  columns: (auto, 1fr, 1fr),
  inset: 6pt,  
  stroke: 0.5pt,

  table.header(
    [*Bund*],
    [*Pacifica – Ruhe*],
    [*Pacifica – Spannung*]
  ),

  ..fret-row(1, "assets/p_1.jpeg", "Bund 1 – Ruhe", "assets/p_1t.jpeg", "Bund 1 – Spannung"),

  ..fret-row(2, "assets/p_2.jpeg", "Bund 2 – Ruhe", "assets/p_2t.jpeg", "Bund 2 – Spannung"),

  ..fret-row(4, "assets/p_4.jpeg", "Bund 4 – Ruhe", "assets/p_4t.jpeg", "Bund 4 – Spannung"),

  ..fret-row(6, "assets/p_6.jpeg", "Bund 6 – Ruhe", "assets/p_6t.jpeg", "Bund 6 – Spannung"),

  ..fret-row(8, "assets/p_8.jpeg", "Bund 8 – Ruhe", "assets/p_8t.jpeg", "Bund 8 – Spannung"),

  ..fret-row(12, "assets/p_12.jpeg", "Bund 12 – Ruhe", "assets/p_12t.jpeg", "Bund 12 – Spannung"),

  ..fret-row(16, "assets/p_16.jpeg", "Bund 16 – Ruhe", "assets/p_16t.jpeg", "Bund 16 – Spannung"),

  ..fret-row(22, "assets/p_22.jpeg", "Bund 22 – Ruhe", "assets/p_22t.jpeg", "Bund 22 – Spannung"),
)
}
==== Beobachtung

Die Markierungen, die sich näher am Sattel befanden, legten eine deutlich größere Strecke zurück als jene in unmittelbarer Nähe der Brücke. Die beobachtete Verschiebung nahm kontinuierlich vom Sattel in Richtung Brücke ab.

Die Kontrollmarkierungen auf den übrigen Saiten zeigten dagegen keine oder lediglich eine kaum wahrnehmbare Bewegung. Dies spricht dafür, dass die beobachtete Verschiebung nicht durch ein Verformen des Instruments verursacht wurde, sondern auf eine tatsächliche Längenänderung der gespannten Saite zurückzuführen ist. Als die Saite wieder entspannt wurde, waren die Markierungen wieder an ihrer Ausgangsposition. Die Schwingungsfrequenz der Saite war auch wieder dieselbe wie zu Beginn.

==== Fazit

Die Beobachtungen belegen das elastische Verhalten von Gitarrensaiten.  
Wird die Spannung durch Aufwickeln am Stimmwirbel erhöht, verschieben sich die aufgeklebten Markierungen entlang der Saite in unterschiedlichem Ausmaß. Markierungen in der Nähe der Brücke, die als nahezu fixer Punkt wirkt, erfahren nur eine sehr geringe Verschiebung, während weiter entfernte Markierungen deutlich stärker wandern. Elastisch bedeutet, dass die Saite eigenständig wieder ihre Ursprungsform annimmt.

Die Saite verhält sich dabei wie eine elastische Feder. Je näher ein Punkt an der fixierten Brücke liegt, desto geringer ist seine Bewegung.  
Dies bestätigt, dass sich die Dehnung der Saite über ihre gesamte Länge verteilt, während der Fixpunkt an der Brücke nahezu ortsfest bleibt.



=== Mathematische Herleitung

Die Gitarrensaite wird daher als Feder mit sehr hoher Federkonstante modelliert.

Für eine realistischere Beschreibung des Gesamtsystems muss zusätzlich das Tremolosystem berücksichtigt werden,
da dieses über die Rotation der Brücke unmittelbar mit den auf die Saiten wirkenden Kräften gekoppelt ist. (Siehe: @FRQuer)

Die auf eine einzelne Saite $i$ wirkende Kraft ist die Zugkraft am Stimmwirbel, mit der die Saite auf eine definierte Vorspannung gebracht wird.
Die Tremolofedern sind die Federn die unterhalb des Tremolos angebracht sind.

#figure(image("assets/floydrose_backside_neutral.jpg", height: 20%), caption: [Tremolofedern])
Die zur Ausdehnung der Tremolofedern erforderliche Kraft ist im Allgemeinen nicht identisch mit der
Saitenspannung. Ursache hierfür ist die rotatorische Lagerung der Brücke, weshalb das entstehende
Drehmoment explizit berücksichtigt werden muss.

Für den Stimmvorgang ist maßgeblich, welche physikalischen Größen die Schwingungsfrequenz einer Saite bestimmen.
Stimmen bedeutet, die Zugkraft einer Saite so einzustellen, dass sie mit einer vorgegebenen Eigenfrequenz schwingt.

Der Zusammenhang zwischen effektiver Saitenlänge $L_(S,i)$, Zugkraft $F_(S,i)$,
linearer Massendichte $mu_i$ und Frequenz $f_i$ wird durch das Mersennesche Gesetz beschrieben
@wiki_mersennes_laws:

$
f_i = 1 / (2 L_(S,i)) sqrt(F_(S,i) / mu_i)
$<eqMersenne>

Die effektive Saitenlänge ist der zwischen Sattel und Steg gespannte Abschnitt der Saite, der schwingt und die Tonhöhe bestimmt. Die Gesamtsaitenlänge ist größer, da zusätzliches Saitenmaterial zur Fixierung und Spannungseinstellung am Stimmwirbel benötigt wird; diese aufgewickelten Abschnitte sind nicht schwingend und beeinflussen weder die Tonerzeugung noch die Grundfrequenz, sondern haben ausschließlich eine mechanische Funktion - siehe @FRMTop.

Dabei ist zu beachten, dass die effektive Saitenlänge $L_(S,i)$ keine konstante Größe ist. Sie hängt von der Auslenkung der Tremolofedern ab, welche wiederum durch die Gesamtkraft aller Saiten bestimmt wird.
In der Realität hat jede Saite eine eigene Schwingendesaitenlänge, wie in @FRTop zu sehen ist.  

In einem Gitarrensystem wirken sechs Saiten gleichzeitig auf die Brücke. Mechanisch entspricht dies einer Parallelschaltung von Federn, wobei für parallel geschaltete Federn sich sowohl die Kräfte als auch die Federkonstanten addieren 
@leifiphysik_kombination_federn. Die Summe der Kräfte ist die auf die Brücke wirkende Gesamtkraft $F_B$:


$
F_B = sum_(i=1)^6 F_(S,i) = sum_(i=1)^6(L_(S,i) - L_(0S,i)) dot k_(S,i)
$<eqBrückenkraft>



wobei $L_(0S,i)$ die unbelastete Saitenlänge im Abschnitt zwischen Sattel und Brücke beschreibt.


Für die Tremolofedern gilt analog:

$
F_F = (L_F - L_(0F)) dot k_F
$<eqTremolofederkraft>

Die Saite wird beim Stimmen um eine Strecke $Delta L_i$ aufgewickelt, was die unbelastete Saitenlänge beeinflusst und welche die einzige direkt steuerbare Variable beim Stimmen ist.  Sei $ arrow(Delta L) = vec(Delta L_1, dots.v, Delta L_i, dots.v, Delta L_6) $ der Vektor, der für jede Saite die jeweilige Aufwickelstrecke beschreibt.

Unter dieser Definition lässt sich die resultierende Saitenkraft als Funktion von $arrow(Delta L)$
formulieren zu

$
F_B (arrow(Delta L))
= sum_(i=1)^6 (L_(S,i) - L'_(0S,i) + Delta L_i) dot k_(S,i)
$
// TODO: weiter machen
Gesucht ist eine Abbildung $arrow(f)(arrow(Delta L))$
die den Vektor der Aufwickelstrecken $arrow(Delta L)$
auf den Vektor der Eigenfrequenzen $ vec(f_1, f_2, dots.v, f_6) $
abbildet.

Die zentrale zu bestimmende Größe ist hierbei $L_(S,i)$.
Zu diesem Zweck wird zunächst die Brücke modelliert, da diese $L_(S,i)$ direkt beeinflusst.

Die Brücke wird als starrer, gewinkelter Hebel betrachtet.
Die Drehachse liege im Koordinatenursprung.
Die Vektoren $arrow(h_F)$ (Hebelarm der Feder) und $arrow(h_S)$ (Hebelarm der Saite)
schließen konstruktionsbedingt einen konstanten Winkel $alpha$ ein.
Die Beträge $h_F$ und $h_S$ sind systemspezifische Konstanten.

Es sei

$
arrow(h_S)(beta) = h_S vec(cos(beta), sin(beta))
$

Dann folgt

$
arrow(h_F)(beta) = h_F vec(cos(beta - alpha), sin(beta - alpha))
$

Sei $arrow(P_S)$ die Position des Sattels.
Die effektive Saitenlänge ergibt sich zu

$
L_(S,i) (beta) = abs(arrow(h_S)(beta) - arrow(P_S))
$

wobei $arrow(P_S)$ konstant ist.
Analog gilt für die Tremolofeder:

$
L_F (beta) = abs(arrow(h_F)(beta) - arrow(P_F))
$

Die relevante Zustandsgröße ist der Rotationswinkel $beta$.
Dieser ergibt sich aus dem Kräftegleichgewicht an der Brücke.

Nach den Gesetzen der Statik trägt ausschließlich der zur jeweiligen Hebelarmrichtung orthogonale
Kraftanteil zum Drehmoment bei.
Das zugrunde liegende Modell ist in der folgenden Abbildung dargestellt.

#figure(
  image("FlyodRoseTop.png")
)

Im stationären Gleichgewicht gilt das Drehmomentgleichgewicht:

$
abs(F_(S,"Effective")) dot h_S = abs(F_(F,"Effective")) dot h_F
$

Dabei bezeichnen $F_(S,"Effective")$ und $F_(F,"Effective")$ jeweils die Anteile der Kräfte
$arrow(F_B)$ und $arrow(F_F)$, die orthogonal zu den Hebelarmen $arrow(h_S)$ und $arrow(h_F)$ wirken.

Der normierte Richtungsvektor der Saitenkraft ist gegeben durch

$
arrow(e)_(F_B)
= (arrow(P_S) - arrow(h_S)) / abs(arrow(P_S) - arrow(h_S))
$

Der Kraftvektor lautet damit:

$
arrow(F_B) = F_B dot arrow(e)_(F_B)
$

Der normierte Richtungsvektor des Hebelarms ergibt sich aus:

$
arrow(e)_(h_S) = arrow(h_S) / abs(arrow(h_S)) = vec(cos(beta), sin(beta))
$

Die orthogonale Projektion eines Vektors $arrow(a)$ bezüglich eines Richtungsvektors $arrow(b)$
ergibt sich allgemein zu @technikermathe_orthogonale_zerlegung_vektoren:

$
arrow(a)_(bot arrow(b)) = arrow(a) - arrow(a)_(parallel arrow(b))
$

mit

$
arrow(a)_(parallel arrow(b))
= (arrow(a) dot arrow(b)) / (abs(arrow(b))^2) dot arrow(b)
$



Da $arrow(e)_(h_S)$ normiert ist, gilt $abs(arrow(e)_(h_S))^2 = 1$.
Setzt man $arrow(a) = arrow(F_B)$ und $arrow(b) = arrow(e)_(h_S)$, so folgt:

$
arrow(F_B)_(bot arrow(e)_(h_S)) =
arrow(F_B) - (arrow(F_B) dot arrow(e)_(h_S)) dot arrow(e)_(h_S)
$

Da im Drehmomentgleichgewicht lediglich der Betrag der orthogonalen Kraft relevant ist,
betrachten wir den Betrag dieses Vektors:

$
F_(S bot arrow(h_S)) =
abs(
arrow(F_B) - (arrow(F_B) dot arrow(e)_(h_S)) dot arrow(e)_(h_S)
)
$

Einsetzen von $arrow(F_B) = F_B dot arrow(e)_(F_B)$ ergibt:

$
F_(S bot arrow(h_S)) =
abs(
F_B dot arrow(e)_(F_B)
- (F_B dot arrow(e)_(F_B) dot arrow(e)_(h_S)) dot arrow(e)_(h_S)
)
$

Faktorisiert nach $F_B$:

$
F_(S bot arrow(h_S)) =
F_B dot
abs(
arrow(e)_(F_B)
- (arrow(e)_(F_B) dot arrow(e)_(h_S)) dot arrow(e)_(h_S)
)
$

Der Ausdruck in den Betragsstrichen beschreibt den Betrag der orthogonalen Komponente
des normierten Richtungsvektors $arrow(e)_(F_B)$ bezüglich des normierten Hebelarmvektors
$arrow(e)_(h_S)$.

Die orthogonale Komponente ergibt sich aus der Vektorzerlegung in einen parallelen und
einen orthogonalen Anteil:

$
abs(arrow(e)_(F_B bot arrow(e)_(h_S))) =
abs(
arrow(e)_(F_B)
- (arrow(e)_(F_B) dot arrow(e)_(h_S)) dot arrow(e)_(h_S)
)
$

Da $arrow(e)_(F_B)$ und $arrow(e)_(h_S)$ normiert sind, kann auf den Satz des Pythagoras
zurückgegriffen werden. Für den Betrag der orthogonalen Komponente gilt damit:

$
abs(arrow(e)_(F_B bot arrow(e)_(h_S)))^2 =
abs(arrow(e)_(F_B))^2
- abs((arrow(e)_(F_B) dot arrow(e)_(h_S)) dot arrow(e)_(h_S))^2
$

Wegen $abs(arrow(e)_(F_B)) = 1$ folgt unmittelbar:

$
abs(arrow(e)_(F_B bot arrow(e)_(h_S)))^2 =
1
- abs((arrow(e)_(F_B) dot arrow(e)_(h_S)) dot arrow(e)_(h_S))^2
$

Unter Verwendung der Definition des Skalarprodukts

$
arrow(u) dot arrow(v)
= abs(arrow(u)) abs(arrow(v)) cos(angle.arc(arrow(u), arrow(v)))
$

ergibt sich:

$
abs(arrow(e)_(F_B bot arrow(e)_(h_S)))^2 =
1
- abs(
abs(arrow(e)_(F_B))
abs(arrow(e)_(h_S))
cos(angle.arc(arrow(e)_(F_B), arrow(e)_(h_S)))
dot arrow(e)_(h_S)
)^2
$

Da beide Richtungsvektoren normiert sind, vereinfacht sich der Ausdruck zu:

$
abs(arrow(e)_(F_B bot arrow(e)_(h_S)))^2 =
1
- cos^2(angle.arc(arrow(e)_(F_B), arrow(e)_(h_S)))
$

Mit der trigonometrischen Identität $1 = sin^2(x) + cos^2(x)$ folgt schließlich:

$
abs(arrow(e)_(F_B bot arrow(e)_(h_S))) =
abs(sin(angle.arc(arrow(e)_(F_B), arrow(e)_(h_S))))
$

Setzt man dieses Ergebnis in die Definition des wirksamen Kraftanteils ein, erhält man:

$
F_(S bot arrow(h_S)) =
F_B dot abs(sin(angle.arc(arrow(e)_(F_B), arrow(e)_(h_S))))
$

Der Winkel zwischen den beiden Richtungsvektoren lässt sich über das Skalarprodukt ausdrücken:

$
angle.arc(arrow(e)_(F_B), arrow(e)_(h_S)) =
arccos(arrow(e)_(F_B) dot arrow(e)_(h_S))
$

Alternativ kann der Ausdruck rein algebraisch formuliert werden.
Unter Verwendung der Identität $sin(arccos(x)) = sqrt(1 - x^2)$ ergibt sich:

Da $arrow(e)_(h_S)$ normiert ist, folgt:

$
F_(S bot arrow(h_S))
= F_B dot sqrt(1 - (arrow(e)_(F_B) dot arrow(e)_(h_S))^2)
$

Analog ergibt sich für die Tremolofeder:

$
F_(F bot arrow(h_F))
= F_F dot sqrt(1 - (arrow(e)_(F_F) dot arrow(e)_(h_F))^2)
$

Diese Terme gehen in das Drehmomentgleichgewicht ein:

$
h_F dot F_F dot sqrt(1 - (arrow(e)_(F_F) dot arrow(e)_(h_F))^2)
=
h_S dot F_B dot sqrt(1 - (arrow(e)_(F_B) dot arrow(e)_(h_S))^2)
$

Diese Gleichung ist im Allgemeinen nichtlinear und bestimmt den Rotationswinkel $beta$ der Brücke.

Bringt man sie in die Form einer Nullstellengleichung, erhält man

$
0 = g(beta) =
h_F dot F_F dot sqrt(1 - (arrow(e)_(F_F)(beta) dot arrow(e)_(h_F)(beta))^2)
-
h_S dot F_B dot sqrt(1 - (arrow(e)_(F_B)(beta) dot arrow(e)_(h_S)(beta))^2)
$

Damit liegt ein eindimensionales nichtlineares Optimierungs- bzw. Nullstellenproblem vor, mit dem sich der Rotationswinkel $beta$ numerisch bestimmen lässt.

Aus dem so berechneten Winkel ergeben sich transitiv die abhängigen Größen
$
h_F (beta); h_S (beta); L_(S,i) (beta)
$
und daraus schließlich die Saitenkraft
$
F_B (arrow(Delta L)).
$


Die lineare Massendichte $mu_i$ wird durch die Länge der Saite beeinflusst.  Ziel ist es daher, die lineare Massendichte als Funktion der Aufwickelstrecken $arrow(Delta L)$ zu bestimmen, also $mu_i (arrow( Delta L))$.

Im Allgemeinen gilt für Saite $i$:

$
mu_i = m_i / L_"S,i,Total"
$

Dabei bezeichnet $m_i$ die Gesamtmasse der Saite $i$ und $L_"S,i,Total"$ die Gesamtlänge der Saite. 
Wird die Saite aufgezogen, bewegt sich die Brücke um eine Strecke $Delta h$ in Richtung Sattel. Wäre die Federkonstante der Brücke $k_F = 0$, würde sich die Saite ohne Widerstand bewegen und die Brückenbewegung entspräche exakt der Aufwickelstrecke:

$
Delta h = Delta L_i
$

In der Realität gilt jedoch $k_F > 0$. Die Saite muss sich daher zusätzlich dehnen, um die Federkraft der Brücke auszugleichen. Diese Dehnung wirkt der Aufwickelrichtung entgegen. Es gilt somit:

$
Delta h(arrow(Delta L)) = Delta L_i - d_i (arrow(Delta L))
$

wobei $d_i (arrow(Delta L))$ der Längenanteil ist, um den sich die Saite elastisch dehnt.

Die Länge der schwingenden Saite lässt sich daher schreiben als:

$
L_(S,i) (arrow(Delta L)) = L'_"0S,i" - Delta h(arrow(Delta L))
$

Setzt man den Ausdruck für $Delta h$ ein, ergibt sich im allgemeinen Fall:

$
L_(S,i) (arrow(Delta L)) = L'_"0S,i" - Delta L_i + d_i (arrow(Delta L))
$

Daraus folgt für die Verlängerung der Saite:

$
d_i (arrow(Delta L)) = L_(S,i) (arrow(Delta L)) - L'_"0S,i" + Delta L_i
$


Die Gesamt länge ergibt sich somit zu 
$
L_"S,i,Total" (arrow(Delta L)) = L'_"0S,i" + L'_"0M,i" + d_i (arrow(Delta L))
$
$
L_"S,i,Total" (arrow(Delta L)) = L_(S,i) (arrow(Delta L))+ L'_"0M,i" + Delta L_i
$

wobei $L'_"0M,i"$ die initiale Strecke der Saite hinter dem Sattel beschreibt ($Delta L_i = 0)$. 

Die lineare Massendichte ergibt sich somit zu:

$
mu_i (arrow(Delta L)) = m_i/(L_(S,i) (arrow(Delta L)) + L'_"0M,i" + Delta L_i)
$

Darauf aufbauend lässt sich eine Abbildung definieren, die die Aufwickelstrecke jeder Saite auf einen Frequenzvektor abbildet:

$
f_i (arrow(Delta L)) =
1 / (2 dot L_(S,i) (arrow(Delta L)))
sqrt((F_"S,i" (arrow(Delta L)) )/ (mu_i (arrow(Delta L))))
$


Setzt man die Definitionen für $F_"S,i" (arrow(Delta L))$und $mu_i (arrow(Delta L))$ ein, erhält man:

$
f_i (arrow(Delta L)) =
1 / (2 dot L_(S,i) (arrow(Delta L)))
sqrt(((L_(S,i) (arrow(Delta L))- L'_(0S,i) + Delta L_i) dot k_(S,i))/ (
m_i/(L_(S,i) (arrow(Delta L)) + L'_"0M,i" + Delta L_i)
))
$
Nach Vereinfachen:
$
f_i (arrow(Delta L)) =
1 / (2 dot L_(S,i) (arrow(Delta L)))
sqrt(((L_(S,i) (arrow(Delta L))- L'_(0S,i) + Delta L_i) dot k_(S,i) dot (L_(S,i) (arrow(Delta L)) + L'_"0M,i" + Delta L_i))/ 
m_i
)
$

== Experiment: Nachweis Linearität

Für kleine Auslenkungen $Delta x$ gilt aufgrund der Taylor-Approximation eine annähernd lineare Beziehung zwischen Zugkraft und Dehnung.  
Im Folgenden wird daher ein Experiment vorgestellt, dass die angenommene Lineariät der Saite überprüft.

Das Folgende Experiment zeigt, das näherungsweise Lineare Verstimmungsverhalten der Floyd-Rose Gitarre.

Es wird ein Experiment durchgeführt, bei dem die Frequenzänderungen der Saiten gemessen werden, wenn eine andere Saite verstimmt wird.

=== Vorgehensweise 
Zunächst wird jede Saite in eine Ausgangsposition gebracht. Eine Standard-Gitarrenstimmung ist E–A–D–G–B–e. Da eine Gitarre aufgrund menschlicher Ungenauigkeiten nicht perfekt gestimmt werden kann, werden die Ausgangsfrequenzen der Saiten zunächst gemessen und aufgezeichnet.

Anschließend wird jeweils eine Saite um ein beliebiges $Delta$ verstimmt. Dieses $Delta$ wird so gewählt, dass die Verstimmung deutlich hörbar ist. Auch dieses $Delta$ wird gemessen und dokumentiert.

Jede Saite wird in vier Schritten nach oben und vier Schritten nach unten verstimmt. Für jeden Schritt wird die Frequenz aller anderen Saiten gemessen und aufgezeichnet.

=== Ziel

Das Ziel des Experiments ist es zu beobachten, ob das System
- hinreichend linear ist (was nach der Theorie nicht zu erwarten)
- elastisch ist.

Elastizität bedeutet hier, dass die Frequenz einer Saite wieder in ihren Ausgangszustand zurückkehrt, sobald die Saite selbst wieder in die Ausgangslage gebracht wird. Um dies zu überprüfen, werden nach allen Verstimmungsschritten die Endfrequenzen mit den Anfangswerten verglichen.
Um die Theorie zu überprüfen, wird ein Experiment durchgeführt, bei dem die Frequenzänderungen der Saiten gemessen werden, wenn eine andere Saite verstimmt wird.

Zunächst wird jede Saite in eine Ausgangsposition gebracht. Eine Standard-Gitarrenstimmung ist E–A–D–G–B–E. Da eine Gitarre aufgrund menschlicher Ungenauigkeiten nicht perfekt gestimmt werden kann, werden die Ausgangsfrequenzen der Saiten zunächst gemessen und aufgezeichnet.

Anschließend wird jeweils eine Saite um ein beliebiges $Delta$ verstimmt. Dieses $Delta$ wird so gewählt, dass die Verstimmung deutlich hörbar ist. Auch dieses $Delta$ wird gemessen und dokumentiert.

Jede Saite wird in vier Schritten nach oben und vier Schritten nach unten verstimmt. Für jeden Schritt wird die Frequenz aller anderen Saiten gemessen und aufgezeichnet.

Das Ziel des Experiments ist es zu beobachten, ob das System
- hinreichend linear ist
- elastisch ist.

Elastizität bedeutet hier, dass die Frequenz einer Saite wieder in ihren Ausgangszustand zurückkehrt, sobald die Saite selbst wieder in die Ausgangslage gebracht wird. Um dies zu überprüfen, werden nach allen Verstimmungsschritten die Endfrequenzen mit den Anfangswerten verglichen.

Zur Frequenzmessung wird ein Python-Programm eingesetzt, das mithilfe der Fourier-Transformation die Schwingungsfrequenzen bestimmt. Die Visualisierung erfolgt ebenfalls mit Python, wobei die Bibliothek matplotlib.pyplot für die Darstellung der Graphen genutzt wird.

== Lösung

Inverse Matrix etc

= Verfahrensweise

== Ablauf eines Stimmvorgangs
Um nun eine Gitarre zustimmen, muss zunächst die Verstimmungsmatrix, der zu stimmenden Gitarre ermittelt werden. Dazu muss zunächst die Ausgangslage der Gitarre bestimmt werden. Dann wird die 1. Saite verstimmt und der Einfluss dieser Saite auf die anderen 5. Saiten gemessen. Dann werden die nächsten Saiten nach diesem Schema verstimmt und gemessen. Anhand diesen änderungen wird die Verstimmungsmatrix berechnet. Anschließend wird der Zustand der Gitarre ermittelt und es wird für jede Saite ein delta Frequenz berechnet, um die die Gitarre verstimmt werden muss. Der Nutzer muss dann jede Saite verstimmen sodass die Delta Frequenz 0 ist.

Um das umzusetzen benötigen wir ein Verfahren um die Frequenz der Angespielten Saite zu ermitteln.

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
  Noll, A. M. (1967). *Cepstrum pitch determination*. J. Acoust. Soc. Am., 41(2), 293–309.

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