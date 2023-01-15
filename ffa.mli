open Graph

(* A path is a list of nodes. *)
type path = id list

(* find_path gr forbidden id1 id2 
 *   returns None if no path can be found.
 *   returns Some p if a path p from id1 to id2 has been found. 
 *
 *  forbidden is a list of forbidden nodes (they have already been visited)
 *)
val find_path: int graph -> id list -> id -> id -> path

(* find the maximum acceptable flow on a given path *)
val find_max_acceptable_flow: int graph -> path -> int

(* update a graph by adding the max acceptable flow on a given path *)
val update_residual_graph: int graph -> path -> int -> int graph

(* remove arcs having label = 0 from a graph *)
(* val remove_zero_label: int graph -> int graph *)

(* Ford-Fulkerson Algorithm *)
val ffalgo: int graph -> id -> id -> int graph

(* transforms the graph in a string graph that removes zeros*)
val the_string_graph: int graph -> int graph -> string graph
