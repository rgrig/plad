all: Lambda-OCaml CountDistinct-Haskell CoinChange-OCaml CoinChange-Haskell CountDistinct.class CoinChange.class CoinChange-Rust Pagerank-Rust Pagerank-OCaml add-Haskell add-Rust

add-Haskell CountDistinct-Haskell CoinChange-Haskell: %-Haskell: %.hs
	ghc --make -O2 $< -o $@

CountDistinct.class CoinChange.class: %.class: %.java
	javac $<

add-Rust CoinChange-Rust Pagerank-Rust: %-Rust: %.rs
	rustc -g -O $< -o $@

CoinChange-OCaml Lambda-OCaml Pagerank-OCaml: %-OCaml: %.ml
	ocamlfind opt -linkpkg -package ppx_deriving.std -g -O3 $< -o $@
