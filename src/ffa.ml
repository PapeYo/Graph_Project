open Graph
open Tools

type path = id list

let rec find_path gr forbidden s t =
  let rec out_arcs_iter = function
  | [] -> []
  | (id3, label)::rest ->  if ((not (List.mem id3 forbidden)) && label > 0) 
    then (match find_path gr (List.append forbidden [s]) id3 t with
  | [] -> out_arcs_iter rest
  | path -> List.append [s] path)
else out_arcs_iter rest
in
  if s = t
  then [s] else out_arcs_iter (out_arcs gr s)


let find_max_acceptable_flow gr path =
  let rec loop gr path aux = match path with
  | [] -> aux
  | id1::[] -> aux
  | id1::id2::rest ->
    (match find_arc gr id1 id2 with
    | None -> aux
    | Some flow ->
      (match rest with
      | id3::_ -> loop gr (id2::rest) (flow::aux)
      | [] -> (flow::aux))
    )
  in
  match loop gr path [] with
  | [] -> 0
  | list -> List.hd (List.sort compare list)


let rec update_residual_graph gr path flow =
  match path with
  | [] -> gr
  | id1::[] -> gr
  | id1::id2::rest -> update_residual_graph (add_arc (add_arc gr id1 id2 (-flow)) id2 id1 flow) (id2::rest) flow


let rec ffalgo gr s t =
  match find_path gr [] s t with
  | [] -> gr
  | path1 ->
    List.iter (Printf.printf "%d ") path1;
    Printf.printf "\n";
    let flow1 = find_max_acceptable_flow gr path1 in
    let gr1 = update_residual_graph gr path1 flow1 in
    ffalgo gr1 s t
  ;;



let the_string_graph init_graph ff_graph = 

  let create_arcs init_graph id1 id2 flow =
    match find_arc init_graph id2 id1 with 
    | Some(capacity) -> new_arc (init_graph) (id2) (id1) (flow ^ "/" ^ capacity)
    | None -> init_graph
  in

  let zero_arcs final_graph id1 id2 capacity =
    if String.contains_from capacity 0 '/' then final_graph
    else new_arc (final_graph) (id1) (id2) ("0/" ^ capacity)
  in

  let string_ff_graph = (gmap ff_graph string_of_int) in 
  let final_graph = e_fold string_ff_graph create_arcs (gmap init_graph string_of_int) in
  e_fold final_graph zero_arcs final_graph
