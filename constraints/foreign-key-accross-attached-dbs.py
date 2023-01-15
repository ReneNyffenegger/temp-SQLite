import sqlite3
import os.path
# import sys
# import re

dbName1 = 'foreign-key-accross-attached-dbs.db'
dbName2 = 'x.db'

if os.path.isfile(dbName1):
   os.remove(dbName1)
if os.path.isfile(dbName2):
   os.remove(dbName2)

db = sqlite3.connect(dbName1)
cur = db.cursor()

cur.execute('pragma foreign_keys = on')
cur.execute('begin transaction')

cur.execute('''
create table P (
   id   text   primary key,
   val  integer 
)
''')

cur.execute('''
create table C (
   id   text   references P,
   val  integer 
)
''')

cur.execute("insert into P values ('A', 1)")
cur.execute("insert into P values ('B', 2)")
cur.execute("insert into P values ('C', 3)")

cur.execute("insert into C values ('C', 333)")
# cur.execute("insert into C values ('D', 444)")

cur.execute("attach database 'x.db' as db1")

cur.execute('''
create table db1.CX (
   id   text   references main.P,
   val  integer 
)
''')

cur.execute("insert into db1.CX values ('C', 333)")

cur.execute('commit')
