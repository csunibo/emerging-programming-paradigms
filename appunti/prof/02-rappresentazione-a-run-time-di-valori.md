Nei linguaggi funzionali: immediate (unboxed) vs boxed values. I valori boxed
sono rappresentabili in 63 bit (o meno) e occupano una word il cui bit meno
significativo è 1. Esempi: numeri, atomi, booleani, PID. I restanti valori
vengono allocati nelo heap e rappresentati con un puntatore word-aligned (ovvero
il cui bit meno significativo è 0). Per esempio, una tupla {foo, 3, 4} viene
rappresentata da un puntatore (che occupa una word) a una sequenza di celle
nello heap che contengono un header (se richiesto) e poi le rappresentazioni di
foo, 3 e 4. Il bit meno significativo permette al garbage collector di
distinguere tra puntatori nello heap e tipi immediati. I singoli linguaggi
possono richiedere rappresentazioni leggermente più elaborate: vediamo il caso
semplice di OCaml e quello più complesso di Erlang.

In OCaml i tipi non permettono di confrontare valori immediati (unboxed)
appartenenti a tipi differenti. Pertanto non è necessario che l'immediato
codifichi il tipo di valore (intero vs atomo vs ...). La rappresentazione a
run-time è pertanto semplice, vedi
[qui](https://dev.realworldocaml.org/runtime-memory-layout.html) (leggere fino a
"Variants and Lists" escluso).

Erlang invece necessita di ulteriori bit nei valori immediati per non confondere
atomi, numeri, etc.: 0=false deve fallire quindi 0 e false devono avere
rappresentazioni diverse, mentre in OCaml entrambi sono rappresentati dalla word
\1. I dettagli sulla rappresentazione dei valori in Erlang li trovate
[qui](https://beam-windows.clau.se/indepth-memory-layout.html).

Per ulteriori dettagli, consultate "Rappresentazione dei dati".
