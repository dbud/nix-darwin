# Report the newest published release branch for each pinned flake input, and
# whether it is newer than the pin in flake.nix.
#
# Usage: nix-releases [path/to/flake.nix]

set -u

flake="${1:-$HOME/.config/nix-darwin/flake.nix}"

if [ ! -r "$flake" ]; then
  printf 'cannot read %s\n' "$flake" >&2
  exit 1
fi

report() {
  repo=$1
  glob=$2
  regex=$3

  current=$(grep -oE "$regex" "$flake" | head -n 1)
  newest=$(
    git ls-remote --heads "https://github.com/$repo" "refs/heads/$glob" |
      sed 's|.*refs/heads/||' |
      sort -V |
      tail -n 1
  )

  name=${repo##*/}
  if [ -z "$current" ]; then
    printf '%-14s no pin found\n' "$name"
  elif [ "$current" = "$newest" ]; then
    printf '%-14s %s (up to date)\n' "$name" "$current"
  else
    printf '%-14s %s -> %s (new release)\n' "$name" "$current" "$newest"
  fi
}

report NixOS/nixpkgs 'nixpkgs-*-darwin' 'nixpkgs-[0-9][0-9.]*-darwin'
report nix-darwin/nix-darwin 'nix-darwin-*' 'nix-darwin-[0-9][0-9.]*'
report nix-community/home-manager 'release-*' 'release-[0-9][0-9.]*'
