let () =
  let a, b = Scanf.scanf "%d %d" (fun a b -> (a, b)) in
  Printf.printf "%d\n" (a + b)
