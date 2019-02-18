open Printf
open Scanf

let read_int () = scanf "%d " (fun x -> x)
let epsilon = 1e-6

let read_input () =
  let n = read_int () in
  let read_line () =
    let rec f xs =
      let x = read_int () in
      if x == 0 then (x :: xs) else f (x :: xs) in
    f [] in
  let rec read_matrix acc = function
    | 0 -> List.rev acc
    | n -> read_matrix (read_line () :: acc) (n - 1) in
  let range a b =
    let rec f xs b = if a <= b then f (b :: xs) (b - 1) else xs in
    f [] (b - 1) in
  read_matrix [range 0 (n + 1)] n

let solve graph =
  let n = List.length graph in
  let rec loop now nxt =
    for i = 0 to n - 1 do nxt.(i) <- 0.0 done;
    let page i xs =
      let z = float_of_int (List.length xs) in
      let link j = nxt.(j) <- nxt.(j) +. now.(i) /. z in
      List.iter link xs in
    List.iteri page graph;
    let error = ref 0.0 in
    for i = 0 to n - 1 do
      error := max !error (abs_float (now.(i) -. nxt.(i)))
    done;
    if !error > epsilon then loop nxt now else nxt in
  loop (Array.make n (1.0 /. float_of_int n)) (Array.make n 0.0)

let () =
  let ranks = read_input () |> solve in
  Array.iter (printf "%.6f\n") ranks
