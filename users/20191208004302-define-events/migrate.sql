
-- -- DELIMITER //

-- -- 
-- -- Cleans up all expired, non-password credential records from the table, checking chunks
-- -- of 2000 records at a time, with ~200ms sleep between chunks.
-- -- 
-- create event cleanup_credentials
-- on schedule every 7 day
-- do
-- begin
--   set @a = (select min(id) from viva_users.credential);
--   set @password = (select id from viva_users.credential_type where description = 'password');

--   chunks: loop
--     set @z = (select id from viva_users.credential where id >= @a order by id limit 2000, 1);

--     if @z is null then
--       leave chunks;
--     endif;

--     delete cred
--     from viva_users.credential cred
--     where cred.id >= @a
--       and cred.id < @z
--       and cred.credential_type_id != @password
--       and cred.expiration_timestamp < now();

--     set @a = @z;

--     select sleep(0.2);
--   end loop chunks;

--   delete cred
--   from viva_users.credential cred
--   where cred.id >= @a
--     and cred.credential_type_id != @password
--     and cred.expiration_timestamp < now();
-- end //
