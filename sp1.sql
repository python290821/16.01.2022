-- return movies not the cheapest and not the most expansive
drop function sp_get_movies_mid;
CREATE or replace function sp_get_movies_mid()
returns TABLE(id bigint, title text, release_date timestamp,
    price double precision, country_id bigint, country_name text)
language plpgsql AS
    $$
        BEGIN
            return QUERY
            select m.id, m.title, m.release_date, m.price, m.country_id, c.name from movies m
            join countries c on m.country_id = c.id
            where m.price between _min and _max;
        end;
    $$;

select * from sp_get_movies_mid() order by release_date;