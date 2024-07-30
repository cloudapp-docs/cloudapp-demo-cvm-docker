#!/bin/bash

# 读取 test.env 文件中的环境变量
export $(grep -v '^#' test.env | xargs)

# 使用 mysql 命令导入 db.sql 文件的内容
mysql -h$MYSQL_HOST -P$MYSQL_PORT -u$MYSQL_USERNAME -p$MYSQL_PASSWORD < init_data.sql

# 检查导入是否成功
if [ $? -eq 0 ]; then
    echo "Database initialization successful."
else
    echo "Database initialization failed."
    exit 1
fi
