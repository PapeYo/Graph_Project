open Gfile
open Tools
open Ffa
    
let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf
        "\n ✻  Usage: %s infile source sink outfile\n\n%s%!" Sys.argv.(0)
        ("    🟄  infile  : input file containing a graph\n" ^
         "    🟄  source  : identifier of the source vertex (used by the ford-fulkerson algorithm)\n" ^
         "    🟄  sink    : identifier of the sink vertex (ditto)\n" ^
         "    🟄  outfile : output file in which the result should be written.\n\n") ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)
  
  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)
  
  (* These command-line arguments are not used for the moment. *)
  and _source = int_of_string Sys.argv.(2)
  and _sink = int_of_string Sys.argv.(3)
  in

  (* Open file *)
  let graph = from_file infile in

  let gr1 = gmap graph (fun x -> int_of_string x) in
  (* Rewrite the graph that has been read. *)
  let () = 
    export outfile graph;
  in

  let print_path gr s t =
    match find_path gr [] s t with
      | [] -> Printf.printf "Pas de chemin allant de %d à %d \n" s t
      | l ->
        List.iter (Printf.printf "%d ") l;
        Printf.printf "\n";
  in

  ();
  Printf.printf("Chemin de 12 à 12 : ");
  print_path gr1 12 12;
  Printf.printf("Chemin de 12 à 4 : ");
  print_path gr1 12 4;
  Printf.printf("Chemin de 1 à 2 : ");
  print_path gr1 1 2;
  Printf.printf("Chemin de 1 à 10 : ");
  print_path gr1 1 10;
  Printf.printf("Chemin de 0 à 12 : ");
  print_path gr1 0 12;
  Printf.printf("Chemin de 1 à 7 : ");
  print_path gr1 1 7;
  Printf.printf "Max flow acceptable entre %d et %d : %d \n" 5 12 (find_max_acceptable_flow gr1 (find_path gr1 [] 5 12));
