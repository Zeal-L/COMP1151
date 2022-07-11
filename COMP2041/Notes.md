## cat 连接文件并打印在标准输出上
- `-n` 在前面加上行号
- `-A` 显示无法打印的字符，便于调试
- `-s` 将连续的空行挤压成单空行

## grep 在文件中搜索模式
- `-i` 忽视大小写区别
- `-v` 只显示与模式不一致的行
- `-c` 打印匹配行的数量
- `-w` 只有当模式构成一个完整的单词时才会匹配
- `-F` 只匹配字符串（无正则表达式）
- `-E` 匹配完整的POSIX正则表达式
- `-o` 只显示匹配到的内容

## wc 字计数器
- `-l` 打印行数
- `-c` 打印字符数
- `-w` 打印词数

## tr 映射、挤压或删除标准输入的字符，写到标准输出
`tr 'abc' '123'`
- 将所有大写字母映射为小写字母的等价物
`tr 'A-Z' 'a-z'`
- 简单加密（a->b，b->c，...z->a）
`tr 'a-zA-Z' 'b-zaB-ZA'`
- 从输入中删除所有数字
`tr -d '0-9'`

## head/tail  选择第一/最后一行
- 将第81...100行复制到输出端
`head -n 100 | tail -n 20`

## cut 将文件中选定的行的部分打印到标准输出，纵切
- 打印第一列
`cut -f1 data`
- 打印前三列
`cut -f1-3 data`
- 打印第一和第四列
`cut -f1,4 data`
- 打印第三列之后的所有列
`cut -f4- data`
- 打印前三列，如果用'|'分隔的话
`cut -d'|' -f1-3 data`
- 打印每行的前五个字符
`cut -c1-5 data`

## sort 排序
- `-r`  反向排序
- `-n`  按数字排序
- `-t𝑐` 使用字符𝑐来分隔列（默认：空格）
- `-k[n,m]` 按照指定的字段范围排序。从第 n 个字段开始，到第 m 个字（默认到行尾）
    - `-k1.5,1.6` 第一列第五个字符到第六个字符
- 对第三列的数字按降序排序
`sort -nr -k3 data`
- 根据`:`分隔的第五列进行排序
`sort -t: -k5 data`

## uniq 移除相邻相同行的所有副本，只留下一个副本。
- `-c` 打印每行重复的次数
- `-d` 只打印重复的行
- `-u` 只打印唯一出现的行

## sed 依照脚本的指令来处理、编辑文本文件
- 打印所有行  
`sed -n -e 'p' < file`  
- 打印第81至100行     
`sed -n -e '81,100p' < file`  
- 只打印包含'xyz'的行  
`sed -n -e '/xyz/p' < file`  
- 只打印不含 "xyz "的行  
`sed -e '/xyz/d' < file`  
- 删除2~5行  
`sed '2,5d'`
- 匹配()里的进行替换，最多到\9
`sed -e 's/c(.)t(.*)/\1 hi \2 a/'`
    i like cats really
    i like a hi s really a
- /g替换所有匹配项
`sed -e 's/a/b/g'`
- a 新增, c 取代, i 插入; 一行并将结果输出到标准输出
`sed -e '4i\newLine' < file`
- -i 修改文件
`sed -i 's/1/0/g' file`
- /g全局查找替换
`sed -E 's/a/b/g'`
- 括号里面的保留，往括号里面的字符后面插入`!`
`echo "abcd" | sed -E 's/(b)/\1!/'` -> `ab!cd`
- 括号里面的保留，把括号前面一个换成空，也就是`a`,往括号里面的字符后面插入`!`
`echo "abcd" | sed -E 's/.(b)/\1!/'` -> `b!cd`
- 括号里面的保留，把括号前面一个换成`?`，也就是`a`,往括号里面的字符后面插入`!`
`echo "abcd" | sed -E 's/.(b)/?\1!/'` -> `?b!cd`
- 括号里面的保留，把括号后面一个换成空，也就是`c`,往括号里面的字符后面插入`!`
`echo "abcd" | sed -E 's/(b)./\1!/'` -> `ab!d`
- 括号里面的保留，也就是`c`，把括号前面的字符换成空，往括号里面的字符后面插入`!`
`echo "abcd" | sed -E 's/b(.)/\1!/'` -> `ac!d`
- 括号里面的保留，也就是`a`，把括号后面的字符换成空，往括号里面的字符后面插入`!`
`echo "abcd" | sed -E 's/(.)b/\1!/'` -> `a!cd`
- 打印指定区间内所有行
`sed -n '/start/,/end/p'`
- 删除开头结尾之间的所有字符
`sed  '/start/,/end/{//!d}'`
- 删除包括开头结尾之间的所有字符
`sed  '/start/,/end/d'`
- 与模式匹配的输入的整个部分
`sed 's/[0-9]/& /g'`
- 删除首尾行
`sed '1d;$d'`

## find 根据指定的属性来搜索文件整个目录树，也可以指定操作行动
- 找到当前目录下面的所有HTML文件。
`find ./ -name '*.html'`
- 找到你在过去2天内改变的所有文件和目录
`find ~ -mtime -2`
- 显示过去2天内改变的文件信息
`find ~ -mtime -2 -type f -exec ls -l {} \;`
- 显示最近一周内改变的目录信息
`find ~ -mtime -7 -type d -exec ls -ld {} \;`
- 找到新的或名称中带有 "2041 "的目录
`find ~ -type d \( -name '*2041*' -o -mtime -1 \)`

## join 使用每个文件中的一个字段的值作为一个共同的键来合并两个文件
- 键字段可以在每个文件中处于不同的位置，但文件必须根据该字段排序。默认的键字段是1
- 根据空格分隔，匹配文件1的第一列和文件2的第二列，进行join。-a 1也打印文件1里面没有被匹配到的行
`join -t' ' -2 2 -a 1 data1 data2`

## paste 将由每个文件中顺序对应的行组成的行写到标准输出
- 在输出端 "并行 "显示几个文本文件。
    如果输入的文件是a、b、c
    输出的第一行由a、b、c的第一行组成
    第二行输出由a、b、c的第二行组成。
    每个文件的行都由制表符或指定的分隔符分隔。
    如果文件的长度不同，输出的是最长文件的所有行，缺失的行为空字符串。
`paste data1 data2`

## tee 将管道的副本发送至文件
`echo Hello World | tee copy.txt`
- 一个有用的调试技巧: 将一个管道的副本转移到终端
`tee /dev/tty` 

## xargs 从标准输入建立和执行命令行
- 在/usr/src/下面的每个子目录中用一个Makefile运行make，最多可并行运行8个make
`find /usr/src -name Makefile | sed 's/Makefile//' | xargs -P8 -i@ make -C @`

## test [ ] 执行一个测试或测试组合
- 字符串比较: = !=
- 数值比较: -eq -ne -lt
- 测试文件是否存在/是否可执行/是否可读: -f -x -r
- 布尔运算符(and/or/not): -a -o !

## shell
- `set -x` debug info
- `echo "$x"` interpret x
- `echo '$x'` turn off interpret

## stat

## git
- `git init <projectName>`
- `cd <projectName>`
- `git branch -m master`
- `git checkout -b <branch-name>`
- `git status`
- `git add .`
- `git commit -m ""`
- `git push -u origin main`
- `git ass <file>`
- `git ls-files -s` print index
- `git cat-file -p <hash>` pretty-print object's content
- `git cat-file -t <hash>` show object type
- `git cat-file -s <hash>` show object size
- `git cat-file --batch-check --batch-all-objects | cut -d' ' -f2 | sort | uniq -c`
- `git commit -m ""`
- `git log`
- `git show <hash> <file>`

## mktem
- `-d`

## seq 1 5

## basename

## cmp
-  Compare two files byte by byte.
- `-s` quiet, silent, suppress all normal output

expert PATH="$PATH:."


