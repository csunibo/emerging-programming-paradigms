Il modo più semplice di implementare i blocchi try .. catch consiste nel creare
uno speciale stack frame che punta al codice del catch e poi eseguire la try. Se
la try termina con un valore, il blocco try .. catch viene rimosso dalla cima
dello stack. La throw itera sullo stack facendo pop di tutti gli stack frame (=
terminando la varie chiamate annidate di funzioni) fino a quando non incontra
uno stack frame speciale che rappresenti un try .. catch che sia in grado di
catturare l'eccezione. In tal caso il frame speciale viene rimosso e viene
eseguito il codice associato alla cattura. I blocchi con after richiedono
ulteriore codice per il loro trattamento (esempio: il codice dopo after va
eseguito prima di eliminare lo speciale stack frame). La creazione di uno stack
frame speciale impedisce di ottimizzare una chiamata "di coda" contenuta nel
try.
