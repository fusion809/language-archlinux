# The Arch Linux Development Package [![build-status](https://travis-ci.org/fusion809/language-archlinux.svg?branch=master)](https://travis-ci.org/fusion809/language-archlinux)

<img src="http://i.imgur.com/B5McvKv.png" alt="visual-studio-code-oss PKGBUILD">
  <caption><b>Figure 1: My visual-studio-code-oss PKGBUILD being syntax-highlighted by this package and language-unix-shell and with the dark-bint-syntax theme enabled.</b></caption>
</img><br/>

This package is essentially the Arch Linux equivalent to the [`language-gentoo`](https://github.com/aegypius/language-gentoo) package of Nicolas Laurent. It provides Atom commands for running a variety of different PKGBUILD commands. It previously provided syntax-highlighting for PKGBUILDs (with the help of the [`language-unix-shell`](https://github.com/fusion809/language-shellscript) package) although as of v0.3.0 this feature is now entirely provided by `language-unix-shell`.

## Dependencies
Beware that you will need to have the following Linux packages installed in order for this package to have its full functionalities:

* `namcap`
* `pacman` &mdash; which, of course, means you should be operating on Arch Linux or another platform that uses the pacman package manager.
* `pkgbuild-introspection`

It also requires the `language-unix-shell` package to be installed, if you have only the [`language-shellscript`](https://github.com/atom/language-shellscript) package installed (which comes bundled with Atom) you may find some of its syntax-highlighting features will be missing. I would also recommend you install the [`dark-bint-syntax`](https://github.com/Murriouz/dark-bint-syntax) theme, as it complements its syntax-highlighting.

## Installation
To install all the Linux dependencies of this package (i.e., those installed using your Linux package manager, which should be pacman), along with its Atom dependencies/optional dependencies run (as standard non-root user):

```bash
sudo pacman -S namcap pkgbuild-introspection --noconfirm
apm install language-unix-shell language-archlinux dark-bint-syntax --no-confirm
```

this is assuming, of course, that Atom is already installed. `language-unix-shell` does conflict with the core package, `language-shellscript`, so to use it I recommend adding:

```coffee
    disabledPackages: [
    "language-shellscript"
    ]
```

to your `config.cson` file. If you do not already have Atom installed on your Arch Linux machine, you can install Atom, these pacman dependencies and these packages via running (assuming, of course, that `yaourt` is installed):

```bash
yaourt -S atom-editor-arch --noconfirm
```

## Commands
This package provides the following Atom commands:

* `pkgbuild:makepkg` (default keyboard shortcut: <kbd>F5</kbd>) &mdash; builds a package using the PKGBUILD presently opened. If dependencies (including build dependencies) are missing it will fail, as it does not have the necessary root permissions to install missing dependencies.
* `pkgbuild:mksrcinfo` (shortcut: <kbd>F6</kbd>) &mdash; generates a .SRCINFO file from the presently-opened PKGBUILD.
* `pkgbuild:namcap` (shortcut: <kbd>F7</kbd>) &mdash; runs `namcap` on the PKGBUILD (*not* on any built packages) to check for any errors.
* `pkgbuild:newpkg` (shortcut: <kbd>F8</kbd>) &mdash; runs `git clone ssh+git://aur@aur.archlinux.org/<PACKAGE> <DIRECTORY>/<PACKAGE>` where `<DIRECTORY>` is the current working directory and `<PACKAGE>` is an input provided by the user in the command pallette box that pops up.
* `pkgbuild:updpkgsums` (shortcut: <kbd>F9</kbd>) &mdash; runs `updpkgsums` on the PKGBUILD to update checksums listed in it.
