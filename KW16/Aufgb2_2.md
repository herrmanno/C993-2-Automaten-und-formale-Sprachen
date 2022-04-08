# Aufgabe 2.2

Finden Sie für das Alphabet $A = \{a, b\}$ und das Wortersetzungssystem $S = \{ab \to ba\}$

a. die Menge aller Wörter $v \in A^*$ der Länge 7, auf welches keine Regel aus S angewendet werden kann.

- aaaaaaa
- baaaaaa
- bbaaaaa
- bbbaaaa
- bbbbaaa
- bbbbbaa
- bbbbbba
- bbbbbbb

b. die Menge aller Wörter $w \in A^*$ der Länge 7, von welchem eine Ableitung der Länge 12 existiert.
Geben Sie für das lexikographisch kleinste Wort in dieser Menge die Ableitung der Länge 12 an.

- aaaabbb
- aaabbbb

$aaa\underline{ab}bb \rightarrow
aa\underline{ab}abb \rightarrow
a\underline{ab}aabb \rightarrow
\underline{ab}aaabb \rightarrow
baaa\underline{ab}b \rightarrow
baa\underline{ab}ab \rightarrow
ba\underline{ab}aab \rightarrow
b\underline{ab}aaab \rightarrow
bbaaa\underline{ab} \rightarrow
bbaa\underline{ab}a \rightarrow
bba\underline{ab}aa \rightarrow
bb\underline{ab}aaa \rightarrow bbbaaaa$
