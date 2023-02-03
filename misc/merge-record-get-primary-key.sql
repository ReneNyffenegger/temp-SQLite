create table t (
   id   integer primary key,
   val  text unique on conflict ignore
);

insert into t (val) values ('one'  ) returning id;
insert into t (val) values ('two'  ) returning id;
insert into t (val) values ('three') returning id;
insert into t (val) values ('two'  ) returning id;

-- WITH new_values (id, val) AS (
-- --VALUES (1, 'one')
--   select 1, 'one'
-- ),
-- inserted AS (
--   INSERT INTO  (id, val)
--   SELECT *
--   FROM new_values n
--   WHERE NOT EXISTS (
--     SELECT null
--     FROM T
--     WHERE n.id = T.id
--   )
-- )
-- SELECT id
-- FROM inserted;
