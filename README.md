# tmux-bitwarden

## Requirements
You need to have:
* [fzf](https://github.com/junegunn/fzf)
* bash > 4.0

## Install

### Tmux Plugin Manager (recommended)
1. In your `.tmux.conf` add the plugin to the list.
```
set -g @plugin 'aanzolaavila/tmux-switcher'
```
2. Type `prefix + I` to install the plugin.

## Key bindings
* `prefix + b`: list login items in a bottom pane.

## Usage
First, log into your Bitwarden user account using the `login` command (you only need to do this once):
```bash
$ bw login your-email@domain.com
? Master password: [input is hidden]
To unlock your vault, set your session key to the `BW_SESSION` environment variable. ex:
$ export BW_SESSION="lpvf7Rt+pAMXW2YJ5O42jJp6ZY0Ny01vq9jaUdFYbroS1CXWgjVdy7j42owHVoLwZf+yDI+ro68Qngo9mdD/vA=="
> $env:BW_SESSION="lpvf7Rt+pAMXW2YJ5O42jJp6ZY0Ny01vq9jaUdFYbroS1CXWgjVdy7j42owHVoLwZf+yDI+ro68Qngo9mdD/vA=="
```

In a tmux session, you can run the plugin with the default key binding `prefix + b`. This opens a new pane at the bottom with login items. You can choose your login item with `<Enter>`, your password will be automatically filled.

If you have not configured your bitwarden session (`BW_SESSION`), you will be prompted to re-enter your master password before each selection (see configuration section for more information)

## Configuration

### Changing the default key-binding
```
set -g @bw-key 'T'
```
Default: `u`
