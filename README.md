# How to compile sqlite3 and extension - CSV virtual table

SQLite version 3.31.1 2020-01-27 19:55:54

You can compile SQLite from sources, including extensions, as follows:

```
docker run -ti --rm -v $(pwd):/host ubuntu bash

# Steps to build SQLite and CSV Virtual Table extension from source inside an Ubuntu docker container
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
```

You can use a very similar process to compile into a CentOS binary that will work within AWS Lambda. Change the docker run command as follows:

```
docker run -ti --rm -u 0 -v $(pwd):/host --entrypoint bash lambci/lambda:build-python3.7
```

Compiled binaries and extensions can be found here:

Ubuntu:
  - See folder: ubuntu_sqlite-autoconf-3310100

Lambda (CentOS):
  - [Zip archive](https://github.com/vbalasu/sqlite3-src/raw/master/sqlite3_lambda.zip)
  - See folder: lambda_sqlite-autoconf-3310100

MacOS:
  - See folder: macos_sqlite-autoconf-3310100

See also: [Stack Overflow](https://stackoverflow.com/questions/59969377/how-to-compile-sqlite3-extension-csv-virtual-table)