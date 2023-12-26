# 🪐 Nix!

My collection of configurations, dotfiles, and other files used for setting up my Arch Linux environment on a new PC.

## Usage

This is meant to be used as a bare git repo in `$HOME`. An alias can be added to the `.[bash|zsh]rc` file for convenience:

```sh
alias config='/usr/bin/git --git-dir=$HOME/.local/nix/ --work-tree=$HOME'
```

Any changes to the dotfiles can be tracked by git from anywhere by replacing `git` with `config`, for example: `config status`. To apply this repo to `$HOME`, run:

```sh
git clone --bare <this repo> $HOME/.nix
config config --local status.showUntrackedFiles no
config checkout
```

The second command is used to not show all files in your `$HOME` dir every time you check `config status`.
