#!/bin/bash

rm -rf big_empty
mkdir -p big_empty
cd big_empty
dolt init

END=3000
for ((i=1;i<=END;i++)); do
    if ! (($i % 500)); then
        echo "... running iteration $i"
    fi
    dolt sql 1> /dev/null <<SQL
create table t$i (x int primary key);
insert t$i values ($i);;
select dolt_commit('-am', 'commit create $i');
drop table t$i;
select dolt_commit('-am', 'commit drop $i');
SQL
done

