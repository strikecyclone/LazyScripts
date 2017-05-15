#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

USER="root"
PASSWD="123456"
DAY="15"

DATE=`date +%Y-%m-%d`
# database list which we want to backup
MYSQLLIST="/home/ming/mysql_backup/db_list"
BASEBACKUP="/home/ming/mysql_backup/mysql"
#逐行读取$MYSQLLIST列表
for DATABASE in `cat $MYSQLLIST`
do
  FILEDIR="$BASEBACKUP/$DATABASE"
  if [ ! -d $FILEDIR ];then
    mkdir -p $FILEDIR
  fi
  # 导出数据库$DATABASE
  mysqldump -u$USER -p$PASSWD $DATABASE > $FILEDIR/$DATABASE-$DATE.sql
done

# 对创建时间超过$DAY天的文件进行删除
find $BASEBACKUP/*/ -mtime +$DAY -type f -exec rm -f {} \;
