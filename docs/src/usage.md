# Usage

## How to run commands

After installation, run in REPL

```shell
$ qe pw --help
```

to see allowed arguments and flags.

## How to write a config file

Configuration files can be written in three formats: TOML, JSON, and YAML.
For example, write a [TOML](https://toml.io/en/) file in the following format

```toml
[mpi]
np = 8

[pw]
exe = "/path/to/qe/bin/pw.x"
chdir = false

    [pw.options]
    nimage = 8
    nyfft = 8

[ph]
exe = "/path/to/qe/bin/ph.x"
chdir = false

    [ph.options]
    nimage = 8
    nyfft = 8
```

You can use [some format converters](https://www.convertsimple.com/convert-yaml-to-toml/)
to convert between these three formats. Or you can use the
[`AbInitioSoftwareBase.of_format`](https://mineralscloud.github.io/AbInitioSoftwareBase.jl/dev/api/AbInitioSoftwareBase/#AbInitioSoftwareBase.of_format)
function.
