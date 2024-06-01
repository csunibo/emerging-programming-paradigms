fn max<'a,'b : 'a,'c : 'a>(x: &'b i32, y: &'c i32) -> &'a i32 {
    std::cmp::max(x,y)
}

fn main() {
    let x = 4;
    let y = 3;
    let z;
    z = max(&x, &y);
    println!("max = {}", z);
}
