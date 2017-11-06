all: CountDistinct-Haskell CoinChange-Haskell CountDistinct.class CoinChange-Rust Pagerank-Rust

CountDistinct-Haskell CoinChange-Haskell: %-Haskell: %.hs
	ghc --make -O2 $< -o $@

CountDistinct.class: CountDistinct.java
	javac $<

CoinChange-Rust Pagerank-Rust: %-Rust: %.rs
	rustc -g -O $< -o $@
