use std::io;
use std::io::Read;

fn mmin(a : Option<i32>, b : Option<i32>) -> Option<i32> {
    match (a, b) {
        (None, c) | (c, None) => c,
        (Some(x), Some(y)) => Some (if x < y {x} else {y})
    }
}

fn main() {
    let mut stdin = io::stdin();
    let mut allinput = String::new();
    stdin.read_to_string(&mut allinput).expect("can't read input");
    let mut i = allinput.split_whitespace();

    let n : usize =
        i.next().expect("missing target sum")
        .parse().expect("target sum not integer");
    let mut coins : Vec<usize> = vec![];
    i.for_each(|x| coins.push(x.parse().expect("not integer")));

    let mut dp : Vec<Option<i32>> = vec![None; n+1];
    dp[0] = Some(0);
    for d in coins {
        for v in d..(n+1) {
            dp[v] = mmin(dp[v], dp[v-d].map(|x| x+1));
        }
    }
    match dp[n] {
        Some(x) => println!("{}",x),
        None => println!("oops")
    }
}
