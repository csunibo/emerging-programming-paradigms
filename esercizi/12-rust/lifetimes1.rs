// i lifetime 'b e 'c devono terminare dopo il lifetime di 'a
fn max<'a,'b : 'a,'c : 'a>(x: &'b i32, y: &'c i32) -> &'a i32 {
    std::cmp::max(x,y)
}

fn main() {
    //let z;                   // error se z è dichiarato prima di x o y
    let x = 4;
    let y = 3;
    let z;                     // ok se z è dichiarato dopo x,y
    z = max(&x, &y);
    println!("max = {}", z);
} // i lifetime finiscono in ordine inverso di dichiarazione
