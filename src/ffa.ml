open Graph
open Tools

type path = id list
  
(* find a path going from s to t in a graph *)
let rec find_path gr forbidden s t =
  let rec out_arcs_iter = function
  | [] -> []
  | (id3, label)::rest ->  if (not (List.mem id3 forbidden)) 
    then (match find_path gr (List.append forbidden [s]) id3 t with
  | [] -> out_arcs_iter rest
  | path -> List.append [s] path)
else out_arcs_iter rest
in
  if s = t
  then [s] else out_arcs_iter (out_arcs gr s)

(* find the maximum acceptable flow on a given path*)
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
  | [] -> (flow::aux)))
in
  match loop gr path [] with
  | [] -> 0
  | list -> List.hd (List.sort compare list)

(* update a graph by adding the max acceptable flow on a given path *)
let rec update_residual_graph gr path flow =
  match path with
  | [] -> gr
  | id1::[] -> gr
  | id1::id2::rest -> update_residual_graph (add_arc gr id1 id2 flow) (id2::rest) flow

  (* Ford-Fulkerson Algorithm*)
let ffalgo gr s t =
  let gr1 = clone_nodes gr in
  let path1 = find_path gr [] s t in
  let flow1 = find_max_acceptable_flow gr path1 in
  update_residual_graph gr1 path1 flow1