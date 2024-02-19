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
- `-w` 在行中比较不超过N个字符

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
- 每两行合并成一行
`sed -n '{N;s/\n/\t/p}'`

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

## stat 显示文件或文件系统状态

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
- `git ls-files -s`
- `git cat-file -p <hash>` pretty-print object's content
- `git cat-file -t <hash>` show object type
- `git cat-file -s <hash>` show object size
- `git cat-file --batch-check --batch-all-objects | cut -d' ' -f2 | sort | uniq -c`
- `git commit -m ""`
- `git log`
- `git show <hash> <file>`

## mktem
- `-d`

## seq
`seq 1 5`

## basename

## cmp
-  Compare two files byte by byte.
- `-s` quiet, silent, suppress all normal output

## tac

## tar
- `tar czvf X.tar <dic>`
  - -c 建立压缩档案
  - -f 使用档案名字
  - -z 用gzip压缩
  - -v 显示所有过程
- `tar xzvf X.tar <dic>`
  - -x：解压


## scp
- `scp z5325156@cse.unsw.edu.au:/import/ravel/5/z5325156/COMP2041/example.sh ./`

## xargs
- `xargs -n1 <program>` max-args 1

## make
- `make -f Makefile` 可以用-f选项指定一个不同的makefile名称，以打印它在创建目标时要做的事情，但不执行任何命令。
- `make -n` -n选项指示make打印它在创建目标时要做的事情，但不执行任何命令。
- `make -j16` -jN选项指示make使用多达N个并行进程并行构建依赖关系。

## getconf
- `getconf _NPROCESSORS_ONLN` 最大并行数

## curl
- `curl -O <https>` # fetch a file
- `curl I <https>` # get other info
- `curl -X PUT -H 'content-type: txt/plain' https://google.com` # send data to web server
- `curl -b 'id=42' https://google.com` send cookies to web server

## wget

## ssh
- `ssh-keygen`
- `cat $HOME/.ssh/id_rsa.pub`
- `ssh z5325156@login.cse.unsw.edu.au ls -las`

## rsync
- create a 10mb file
- `dd if=/dev/random bs=1M count=10 of=10_mb_file`
- `rsync z5325156@login.cse.unsw.edu.au:~/.ssh/id_rsa ~/.ssh/id_rsa`

## ps

## kill
- `kill -9 <PID>` signal 9 always terminates process

## pgrep
- print PIDs of processes matching selection criteria
- `pgrep python`

## pkill
send a signal to processes matching selection criteria
- `pkill -9 '[aeiou][aeiou]'`

## top / htop

## apt install

## pwd

## whoami

## Linux Filesystem Layout
- /home - 系统中用户的家庭目录
- /bin - 重要的系统程序（脚本和二进制文件）。
- /usr/ - 系统程序和相关文件
  - /usr/bin 系统程序
  - /usr/local/bin 自定义安装的本地程序
  - /usr/lib - 库（与程序相连）。
  - /usr/include - C程序的头文件
- /etc - 保存系统程序的配置
- /opt - 多操作系统包，有时安装在这里
- /var - 定期改变的系统文件，例如：日志文件、数据库文件。
- /tmp - 临时文件的目录 - 重启时删除的文件
- /root - 根用户的主目录
- /boot - 启动操作系统所需的文件
- /dev - 硬件设备的路径名。
- /dev/null
  - 写入不做任何事情（被忽略）。
  - 读取时不返回任何东西
- /dev/zero
  - 写入也不做任何事情，但使用/dev/null
  - 读取时返回包含0的字节
- /dev/random /dev/urandom
  - `cat /proc/sys/kernel/random/entropy_avail`
  - 写入时提供熵
    - 只有在你知道自己在做什么的情况下才这样做
  - 读取时返回包含随机值的字节
  - 在最近的Linux内核（5.6以上）中，你可能想要/dev/random。
    - 在系统启动时阻止（等待）熵的产生
    - 否则与最近的Linux内核中的/dev/urandom相同
- /media - 可移动设备的挂载点
- /proc - 特殊的文件系统，包含进程的信息
- /sys - 包含系统信息的特殊文件系统

### du
- 查看指定文件大小
- `du -a <file>`
- 查看当前目录总共占的容量
- `du -sh`
- 查看当前目录下一级子文件和子目录占用的磁盘容量
- `du -lh --max-depth=1 | sort -h`
- 查看当前目录下各文件、文件夹的大小
- `du -h –max-depth=1 * | sort -h`

## ls -lh

## xxd
- `xxd /dev/null`
- `xxd /dev/zero | head`
- `xxd /dev/random | head`

## useful regex
- `^[^#]*\w+` 实际代码行数（不包含注释）

## apt 蝶变软件包管理器
- 更新现有软件包的数据库
`sudo apt update`
- 安装一个软件包+依赖项
`sudo apt install <packagename>`
- 安装已下载的包文件
`sudo apt install ./package.deb`
- 卸载软件包
`sudo apt remove <packagename>`
- 所有软件包
`sudo apt list`
- 更新所有软件包
`sudo apt dist-upgrade`
- 搜索包
`sudo apt search <packagename>`
- 打印包括依赖性在内的软件包元数据
`sudo apt info <packagename>`

## ps 报告当前进程的快照。
- 查看系统中的每个进程
- `ps -e`


# wsl
- vim ~/.bashrc
- source ~/.bashrc
- sudo -u zeal startxfce4
- wsl --shutdown
- sfc/scannow

export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0 # in WSL 2