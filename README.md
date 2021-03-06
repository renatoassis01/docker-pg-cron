# docker-pg-cron
Dockerfile with extension pg_cron 

## setup

```bash
docker-compose up --build
```
connect with superuser `postgres` in database `postgres` run command:

```sql
CREATE EXTENSION pg_cron;
```

## how use

```sql
-- Delete old data on Saturday at 3:30am (GMT)
SELECT cron.schedule('30 3 * * 6', $$DELETE FROM events WHERE event_time < now() - interval '1 week'$$);
 schedule
----------
       42

-- Vacuum every day at 10:00am (GMT)
SELECT cron.schedule('nightly-vacuum', '0 10 * * *', 'VACUUM');
 schedule
----------
       43

-- Change to vacuum at 3:00am (GMT)
SELECT cron.schedule('nightly-vacuum', '0 3 * * *', 'VACUUM');
 schedule
----------
       43

-- Stop scheduling jobs
SELECT cron.unschedule('nightly-vacuum' );
 unschedule 
------------
 t
(1 row)

SELECT cron.unschedule(42);
 unschedule
------------
          t

-- view jobs
select * from cron.job_run_details;
          
```

## use cases:

https://github.com/citusdata/pg_cron#example-use-cases

## References:

https://github.com/citusdata/pg_cron

https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/PostgreSQL_pg_cron.html

https://access.crunchydata.com/documentation/pg_cron/1.2.0/#example-use-cases
