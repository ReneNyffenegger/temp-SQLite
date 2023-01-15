import sqlite3
import os.path
# import sys
# import re

dbName = 'foreign-key-accross-attached-dbs.db'
if os.path.isfile(dbName):
   os.remove(dbName)

db = sqlite3.connect(dbName)
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

cur.execute('commit')
