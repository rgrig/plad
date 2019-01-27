---
title: rust-intro
breaks: false
slideOptions:
  transition: slide
---

# Introduction to Rust

---

## Why Rust?

 * **Ownership and Borrowing**: innovative memory management
 * **Fearless Concurrency**: Firefox rendering is fast because it is done in Rust
 * Fast but Safe
 * Cutting edge PL research

---

``` Rust
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
```

---


## More Information

 * [The Rust Book](https://doc.rust-lang.org/book/)
 * [The Rust Standard Library](https://doc.rust-lang.org/std/)

---

###### tags: `plad`

