rm -rf target
mkdir -p target

# 生成coverage,junit用的信息
# 生成JUnit的xml结果
go test -covermode=count -test.coverprofile ./target/coverage.cov -v -benchmem -bench .| go-junit-report > ./target/junit.xml

# 生成Coverage的html结果
go tool cover -html=./target/coverage.cov -o ./target/coverage.html

# 生成Coverage的xml结果
gocover-cobertura < ./target/coverage.cov > ./target/coverage.xml

# Modify coverage.xml for Jenkins
modifyfile=./target/coverage.xml
#cp ${modifyfile}.bak ${modifyfile}
cp ${modifyfile} ${modifyfile}.bak
cur_path=`pwd`
sed -i "s:filename=\"$cur_path/:filename=\":g" ${modifyfile} 
line=`sed -n '/<source>/=' $modifyfile`
#echo $line

# Reverse Array
unset temp_i
unset temp_j
for temp_j in $line; do temp_i="$temp_j $temp_i"; done; echo $temp_i

# Delete bad source line
for i in ${temp_i[@]}
do 
  #echo $i
  sed -i "${i}d" $modifyfile
done

insert_string="                <source>${cur_path}</source>"
# echo $insert_string
# Insert source line
for i in ${line[@]}
do 
  #echo $i
  sed "${i}i ${insert_string}" -i $modifyfile
  break
done

#cp ${modifyfile}.bak ${modifyfile}
unset temp_content
modifyfile=./target/coverage.xml
# modify name="-" be same with filename 
#sed -i "s:name=\"-\"::g" $modifyfile
line=`sed -n '/name=\"-\"/=' $modifyfile`
#echo $line
sed -i "s:name=\"-\"::g" $modifyfile
for i in ${line[@]}
do 
  #echo $i
  content=`sed -n "${i}p" $modifyfile`
  echo $content
  unset temp_content
  for s in ${content[@]} 
  do 
    #echo "$s"
    temp_content="$temp_content $s"
    if [[ ${s} =~ 'filename' ]]
    then
       temp_name=${s/filename/name}
       temp_content="$temp_content $temp_name"
    fi
  done
  #echo $temp_content
  sed -i "${i}d" $modifyfile
  sed "${i}i ${temp_content}" -i $modifyfile
done
