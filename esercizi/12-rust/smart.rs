use std::ops::Deref;
use std::fmt::Display;
use std::fmt;

struct MyBox<T: Display>(T);   // una tupla con un solo campo

impl<T: Display> MyBox<T> {
    fn new(x: T) -> MyBox<T> { MyBox(x) }
}

impl<T: Display> Display for MyBox<T> {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{}", self.0)
    }
}

impl<T: Display> Deref for MyBox<T> {       // implementiamo il dereferencing, *
    type Target = T;                          // associated type: * restituisce un &T,
                                                        // ovvero una reference al Target che è T

    fn deref(&self) -> &T { &self.0 }   // il T è il valore dell’unico campo della tupla
}

impl<T: Display> Drop for MyBox<T> {
    fn drop(&mut self) {
        println!("Dropping MyBox<T> with data `{}`!", self.0);
    }
}

fn main() {
    let x = MyBox::new(4);
    let y = *x;
    println!("x = {}, y = {}", x, y);
}
