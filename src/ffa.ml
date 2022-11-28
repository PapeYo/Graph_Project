open Graph

type path = id list

let rec find_path gr forbidden s t =

  let rec out_arcs_iter = function
    | [] -> None
    | (id3, label)::rest ->
      (if (not (List.mem id3 forbidden)) 
        then (match (find_path gr [s] id3 t) with
          | None -> out_arcs_iter rest
          | Some l -> Some (s::l))
        else out_arcs_iter rest)
  in

  if s=t 
    then Some (List.append forbidden [s])
    else (out_arcs_iter (out_arcs gr s))