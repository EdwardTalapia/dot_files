# dot_files
This is the customization that Edan likes to use on his personal computer

## What this repo covers
Run `./install.sh` on the new machine to install Oh My Zsh, Starship, kitty, and
symlink: `.zshrc`, `.zshenv`, `.bashrc`, `.gitconfig`, `.tmux.conf`,
`starship.toml`, `kitty/kitty.conf` (neofetch's `config.conf` too).

`kitty/kitty.conf` is currently a placeholder — kitty was configured on a
different machine, so drop the real file in before running install.sh on
a new box.

## What this repo does NOT cover (transfer separately)
Plain rsync of `~/.config ~/.local/bin ~/.ssh ~/.bashrc ~/Documents ~/Scripts`
misses the following. Check these on any new-machine migration:

- **ROS 2 Humble** — not a file copy, reinstall via apt (`ros-humble-desktop`
  + the other `ros-humble-*`/`ros-dev-tools` packages; see `dpkg -l | grep ros-`
  on the old machine for the exact list). Workspaces need their own rsync:
  `~/ros2_ws`, `~/catkin`, `~/.ros`.
- **MATLAB** — lives at `~/EdanPrograms/MatLab` (~23GB). rsync it directly or
  reinstall via MathWorks installer; license may need reactivation on the new
  machine (see `~/.config/MathWorks`).
- **MY_ZSH_SCRIPTS** — cloned by install.sh from
  `git@github.com:EdwardTalapia/zsh-scripts.git`, but push any local changes
  first or they won't be on the remote.
- **SSH keys** — `~/.ssh` (id_ed25519, known_hosts) — copy by hand, not via git.
- **VS Code extensions** — not covered by config sync; on the old machine run
  `code --list-extensions > extensions.txt`, then on the new machine
  `cat extensions.txt | xargs -n1 code --install-extension`.
- **Docker** — reinstall (`docker.io`), images/volumes don't come along for free.
- **Snap apps** (Firefox, Todoist, etc.) — reinstall via `snap install <name>`.
- **Other app configs under `~/.config`** not managed here: Arduino IDE, GIMP,
  Cura, OrcaSlicer, Zoom, LibreOffice — copy `~/.config/<app>` by hand if you
  want those preserved, or just reinstall and reconfigure.
