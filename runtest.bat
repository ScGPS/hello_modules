rd /s /q target
mkdir target

REM ����coverage,junit�õ���Ϣ
REM ����JUnit��xml���
go test -covermode=count -test.coverprofile ./target/coverage.cov -v -benchmem -bench .| go-junit-report > ./target/junit.xml

REM ����Coverage��html���
go tool cover -html=./target/coverage.cov -o ./target/coverage.html

REM ����Coverage��xml���
gocover-cobertura < ./target/coverage.cov > ./target/coverage.xml

REM ��ʾCoverage��html,xml���
set cur_path=%~dp0
set chrome_exe=%USERPROFILE%\AppData\Local\Google\Chrome\Application\chrome.exe
start %chrome_exe%  %cur_path%/target/coverage.html %cur_path%/target/coverage.xml || echo ok
set chrome_exe="C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
start %chrome_exe%  %cur_path%/target/coverage.html %cur_path%/target/coverage.xml || echo ok