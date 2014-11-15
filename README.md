![image](https://raw.githubusercontent.com/tsibley/shutter-nopaste/master/screenshot.png)

# Installation

    sudo make install

If Shutter's base directory isn't `/usr/share/shutter`, pass
`SHUTTER_ROOT=/path/to/shutter` as an argument to `make`.

App::Nopaste must already be installed to your system perl, or whichever
perl Shutter uses.  The install process will check for this.

# Configuration

You'll need to configure [App::Nopaste](https://metacpan.org/release/App-Nopaste) first to paste to a pastebin which accepts binary files.  I like to use my personal website + the SSH Nopaste plugin.  From my `~/.bashrc`, for example:

```sh
export NOPASTE_SERVICES=ssh
export NOPASTE_SSH_SERVER=tsibley.net
export NOPASTE_SSH_MODE=0644
export NOPASTE_SSH_DOCROOT=/home/tsibley/www/paste
export NOPASTE_SSH_WEBPATH=http://tsibley.net/paste
export NOPASTE_SSH_USE_DESCRIPTION=1
```
