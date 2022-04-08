# Aufgabe 2.1

Finden Sie für das Alphabet $\{a, b, c\}$ und das Wortersetzungssystem
$S = \{a \to cbac, bc \to bacb, bb \to c\}$ eine Ableitung von $acc$ zu $cbaccacccc$.

$\underline{a}cc \xrightarrow{a \to cbac} cb\underline{a}ccc
                \xrightarrow{a \to cbac} c\underline{bc}bacccc
                \xrightarrow{bc \to bacb} cbac\underline{bb}acccc
                \xrightarrow{bb \to c} cbaccacccc$

