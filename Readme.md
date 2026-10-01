## Unified Fedora Atomic Update Script

This is a simple bash script that automate the update of both the OS (rpm-ostree, flatpack), Toolboxes (dnf).

### Installation

- clone the GitHub project:

```
$ git clone https://www.githib.com/turgu1/fedora-atomic-update
```

- copy the script into .local/bin:

```
$ cp update-all.sh ~/.local/bin
$ chmod +x ~/.local/bin/update-all.sh
```

- if .local/bin is not in the PATH, add it:

```
$ echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
$ source ~/.bashrc
```

### Usage

- do the following:

```
$ update-all.sh
```