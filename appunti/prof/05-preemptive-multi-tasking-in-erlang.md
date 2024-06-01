La virtual machine di Erlang implementa multi-tasking preemptive senza fare
ricorso a interrupt hardware. Di fatto, implementa multi-tasking cooperative
dove le yield() sono inserite all'interno delle istruzioni della virtual
machine. Ogni processo ha a dispoaizione un certo numero di "token", chiamate
reduction, che vengono decrementate in punti significativi del codice (quali le
chiamate di funzioni); quando il numero di token scende a 0, un nuovo processo
viene schedulato. Per dettagli, vedi [Erlang Scheduler Details and Why it
Matters](hamidreza-s.github.io/erlang/scheduling/real-time/preemptive/migration/2016/02/09/erlang-scheduler-details.html).
