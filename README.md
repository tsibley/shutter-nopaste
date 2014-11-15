![image](https://raw.githubusercontent.com/tsibley/shutter-nopaste/master/screenshot.png)

# Installation

    curl https://raw.githubusercontent.com/tsibley/shutter-nopaste/master/Nopaste.pm \
        sudo tee /usr/share/shutter/resources/system/upload_plugins/upload/Nopaste.pm > /dev/null

If Shutter isn't using your system perl (`/usr/bin/perl`), you need to
adjust the first line of `Nopaste.pm` to match the output of:

    head -n1 `which shutter`

App::Nopaste must already be installed to your system perl, or whichever
perl Shutter uses.

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
