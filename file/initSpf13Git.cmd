@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

@set APP_PATH=%HOME%\.spf13-vim-3
IF NOT EXIST "%APP_PATH%" (
    REM call git clone -b 3.0 https://github.com/spf13/spf13-vim.git "%APP_PATH%"
    call git clone -b 3.0 https://github.com/ss707494/spf13-vim.git "%APP_PATH%"
) ELSE (
    @set ORIGINAL_DIR=%CD%
    echo updating spf13-vim
    chdir /d "%APP_PATH%"
    call git pull
    chdir /d "%ORIGINAL_DIR%"
    call cd "%APP_PATH%"
)

call mklink "%HOME%\.ideavimrc" "%HOME%\.spf13-vim-3\file\.ideavimrc"

