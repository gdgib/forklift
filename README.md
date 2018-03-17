# Forklift

A general purpose pallet (package) manager suitable for multi-language development.

Forklift, like npm or maven, can import and cache [pallets](#glossary) from various warehouses.
In addition to the [forklift standard](#standard), the basic implementation is in bash, making it suitable for use with any development tooling or languages.
One common use case is to abstract out common code from BASH scripts.

# Usage

* Run a command from a pallet: `forklift run <warehouse> <pallet> <version> <command-with-arguments>`

## Example 1

To run [BATS](https://github.com/sstephenson/bats) on `tests.bats` one might run:

```
forklift run com.github sstephenson/bats v0.4.0 bin/bats tests.bats
```

This will import the [`sstephenson/bats`](https://github.com/sstephenson/bats) pallet from github if it has not already been imported.
Then it will run the `bin/bats` script in that pallet with the aruments `tests.bats`. 
Note that version `v0.4.0` is the latest [release](https://github.com/sstephenson/bats/releases) at the time of this writing.

## Example 2

To get the OS distribution forklift is running on:

```
forklift run builtin common current osinfo --distro
```

This example shows the use of the `builtin` warehouse which references pallets in in the [builtin](builtin) directory.
Note that the only version supported by the `builtin` warehouse is `current` denoting whatever version the currently running forklift install is.
If you want to run a script from another version of forklift you can do so through the `com.github` warehouse, of course.

# Pallet Specifications

Each pallet is identified by a combination of a warehouse identifier, pallet identifier and version.
The warehouse identifier must be a reversed DNS name (e.g. `com.g2forge`) matching the server hosting the warehouse.
The warehouse is then used to select a jack, which can import pallets from that warehouse.
The format of the pallet identifier and version depend on the jack (warehouse), but POSIX paths and [semantic versions](https://semver.org/) are common.

Currently supported warehouses (jacks):

* `com.github`: the pallet identifier must be of the form `<organization-or-user>/<repository>` and the version must be `<branch-or-tag-or-commit>`
* `builtin`: used to run scripts from within forklift itself, critically helpful for bootstraping forklift

# Glossary

* "forklift" A program for moving pallets of files around a network.
* "pallet": A group of files "exported" from a "warehouse".
* "export": A declaration that a specific "warehouse" is able to provide a "pallet" of files to a "customer".
* "import": A request by a "customer" to "import" a "pallet" of files.
* "customer": An "importer" of "pallets"
* "warehouse": An "exporter" of "pallets"
* "jack": A small program, a plugin to forklift, which is used to move "pallets" from a "warehouse" to a "customer"

# Legal

Copyright Greg Gibeling 2018, licensed under the [Apache 2.0](LICENSE) license.

# Standard

Coming soon...

# Contributing

Issues and pull requests are welcome on [github.com/g2forge/forklift](https://github.com/g2forge/forklift).

## Release

1. Update the [`pom.xml`](pom.xml) version.
2. Tag the release: `git tag -m <TAG> <TAG>` where `<TAG>` is of the form "v0.0.1"