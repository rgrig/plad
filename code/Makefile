all: CountDistinct-Haskell CoinChange-Haskell CountDistinct.class

CountDistinct-Haskell CoinChange-Haskell: %-Haskell: %.hs
	ghc --make -O2 $< -o $@

CountDistinct.class: CountDistinct.java
	javac $<
