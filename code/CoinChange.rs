use std::io;
use std::io::Read;

fn mmin(a : Option<i32>, b : Option<i32>) -> Option<i32> {
    match (a, b) {
        (None, c) => c,
        (c, None) => c,
        (Some(x), Some(y)) => Some (if x < y {x} else {y}),
    }
}

fn main() {
    let mut stdin = io::stdin();
    let mut allinput = String::new();
    stdin.read_to_string(&mut allinput).expect("can't read input");
    let mut i = allinput.split_whitespace();

    let n : i32 =
        i.next().expect("missing target sum")
        .parse().expect("target sum not integer");
    let mut coins : Vec<i32> = Vec::new();
    i.for_each(|x| coins.push(x.parse().expect("not integer")));

    let mut dp : Vec<Option<i32>> = Vec::new();
    for _i in 0..(n+1) { dp.push(None); }
    dp[0] = Some(0);
    for d in coins {
        for v in 0..(n+1) {
            let vn = n - v;
            let mut k = 1;
            while vn - k * d >= 0 {
                let uvn : usize = vn as usize;
                let uvo = (vn - k * d) as usize;
                dp[uvn] = mmin(dp[uvn], dp[uvo].map(|x| x+k));
                k += 1;
            }
        }
    }
    if n < 0 {
        println!("oops");
    } else {
        match dp[n as usize] {
            Some(x) => println!("{}",x),
            None => println!("oops")
        }
    }
}
