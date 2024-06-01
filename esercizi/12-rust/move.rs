fn main() {
    let x = 4;                       // 4 è unboxed, quindi sullo stack
    let s = String::from("ciao");    // s sullo stack punta a una stringa
                                     // nello heap
    let y = x;
    // scommentando la prossima linea e commentando la successiva
    // s perde l'ownership della stringa
    //let t = s;
    let t = String::from("ciao");
    println!("x = {}, y = {}", x, y);
    // la prossima riga è errata se s non ha più l'ownership
    println!("s = {}, t = {}", s, t);
}
