pragma foreign_keys=on;

explain query plan select 42, 'hello world';
explain            select 42, 'hello world';

explain query plan create table lookup(id integer primary key, txt text not null unique) /* strict */;
explain            create table lookup(id integer primary key, txt text not null unique) /* strict */;
                   create table lookup(id integer primary key, txt text not null unique) /* string */;

explain query plan create table data(id integer primary key, val text not null, id_lu integer not null references lookup) /* strict */;
explain            create table data(id integer primary key, val text not null, id_lu integer not null references lookup) /* strict */;
                   create table data(id integer primary key, val text not null, id_lu integer not null references lookup) /* strict */;


begin transaction;
   insert into lookup (txt) values ('foo');
   insert into lookup (txt) values ('bar');
   insert into lookup (txt) values ('baz');
commit;

begin transaction;
   insert into data (val, id_lu) select 'spiel', id from lookup where txt = 'bar';
   insert into data (val, id_lu) select 'ecke' , id from lookup where txt = 'baz';
   insert into data (val, id_lu) select 'learn', id from lookup where txt = 'baz';
-- insert into data (val, id_lu) select 'error', 4;
commit;

                   select d.id, d.val from data d join lookup l on d.id_lu = l.id where l.txt = 'bar';
explain query plan select d.id, d.val from data d join lookup l on d.id_lu = l.id where l.txt = 'bar';
explain            select d.id, d.val from data d join lookup l on d.id_lu = l.id where l.txt = 'bar';

explain            select d.id from data d join lookup l on d.id_lu = l.id where l.val = 'hello world';
explain query plan select d.id from data d join lookup l on d.id_lu = l.id where l.val = 'hello world';
