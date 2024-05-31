fn main() {
    let x = 4;
    let y = &x;
    let t = String::from("ciao");      // takes immutable ownership
    let s = &t;                        // borrows immutably
    println!("x = {}, y = {}", x, y);
    println!("s = {}, t = {}", s, t);
} // end of borrowing (s goes out of scope) and end of ownership (t goes out of
  // scope and the string is deallocated
