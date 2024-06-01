Le chiusure sono un costrutto estremamente semplice (la loro semantica è chiara)
ma anche estremamente espressivo, che consente in poche righe di codice di
trovare soluzioni a un particolare problema di programmazione. Inoltre
permettono di fornire soluzioni totalmente ortogonali e otimizzate (nel senso
della chiarezza del codice) a problemi distinti, a differenza, per esempio,
delle classi che cercano di risolvere numerosi problemi al tempo stesso (sono un
costrutto di scoping, implementano data hiding, late binding, permettono il
polimorfismo e il riuso del codice), finendo per risolvere male ognuno dei
problemi. Per esempio, per quanto riguarda il data hiding con le classi si può
avere visibilità pubblica o private. Questo è troppo grossolano e porta a due
fenomeni: da un lato non viene ristretta la visibilità in maniera progressiva,
rendendo certe funzioni visibili ove non necessario; dall'altro si introducono
altri modificatori ad-hoc (protected, friend, package, package protected, etc.)
per risolvere i casi che non rientrano nella dicotomia pubblica/private a che
finiscono per rendere la semantica del linguaggio iper-complessa.

I precedenti sono indubbi vantaggi, ma al tempo stesso vi è lo svantaggio di non
imporre una soluzione standard ai problemi, il che porta a una possibile
frammentazione delle soluzione che rende difficile la creazione di un ecosistema
integrato. Vedi, per esempio, quanto successo per i sistemi di moduli
Javascript dove sono stati prima sviluppati diversi framework per la modularità
basati tutti su chiusure e infine è stata recentemente introdotta una soluzione
linguistica a livello di standard. Un primo link può essere [questo
confronto](http://auth0.com/blog/javascript-module-system-showdown) fra alcuni
di tali sistemi.
