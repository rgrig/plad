let opt_map f = function
  | None -> None
  | Some x -> Some (f x)

let mmin a b = match a, b with
  | None, x | x, None -> x
  | Some x, Some y -> Some (min x y)

let solve value denominations =
  let cache = Hashtbl.create 1 in
  let ds = Array.of_list denominations in
  let rec go i j =
    try Hashtbl.find cache (i, j)
    with Not_found -> begin
      let r =
        if i = 0 then Some 0
        else if i < 0 then None
        else if j = 0 then None
        else mmin (go i (j - 1)) (opt_map ((+)1) (go (i - ds.(j-1)) j)) in
      Hashtbl.add cache (i, j) r; r
    end in
  go value (List.length denominations)

let read_int () =
  Scanf.scanf "%d " (fun x -> x)

let rec read_all_ints () =
  try let n = read_int () in n :: read_all_ints() with End_of_file -> []

let () =
  let value = read_int () in
  let denominations = read_all_ints () in
  (match solve value denominations with
  | None -> Printf.printf "impossible\n"
  | Some x -> Printf.printf "%d\n" x)
