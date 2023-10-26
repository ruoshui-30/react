@echo off
chcp 65001
setlocal enabledelayedexpansion

set OUTPUT_FILE=output.txt

rem 清空输出文件
echo. > %OUTPUT_FILE%

rem 遍历每个子目录
for /D %%d in (*) do (
    rem 写入文件夹名称
    echo ### %%d >> %OUTPUT_FILE%
    echo. >> %OUTPUT_FILE%

    rem 按文件名从小到大遍历 .html 文件
    for /F "tokens=*" %%f in ('dir /B /O:N "%%d\*.html"') do (
        echo ```html >> %OUTPUT_FILE%
        type "%%d\%%f" >> %OUTPUT_FILE%
        echo``` >> %OUTPUT_FILE%
        echo. >> %OUTPUT_FILE%
        echo. >> %OUTPUT_FILE%
    )

    rem 按文件名从小到大遍历 .js 文件
    for /F "tokens=*" %%f in ('dir /B /O:N "%%d\*.js"') do (
        echo ```js >> %OUTPUT_FILE%
        type "%%d\%%f" >> %OUTPUT_FILE%
        echo ``` >> %OUTPUT_FILE%
        echo. >> %OUTPUT_FILE%
        echo. >> %OUTPUT_FILE%
    )
)

echo All .html and .js files' content have been written to %OUTPUT_FILE%
