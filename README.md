Ocaml project : Ford-Kulkerson algorithm by 'Yohan JARNAC and Valentin GUITTARD'

A makefile provides some useful commands:
 - `make build` to compile. This creates an ftest.native executable
 - `make demo` to run the `ftest` program with some arguments
 - `make format` to indent the entire project
 - `make edit` to open the project in VSCode
 - `make clean` to remove build artifacts

In case of trouble with the VSCode extension (e.g. the project does not build, there are strange mistakes), a common workaround is to (1) close vscode, (2) `make clean`, (3) `make build` and (4) reopen vscode (`make edit`).


To change the initial graph file, the source node and/or the sink node, please open the Makefile.
the fourth part of it is the **demo** section.
Its third line is './ftest.native *path/to/graph_file* *id_source_node* *id_sink_node* *name_of_output_file*'.
The four parameters are what you might modify.