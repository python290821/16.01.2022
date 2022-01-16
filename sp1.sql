
drop function sp_get_movies_higer_than;
-- procedure does not return a value
CREATE or replace function  sp_get_movies_higer_than(_min double precision)
returns TABLE(id bigint, title text, release_date timestamp,
    price double precision, country_id bigint, country_name text)
language plpgsql AS
    $$
        BEGIN
            return QUERY
            select m.id, m.title, m.release_date, m.price, m.country_id, c.name from movies m
            join countries c on m.country_id = c.id
            where m.price > _min;
        end;
    $$;

select * from sp_get_movies_higer_than(0) order by release_date;

drop function sp_get_movies_from_country;
-- procedure does not return a value
CREATE or replace function  sp_get_movies_from_country(_country_name text)
returns TABLE(title text, release_date timestamp)
language plpgsql AS
    $$
        BEGIN
            return QUERY
            select m.title, m.release_date from countries c
                join movies m on c.id = m.country_id
            where c.name like 'USA';
        end;
    $$;

select * from sp_get_movies_from_country('USA') order by release_date;

