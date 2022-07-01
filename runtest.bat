rd /s /q target
mkdir target

REM 生成coverage,junit用的信息
REM 生成JUnit的xml结果
go test -covermode=count -test.coverprofile ./target/coverage.cov -v -benchmem -bench .| go-junit-report > ./target/junit.xml

REM 生成Coverage的html结果
go tool cover -html=./target/coverage.cov -o ./target/coverage.html

REM 生成Coverage的xml结果
gocover-cobertura < ./target/coverage.cov > ./target/coverage.xml

REM 显示Coverage的html,xml结果
set cur_path=%~dp0
set chrome_exe=%USERPROFILE%\AppData\Local\Google\Chrome\Application\chrome.exe
start %chrome_exe%  %cur_path%/target/coverage.html %cur_path%/target/coverage.xml || echo ok
set chrome_exe="C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
start %chrome_exe%  %cur_path%/target/coverage.html %cur_path%/target/coverage.xml || echo ok