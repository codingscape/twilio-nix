# Twilio Development Nix Expressions

This is a fully pinned, reproducible development environment and package set for
Twilio projects, based on the
[Nix purely functional package manager](https://nixos.org/). It uses
[lorri](https://github.com/target/lorri) to automatically build a full set of
Twilio's standard development tools on-demand in the background, and places
them fully configured on your `$PATH` while you are in a project directory. It
also has a mechanism to automatically expose `npm install`ed packages on `$PATH`.

## Quick Install

- Clone this repo to wherever you want your Twilio projects to live.
- (_macOS_) Install the Nix package manager, if needed, with:

```bash
sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume --daemon
```

- (_macOS, optional but recommended_) Install [nix-darwin](https://github.com/LnL7/nix-darwin)

- (_Linux_) Install the Nix package manager, if needed, with:

```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```

- (_NixOS or nix-darwin_) Import the `twilio-nix` module into your
  `configuration.nix` or `darwin-configuration.nix` with:

  ```nix
  {
  imports = [
    # [... your other imports here]

    /path/to/twilio-nix/module.nix
  ];
  }
  ```

- (_plain Linux or macOS_) [Install lorri and direnv](https://github.com/target/lorri#setup-on-other-platforms).
- (_Optional_) Create a `~/.config/git/ignore` file with these contents:

```git-config
.envrc
shell.nix
.log/
```

This will automatically ignore the files `twilio-nix` requires in project root
directories.

## Usage

- Dependencies are built automatically by Nix and `lorri`, either by your shell
  or by your editor with the appropriate plugin, as soon as a `twilio-nix`
  subdirectory is entered.
- Clone or create your projects in the `projects` subdirectory of `twilio-nix`.
- Create a `shell.nix` file in the project directory with these contents:

```nix
import ../../shell.nix { }
```

If you need extra packages in that project (such as linters and formatters used
by your editor, development tools, or any other command line utility), use `nix search` to find their package name, then pass them as `extraPkgs` to
`shell.nix`:

```nix
import ../../shell.nix { extraPkgs = [
                           # [ list of packages ]
                         ]; }
```

- Copy `.envrc` from the `twilio-nix` root directory, then run `direnv allow`.
- Wait for Nix to finish building all of your project's dependencies in the
  background. `direnv` in your shell may alert you when a build is done (press
  enter to call up a new prompt to refresh), or you can check `lorri`'s logs for
  a status update (available at `/var/tmp/lorri.log` if you are using
  twilio-nix's `module.nix`).
- If you type `npm install` in this environment, all of the binaries installed
  as part of your current project will be on your `$PATH` as long as you're
  inside the project directory.
- Ad-hoc Node dependencies that don't need project scope can be installed into
  the `twilio-nix` root `project.json`.
- Development environments are fully isolated from each other by path (with the
  presence of a `.envrc` and `shell.nix` determining where a new environment
  starts), so multiple projects can have completely independent sets of
  dependencies, even if those dependencies would otherwise conflict.
- Nix will automatically rebuild changed parts of the development environment;
  that is, anything listed in `shell.nix`.

## Bugs

- On macOS, `lorri` may occasionally ignore changed files. `pkill lorri` in a
  terminal will cause it to restart (if started as a `launchd` service) and
  respond to changed files again.
