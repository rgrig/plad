---
title: coin-change
breaks: false
slideOptions:
  transition: slide
---

> When I go outside at night and look up at the stars, the feeling that I get is not comfort.
> The feeling that I get is a kind of delicious discomfort at knowing that there is so much out there that I do not understand and the joy in recognizing that there is enormous mystery, which is not a comfortable thing.
> This, I think, is the principal gift of education.

Teller

---

# Coin Change

Given a sum $n$, and given denominations $d_1,\ldots,d_m$, find the smallest number of coins necessary to pay the sum.

---

## Trick 1


Let $c_{i,j}$ be the minimum number of coins necessary to pay sum $j$ by using the first $i$ denominations, namely $d_1,\ldots,d_i$.

<span>
<!-- .element: class="fragment" data-fragment-index="1" -->

$$
c_{i,j} = \min\{1+c_{i,j-d_i}, c_{i-1,j}\}
$$
</span>

---

## Trick 2

Cache the values of $c_{i,j}$ in a (bidimensional) array.

<span>
<!-- .element: class="fragment" data-fragment-index="1" -->

That's it!
</span>

---

## Complexity

What's the runtime in terms of the sum $n$ and the number $m$ of denominations?

<span>
<!-- .element: class="fragment" data-fragment-index="1" -->

$$
O(mn)
$$
</span>

---

## Question

Why does greedy not work?

---

###### tags: `plad`

