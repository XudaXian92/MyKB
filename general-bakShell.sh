#!/bin/bash

#初始化信息 
DB_USER="数据库账户"
DB_PASSWORD="密码"
DB_NAME="数据库名字"
BACKUP_PATH="/path/to/backPath"
REMOTE_HOST="数据库ip"
REMOTE_PORT="数据库端口"

DATE=$(date +%Y%m%d)
BACKUP_FILE="$BACKUP_PATH/$DB_NAME-$DATE.sql"
TAR_FILE="$BACKUP_PATH/$DB_NAME-$DATE.tar.gz"

mysqldump -h $REMOTE_HOST -P $REMOTE_PORT -u $DB_USER -p$DB_PASSWORD $DB_NAME > $BACKUP_FILE

tar -czvf $TAR_FILE $BACKUP_FILE

# 删除原始的sql备份文件
rm $BACKUP_FILE

scp -a $BACKUP_PATH 192.xxx.x.x:/data/crm_bak

#配置邮件通知 我这里用的是mailx（提前配置 按实际情况出发）
echo "xxx已备份完成" | mailx -s "xxxxx备份脚本通知" xxxx@dxxxx.com


# 查找并删除7天前的压缩备份
find $BACKUP_PATH/* -mtime +7 -exec rm {} \;

