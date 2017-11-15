// TODO: make it work for sparse graphs
use std::io;
use std::io::Read;
use std::mem::swap;

fn main() {
    // Read input.
    let mut stdin = io::stdin();
    let mut allinput = String::new();
    stdin.read_to_string(&mut allinput).expect("can't read input");
    let mut iterinput = allinput.split_whitespace();

    let n : usize =
        iterinput.next().expect("missing number of pages")
        .parse().expect("number of pages should be nonnegative int");

    let mut m : Vec<Vec<f64>> = vec![vec![0.0; n+1]; n+1];
    for i in 0..(n+1) { m[i][0] += 1.0; }
    for i in 1..(n+1) { m[0][i] += 1.0; }
    for i in 1..(n+1) {
        let mut j : usize;
        while {
            j = iterinput.next().expect("j").parse().expect("usize");
            j != 0
        } {
            m[i][j] += 1.0;
        }
    }

    // Normalize transition matrix.
    for i in 0..(n+1) {
        let s : f64 = m[i].iter().sum();
        m[i] = m[i].iter().map(|x| x/s).collect();
    }

    // Iterate.
    let mut now = vec![1.0; n + 1];
    let mut nxt = vec![0.0; n + 1];
    while {
        for i in 0..(n+1) {
            for j in 0..(n+1) {
                nxt[j] += now[i] * m[i][j];
            }
        }
        let error =
            (0..(n+1)).fold(0.0, |x,i| (now[i]-nxt[i]).abs().max(x));
        error > 1e-9
    } {
        swap(&mut now, &mut nxt);
        nxt = vec![0.0; n + 1];
    }

    // Report result.
    for p in nxt {
        println!("{}", p);
    }
}
