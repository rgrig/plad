all: Lambda-OCaml CountDistinct-Haskell CoinChange-Haskell CountDistinct.class CoinChange-Rust Pagerank-Rust Pagerank-OCaml add-Haskell add-Rust

add-Haskell CountDistinct-Haskell CoinChange-Haskell: %-Haskell: %.hs
	ghc --make -O2 $< -o $@

CountDistinct.class: CountDistinct.java
	javac $<

CoinChange-Rust Pagerank-Rust: %-Rust: %.rs
	rustc -g -O $< -o $@

Lambda-OCaml Pagerank-OCaml: %-OCaml: %.ml
	ocamlfind opt -linkpkg -package ppx_deriving.std -g -O3 $< -o $@
