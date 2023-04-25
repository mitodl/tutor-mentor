# tutor-mentor
A collection of scripts and configuration for tutor.

## Prerequisites

- [`direnv`](https://direnv.net/)
- [`tutor`](https://docs.tutor.overhang.io/)

## Usage

- Clone this repository alongside your other cloned projects.
- Run `./install.sh` to install `direnv` hooks into your projects.
  - If `systemd` is detected, the script will optionally install a service to run `tutor-ip-watch` automatically.
- Run tutor (e.g. `tutor local start`).
- If not using `systemd` (non-Linux OSes), you should manually run `tutor-ip-watch` after starting `tutor`.