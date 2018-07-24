# Node Version Switcher

Lighter, faster and cross-platform alternative to nvm.


## Features

`nvs` is a simple tool that does only the following things:

- downloads `nodejs` binaries, based on full or partial version numbers
- manages downloaded `nodejs` versions
- activates selected `nodejs` version for current terminal
- manages default `nodejs` version, used for new terminal sessions


## Installation

Supported platforms: Linux, macOS, Windows (with some type of bash installed, like git bash etc.).

1. Clone this repository

    ```
    git clone https://github.com/pawelt/nvs.git ~/nvs
    ```

2. Setup `nvs` startup script

    Add these two lines to your `~/.bashrc`:

    ```
    export NVS_DIR=~/nvs
    [ -s $NVS_DIR/nvs.sh ] && source $NVS_DIR/nvs.sh
    ```

    **NOTE:** If you're using `git bash`, you can put the above snippet in: `C:\Program Files\Git\etc\profile.d\aliases.sh`

3. Start new shell, install and activate the latest node

    ```
    nvs-i && nvs-use && nvs-default-set
    ```

    That's it! Run `nvs-h` for complete list of commands.

    **NOTE:** Withouth an argument, `nvs-i` installs the latest available version of node.
    To install other version, for ex.: most recent `8.x.x` version, run this instead:

    ```
    nvsi 8 && nvs-use && nvs-default-save
    ```


## Optional step 1: Windows `cmd.exe` ".bashrc"  autorun

If you want to have `nvs` available in the standard Windows `cmd.exe` shell:

1. Create `%USERPROFILE%\cmdrc.cmd` file with the following content:

    ```
    set NVS_DIR=%USERPROFILE%\nvs
    if exist %NVS_DIR%\nvs.cmd call %NVS_DIR%\nvs.cmd
    ```

2. Run this command to add it to autorun:

    ```
    REG add "HKCU\Software\Microsoft\Command Processor" /v "AutoRun" /d "%USERPROFILE%\cmdrc.cmd" /f
    ```

    or just use the `nvsrc.cmd` file that comes with `nvs`:

    ```
    REG add "HKCU\Software\Microsoft\Command Processor" /v "AutoRun" /d "%USERPROFILE%\nvs\nvsrc.cmd" /f
    ```


## Optional step 2: Custom `bash.exe` location on windows

To override default `bash.exe` location: `C:\Program Files\Git\bin\bash.exe`

1. Create `nvs-bash-exe.txt` file in the `nvs` folder
2. Paste full `bash.exe` path there, ex.: `D:\Git\bin\bash.exe`

## Help screen

To print this help screen run `nvs-h`.

    ```
    Commands:
        nvs                 print version info and short help
        nvs-h               print full help screen

        nvs-use [v]         activate the newest installed version matching the filter

        nvs-ls [v]          list installed node versions with optional filter
        nvs-ls-one [v]      same as nvs-ls, but prints only the first version found

        nvs-find [v]        list available node versions with optional filter
        nvs-find-one [v]    same as nvs-find, but prints only the first version found

        nvs-i [v]           installs the newest version matching the filter

        nvs-default-get     print currently set default version
        nvs-default-set     save currently active version as default

    Filters:
        All [v] filters are partial or full versions, ex.:  8  9.1  10.7.0
        Empty [v] filter means 'match all versions'

    Install and configure the latest version of node:
        nvs-i && nvs-use && nvs-default-set

    To uninstall a version simply remove its directory from $NVS_DIR/v
    ```

## How it works

For all supported platforms `nodejs` versions are changed by manipulating system `PATH` environment variable. No magic, no symlinks swapping or files copying.


Because version changing requires simple string replacement and settinv an env variable, the process is very fast, compared to `nvm`.
