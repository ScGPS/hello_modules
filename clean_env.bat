REM ɾ��ָ���ַ������ļ���
for /f "delims=" %%i in ('dir /s /a /b *target*') do (
rd /s/q "%%~i"
)

del /s /q *_bin.exe
del /s /q *temp.log