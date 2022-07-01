mkdir -p target

# 代码检测规则
golint . > target/lint.txt

# 生成checkstyle的xml结果
gometalinter --checkstyle . > target/checkstyle.xml