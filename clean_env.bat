REM 删除指定字符串的文件夹
for /f "delims=" %%i in ('dir /s /a /b *target*') do (
rd /s/q "%%~i"
)

del /s /q *_bin.exe
del /s /q *temp.log