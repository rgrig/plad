use std::io;
use std::io::Read;

fn main() {
    let mut sum = 0;
    let mut input = String::new();
    io::stdin().read_to_string(&mut input)
        .expect("I/O Error");
    for w in input.split_whitespace() {
        let n : i64 = w.parse()
            .expect("Please type integers");
        sum += n
    }
    println!("{}", sum);
}
