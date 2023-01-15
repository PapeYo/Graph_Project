open Graph

let clone_nodes (gr: 'a graph) = n_fold gr new_node empty_graph

let gmap gr f = e_fold gr (fun gr id1 id2 arc -> new_arc gr id1 id2 (f arc)) (clone_nodes gr)

let add_arc gr id1 id2 n = match find_arc gr id1 id2 with
  | None -> new_arc gr id1 id2 n
  | Some x -> new_arc gr id1 id2 (n + x)
