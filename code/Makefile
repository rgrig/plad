all: CountDistinct-Haskell CoinChange-Haskell CountDistinct.class CoinChange-Rust Pagerank-Rust Pagerank-OCaml add-Haskell add-Rust

add-Haskell CountDistinct-Haskell CoinChange-Haskell: %-Haskell: %.hs
	ghc --make -O2 $< -o $@

CountDistinct.class: CountDistinct.java
	javac $<

CoinChange-Rust Pagerank-Rust: %-Rust: %.rs
	rustc -g -O $< -o $@

Pagerank-OCaml: %-OCaml: %.ml
	ocamlopt -g -O3 $< -o $@
