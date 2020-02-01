# Steps to build SQLite and CSV Virtual Table extension from source in an Ubuntu docker container
cd /host
apt update
apt install -y vim build-essential zip wget
wget https://sqlite.org/2020/sqlite-autoconf-3310100.tar.gz
tar xvf sqlite-autoconf-3310100.tar.gz 
cd sqlite-autoconf-3310100
./configure
make
./sqlite3
# Obtain csv.c and change <sqlite3ext.h> to "sqlite3ext.sh"
vi csv.c
gcc -g -fPIC -shared csv.c -o csv.so
./sqlite3
#sqlite> .load ./csv
#sqlite> CREATE VIRTUAL TABLE temp.t1 USING csv(filename='/host/users.csv',header);
#sqlite> .headers on
#sqlite> SELECT * FROM t1 LIMIT 1;
