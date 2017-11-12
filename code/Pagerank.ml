open Printf
open Scanf

let id x = x
let read_int () = scanf "%d " id

let epsilon = 1e-9

let read_input () =
  let n = read_int () in
  let m = Array.make_matrix (n + 1) (n + 1) 0.0 in
  for i = 0 to n do m.(i).(0) <- 1.0 done;
  for i = 1 to n do m.(0).(i) <- 1.0 done;
  for i = 1 to n do begin
    let rec loop = function
      | 0 -> ()
      | j -> m.(i).(j) <- m.(i).(j) +. 1.0; loop (read_int ()) in
    loop (read_int ())
  end done;
  m

let normalize m =
  let n = Array.length m in
  let norm_row xs =
    let sum = Array.fold_left (+.) 0.0 xs in
    for i = 0 to n - 1 do xs.(i) <- xs.(i) /. sum done in
  Array.iter norm_row m

let solve m =
  let n = Array.length m in
  let rec loop now nxt =
    for i = 0 to n - 1 do nxt.(i) <- 0.0 done;
    for i = 0 to n - 1 do for j = 0 to n - 1 do
      nxt.(j) <- nxt.(j) +. now.(i) *. m.(i).(j)
    done done;
    let error = ref 0.0 in
    for i = 0 to n - 1 do
      error := max !error (abs_float (now.(i) -. nxt.(i)))
    done;
    if !error > epsilon then loop nxt now else nxt in
  loop (Array.make n 1.0) (Array.make n 0.0)

let () =
  let m = read_input () in
  normalize m;
  let ranks = solve m in
  Array.iter (printf "%.9f\n") ranks
