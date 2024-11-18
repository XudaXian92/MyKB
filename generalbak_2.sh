#!/bin/bash

# 设置数据源目录和备份目录的根路径
SOURCE_DIR="/path/to/source"
BACKUP_DIR="/path/to/backup"

# 生成当天日期的目录
TODAY_DIR=$BACKUP_DIR/$(date +%Y%m%d)
mkdir -p "$TODAY_DIR"

# 使用rsync同步数据
rsync -av --delete $SOURCE_DIR $TODAY_DIR

# 删除超过30天的数据目录
find $BACKUP_DIR -type d -mtime +30 -exec rm -rf {} \;
