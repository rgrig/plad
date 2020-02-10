use std::io;
use std::io::Read;
use std::sync::mpsc;
use std::thread;

const EPSILON: f64 = 1e-6;

fn go(
    mut score: f64,
    senders: Vec<mpsc::Sender<f64>>,
    receivers: Vec<mpsc::Receiver<f64>>,
    conv: mpsc::Sender<()>,
    stop: mpsc::Receiver<()>,
) -> f64 {
    let scnt = senders.len() as f64;
    loop {
        match stop.try_recv() {
            Ok(()) => return score,
            _ => (),
        };
        for s in &senders {
            s.send(score / scnt).unwrap();
        }
        let mut new_score: f64 = 0.0;
        for r in &receivers {
            new_score += match r.recv() {
                Ok(x) => x,
                Err(_) => return score, // others stopped
            }
        }
        if (score - new_score).abs() < EPSILON {
            match conv.send(()) {
                Ok(()) => (),
                Err(e) => panic!("conv {}", e),
            }
        }
        score = new_score;
    }
}

fn main() {
    // Read input.
    let mut stdin = io::stdin();
    let mut allinput = String::new();
    stdin
        .read_to_string(&mut allinput)
        .expect("can't read input");
    let mut iterinput = allinput.split_whitespace();

    let n: usize = iterinput
        .next()
        .expect("missing number of pages")
        .parse()
        .expect("number of pages should be nonnegative int");

    let mut m: Vec<Vec<usize>> = vec![vec![]; n + 1];
    for i in 0..(n + 1) {
        m[0].push(i);
    }
    for i in 1..(n + 1) {
        while {
            let j: usize = iterinput.next().expect("j").parse().expect("usize");
            m[i].push(j);
            j != 0
        } {}
    }

    // Create channels
    let mut senders: Vec<Vec<mpsc::Sender<f64>>> = vec![vec![]; n + 1];
    let mut receivers: Vec<Vec<mpsc::Receiver<f64>>> = vec![];
    for _ in 0..=n {
        // HACK
        receivers.push(vec![]);
    }
    for i in 0..=n {
        for j in &m[i] {
            let (tx, rx) = mpsc::channel();
            senders[i].push(tx);
            receivers[*j].push(rx);
        }
    }
    let mut conv_tx: Vec<mpsc::Sender<()>> = vec![];
    let mut conv_rx: Vec<mpsc::Receiver<()>> = vec![];
    for _ in 0..=n {
        let (tx, rx) = mpsc::channel();
        conv_tx.push(tx);
        conv_rx.push(rx);
    }
    let mut stop_tx: Vec<mpsc::Sender<()>> = vec![];
    let mut stop_rx: Vec<mpsc::Receiver<()>> = vec![];
    for _ in 0..=n {
        let (tx, rx) = mpsc::channel();
        stop_tx.push(tx);
        stop_rx.push(rx);
    }

    // Create threads
    let mut threads: Vec<thread::JoinHandle<f64>> = vec![];
    let mut senders_iter = senders.drain(..);
    let mut receivers_iter = receivers.drain(..);
    let mut conv_iter = conv_tx.drain(..);
    let mut stop_iter = stop_rx.drain(..);
    let sc: f64 = 1.0 / ((n + 1) as f64);
    loop {
        let se = match senders_iter.next() {
            Some(x) => x,
            None => break,
        };
        let re = receivers_iter.next().unwrap();
        let co = conv_iter.next().unwrap();
        let st = stop_iter.next().unwrap();
        /*
        let t = loop { // HACK (see https://github.com/rust-lang/rust/issues/46345)
            match thread::Builder::new().spawn(move || go(sc, se, re, co, st)) {
                Ok(t) => break t,
                Err(_) => (),
            }
        };
        threads.push(t);
        */
        threads.push(thread::spawn(move || go(sc, se, re, co, st)));
    }

    // Wait until convergence
    for c in &conv_rx {
        c.recv().unwrap();
    }
    for s in stop_tx {
        s.send(()).unwrap();
    }

    // Collect results
    let mut results: Vec<f64> = vec![];
    for t in threads {
        results.push(t.join().unwrap());
    }

    // Report result.
    for p in results {
        println!("{}", p);
    }
}
