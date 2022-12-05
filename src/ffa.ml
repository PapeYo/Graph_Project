open Graph

type path = id list

let rec find_path gr forbidden s t =

  let rec out_arcs_iter = function
    | [] -> []
    | (id3, label)::rest -> 
      if (not (List.mem id3 forbidden)) then
        match find_path gr (List.append forbidden [s]) id3 t with
          | [] -> out_arcs_iter rest
          | path -> List.append [s] path
      else out_arcs_iter rest
  in
  if s = t
    then [s]
    else out_arcs_iter (out_arcs gr s)

let find_max_acceptable_flow gr path =
  let rec loop gr path aux =
    match path with
    | [] -> 0
    | [t] -> 0
    | id1::id2::rest -> 
      (match find_arc gr id1 id2 with
        | None -> 0
        | Some flow -> loop gr (id2::rest) (min aux flow))
  in
  loop gr path max_int
