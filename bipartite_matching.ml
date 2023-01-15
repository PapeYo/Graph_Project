open Graph
open Tools
open ffa


let prepare_source graph = new_node graph -1 
let prepare_sink graph = new_node graph -2

let init_graph graph =
  (s_id, sink_id, n_fold prepare_sink (prepare_source graph))


;;

let bipartite_matching graph s t=
  let bpm_graph = the_string_graph graph (ffalgo graph s t)
  let the_graph = e_fold bipartite_matching let mbp graph = 
    let (source, sink, graph) = add_source_and_sink (clean_graph graph) in
    let mbp_graph = get_final_string_graph graph (fordfulkerson graph source sink) in
  
    let final_graph = clone_nodes_without [source ; sink] mbp_graph in
    let final_graph = e_fold mbp_graph (fun gr id1 id2 lbl -> 
                        if id1 = source then gr 
                        else if id2 = sink then gr 
                        else if String.contains_from lbl 0 '0' then gr
                        else new_arc gr id1 id2 "\"\"") final_graph in
  
    let mbp_val = n_fold final_graph (fun mbp id -> mbp + 1) 0 in
    (final_graph, mbp_val)