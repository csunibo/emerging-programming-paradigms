fn increment<'a>(x: &'a mut i32) {
    *x = *x + 1;
}

fn main() {
    let mut x = 4;
    increment(&mut x);
    x = x + 1;
    println!("x = {}", x);
}
