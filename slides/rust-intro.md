---
title: rust-intro
breaks: false
slideOptions:
  transition: slide
  center: false
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

## Variables

Variables are immutable by default.

``` Rust
let x = 5
x = x + x // error: cannot assign twice
```

They shadow each-other. This works:
``` Rust
let x = 5
let x = x + x
```

Or can be made explicitly mutable:
``` Rust
let mut x = 5
x = x + x
```

---

## Scalar Types

 * Integers: i$S$, u$S$, where $S\in\{8,16,32,64,128\}$
     * For two's complement use `std::num::Wrapping`
 * Floats: f32, f64
 * Booleans (`bool`)
 * Characters (`char`)

---

## Compound Types

Tuples:
```Rust
let x: (i32, f64, u8) = (500, 6.4, 1);
let five_hundred = x.0;
let six_point_four = x.1;
let one = x.2;
```

Arrays:
```Rust
let a: [i32; 5] = [1, 2, 3, 4, 5];
println!("a[3]={}\n", a[3]);
```

---

## Expressions and Statements

```Rust
fn raise_four(x : i32) -> i32 {
   let x = x * x; // statement
   x * x          // expression
}
```

---

## Control Flow

`if` *expressions*
```Rust
let x = if y > 0 {1} else {2}
```

`loop` with `break`
```Rust
let mut i = 0;
loop { i += 1; if i == 10 {break 20;}}
```

`while` loops
```Rust
let mut i = 10;
while i >= 0 { i -= 1; println!("{}", i);}
```

---

## Iterating Collections

```Rust
let a = ["Monday", "Tuesday" ];
for x in a.iter() { println!("{}",x); }
a.iter().for_each(|x| println!("{}",x));
```

---

## (Heap) Memory Management


The two standard techniques are
1. explicit allocation and deallocation
2. garbage collection

---

## Ownership and Borrowing

 * each heap object has *exactly one* owner on the stack
 * it may have other references
     * several immutable ones, *or*
     * one mutable one

---

## Ownership Example 1

```Rust
let s1 = String::from("hello");
let s2 = s1;
println!("{}, world!", s1); // error
```

---

## Ownership Example 2

```Rust
fn main() {
   let s1 = String::from("hello");
   let (s2, len) = calculate_length(s1);
   println!("The length of '{}' is {}.", s2, len);
}

fn calculate_length(s: String) -> (String, usize) {
    let length = s.len(); // len() returns the length of a String
    (s, length)
}
```

---

## Borrowing Example 1

```Rust
fn main() {
   let s1 = String::from("hello");
   let len = calculate_length(&s1);
   println!("The length of '{}' is {}.", s1, len);
}

fn calculate_length(s: &String) -> usize {
   s.len()
}
```

---

## Borrowing Example 2

```Rust
fn main() {
   let mut s = String::from("hello"); // must be mutable!
   change(&mut s);
}

fn change(some_string: &mut String) {
   some_string.push_str(", world");
}
```

---

## More Information

 * [The Rust Book](https://doc.rust-lang.org/book/)
 * [The Rust Standard Library](https://doc.rust-lang.org/std/)
 * [Talk by Aaron Turon](https://www.youtube.com/watch?v=hY0gyzItyEo)

---

###### tags: `plad`

