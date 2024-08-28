## Formatting

The recommended [installation](https://ocaml.org/docs/installing-ocaml) includes
the installation of `OCamlFormat`. But `OCamlFormat` requires a config file
`.ocamlformat` in the project, which contains the version number of OCaml being
used, and a code formatting style, e.g.

```
version = 0.26.2
profile = default
```

the other style options being `ocamlformat` or `janestreet`.

The OCamlFormat [docs](https://ocaml.org/p/ocamlformat/latest/doc/index.html) go
into more detail.

Generate the file with:

```bash
echo "version = `ocamlformat --version`" > .ocamlformat
```

Then format on save will work (if not, check it is included in VSCode settings).

The following specifies format on save for OCaml specifically.

```json
"[ocaml]": {
  "editor.formatOnSave": true
  }
```

## Compiling

Compile a `.ml` file into OCaml bytecode.

```bash
ocamlc -o program.byte program.ml
```

Three files are produced: `program.byte`, `program.cmo` and `program.cmi`.

Run the bytecode with:

```bash
./program.byte
```

### Compiling with the build system `Dune`

A Dune _project_ is a directory containing OCaml code which can be grouped into
sub-directories. Each sub-directory can contain a file named `dune` which
describes how code in that direcory should be compiled. The syntax of `dune`
files is documented
[here](https://dune.readthedocs.io/en/stable/dune-files.html).

You can manually create the directories and write the files to setup a dune
project, or do it automatically with:

```bash
dune init project example_project
```

Note dune doesn't add a `.ocamlformat` file at the project root, so it's
advisable to add one.

Build the project with `dune build` or use `dune build --watch` to setup
compile-on-save.

Run the main binary with `dune exec bin/main.exe`. Behind the scenes, dune finds
the binary in `_build/default/bin/main.exe`.

`dune clean` removes the `_build` directory.

`dune utop` will compile and launch in utop.

### Using "compilation units"

A `.mli` and a `.ml` file with the same filename, in the same directory, form a
compilation unit. E.g. `mystack.mli` and `mystack.ml` in this directory.

Putting the `mystack.ml` file into _utop_ will **not** read the `mystack.mli`
file, and the interface won't be applied to the definitions in `mystack.ml`. To
compile the compilation unit, a build command is required.

```bash
ocamlbuild mystack.cmo mystack.cmi
```

This will deposit the compiled files `mystack.cmo` and `mystack.cmi` into the
`_build` directory.

To load these compiled files into utop, use:

#**utop**

```utop
<!-- utop only looks for .cmo and .cmi in the current directory by default -->
#directory "_build";;

#load "mystack.cmo";;

<!-- Now the module has been "loaded", which is different to "use" and will not shadow other
definitions in utop. -->
let x = MyStack.empty;;

<!-- And the following will throw an error: "unbound value empty" -->
let error = empty;;
```

To save entering all these commands every time you launch utop, they can be
entered into a `.ocamlinit` file which will be run every time utop is started.
