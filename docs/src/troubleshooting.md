# Troubleshooting

This page collects some possible errors you may encounter and trick how to fix them.

*If you have additional tips, please submit a PR with suggestions.*

## Installation problems

### Cannot find the Julia executable

Make sure you have Julia installed in your environment. Please download the latest
[stable Julia](https://julialang.org/downloads/) for your platform.
If you are using macOS, the recommended way is to use [Homebrew](https://brew.sh).
If you do not want to install Homebrew or you are using other *nix that Julia supports,
download the corresponding binaries. And then create a symbolic link `/usr/local/bin/julia`
to the Julia executable. If `/usr/local/bin/` is not in your `$PATH`, modify your
`.bashrc` or `.zshrc` and export it to your `$PATH`.
Some clusters, like `Habanero`, `Comet` already have Julia installed as a module, you may
just `module load julia` to use it. If not, either install by yourself or contact your
administrator.

## Loading settings

### Error parsing `YAML` files

If you encounter

```
ERROR: expected '<document start>' but found YAML.BlockMappingStartToken at nothing
```

or

```
ERROR: while scanning a simple key at line n, column 0: could not find expected ':' at line n+1, column 0
```

Check whether you have no space between the `YAML` key and its value like
`key:1` or `key:some text`, etc. To correct, change to `key: 1`, `key: some text`, etc.
Otherwise check other `YAML` syntax you may have broken.
