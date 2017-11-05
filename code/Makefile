all: CountDistinct-Haskell CoinChange-Haskell CountDistinct.class CoinChange-Rust

CountDistinct-Haskell CoinChange-Haskell: %-Haskell: %.hs
	ghc --make -O2 $< -o $@

CountDistinct.class: CountDistinct.java
	javac $<

CoinChange-Rust: %-Rust: %.rs
	rustc -g -O $< -o $@
