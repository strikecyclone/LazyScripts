# LazyScripts
重复的事情就交给脚本去跑吧

## 目录
JavaInstaller--------------------------配置java环境变量

## 脚本用法
├── JavaInstaller
│   ├── config_javac.sh
│   ├── config_java.sh
│   └── install_java.sh
├── MySQLBackup
│   ├── backup.sh
│   └── db_list
├── README.md
├── solr
│   ├── dedup.sh
│   └── update_score.sh

### JavaInstaller
`sudo JavaInstller/install_java.sh <jdk_folder>`
如果已经有其他版本的java，则需要执行`config_java.sh`和`config_javac.sh`两个脚本，选择当前版本即可

### MySQLBackup
`./backup.sh`
配置好脚本中的mysql帐号密码以及db_list中的待备份数据库名字后，对数据库进行备份，可通过设置crontab来实现自动备份

### solr
`solr/dedup.sh <file> [<url>]`
url是solr的地址，可直接在脚本中设置，脚本功能是删除file文件中的url列表
`solr/update_score.sh <file> [<url>]`
参数同上，脚本功能是更新solr中的网页分数
