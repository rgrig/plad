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

    let mut m : Vec<Vec<usize>> = vec![vec![]; n+1];
    for i in 0..(n+1) { m[0].push(i); }
    for i in 1..(n+1) {
        while {
            let j : usize = iterinput.next().expect("j").parse().expect("usize");
            m[i].push(j);
            j != 0
        } {}
    }

    // Iterate.
    let mut now : Vec<f64> = vec![1.0/(n as f64); n + 1];
    let mut nxt : Vec<f64> = vec![0.0; n + 1];
    while {
        for i in 0..(n+1) {
            for j in &m[i] {
                nxt[*j] += now[i] / (m[i].len() as f64);
            }
        }
        let error =
            (0..(n+1)).fold(0.0, |x,i| (now[i]-nxt[i]).abs().max(x));
        error > 1e-6
    } {
        swap(&mut now, &mut nxt);
        nxt = vec![0.0; n + 1];
    }

    // Report result.
    for p in nxt {
        println!("{}", p);
    }
}
