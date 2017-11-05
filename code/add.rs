use std::io;
use std::io::BufRead;

fn main() {
    let stdin = io::stdin();

    for line in stdin.lock().lines() {
        let s = line.expect("A");
        let mut sum = 0;
        for w in s.split_whitespace() {
            let x : i32 = w.parse().expect("B");
            sum += x;
        }
        println!("{}", sum);
    }
}
