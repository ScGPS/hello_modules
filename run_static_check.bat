mkdir target

REM ���������
golint . > target/lint.txt

REM ����checkstyle��xml���
gometalinter --checkstyle . > target/checkstyle.xml