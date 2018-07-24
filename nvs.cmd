@echo off

set NVS_V_DIR=%NVS_DIR%\v
if not exist %NVS_V_DIR% mkdir %NVS_V_DIR%

set NVS_DEFAULT_VER_CFG=%NVS_DIR%\nvs-default-ver.txt
if exist %NVS_DEFAULT_VER_CFG% set /p NVS_DEFAULT_VER=< %NVS_DEFAULT_VER_CFG%

set NVS_BASH_EXE=C:\Program Files\Git\bin\bash.exe
set NVS_BASH_EXE_CFG=%NVS_DIR%\nvs-bash-exe.txt
if exist %NVS_BASH_EXE_CFG% set /p NVS_BASH_EXE=< %NVS_BASH_EXE_CFG%
set NVS_BASH_EXE="%NVS_BASH_EXE%"

if "%NVS_ORIGINAL_PATH%" == "" set NVS_ORIGINAL_PATH=%PATH%

REM ============================================================================
REM cmd.exe-specific nvs use command
REM ============================================================================
doskey nvs-use=call %0 use $1

if not [%1] == [use] goto :skip_use
    set v=%NVS_DEFAULT_VER%
    if not [%2] == [d] set v=%2

    pushd %NVS_DIR%
        for /f %%a in ('%NVS_BASH_EXE% scripts/_nvs_local_ls_one.sh %v%') do set resolved_ver=%%a
        set resolved_path=%NVS_V_DIR%\%resolved_ver%
    popd

    if not exist %resolved_path%            goto :ver_not_found
    if [%resolved_path%] == [%NVS_V_DIR%\]  goto :ver_not_found
    goto :ver_found

    :ver_not_found
        echo Failed to resolve version '%v%'. List of installed versions:
        pushd %NVS_DIR%
            %NVS_BASH_EXE% scripts/_nvs_local_ls_all.sh
        popd
        goto :end

    :ver_found
        echo Switching to version '%resolved_ver%'...
        set PATH=%NVS_ORIGINAL_PATH%;%resolved_path%
        goto :end

:skip_use


REM ============================================================================
REM Cross-platform command aliases
REM ============================================================================
doskey nvs=call %0 info
doskey nvs-h=call %0 help

doskey nvs-ls=call %0 local_ls_all $1
doskey nvs-ls-one=call %0 local_ls_one $1

doskey nvs-find=call %0 remote_ls_all $1
doskey nvs-find-one=call %0 remote_ls_one $1

doskey nvs-i=call %0 install $1

doskey nvs-default-get=call %0 default_get
doskey nvs-default-set=call %0 default_set

for %%x in (info help local_ls_all local_ls_one remote_ls_all remote_ls_one install default_set default_get) do (
    if [%1] == [%%x] (
        pushd %NVS_DIR%
        %NVS_BASH_EXE% scripts/_nvs_%%x.sh %2
        popd
        goto :end
    )
)


REM ============================================================================
REM use default node version
REM ============================================================================
set PATH=%NVS_ORIGINAL_PATH%;%NVS_V_DIR%\%NVS_DEFAULT_VER%
if not exist %NVS_V_DIR%\%NVS_DEFAULT_VER% echo Node not found: %NVS_V_DIR%\%NVS_DEFAULT_VER%
:end
