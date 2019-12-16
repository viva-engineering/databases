
-- DELIMITER //

-- 
-- Clean up incomplete registration attempts once a day that are more than 2 days old
-- 
create event cleanup_incomplete_registrations
on schedule every 1 day
do
begin
  declare expired_time timestamp;
  set expired_time = date_sub(now(), interval 2 day);

  delete user
  from user
  where created_timestamp < expired_time
    and email_validated = 0;
end //

-- 
-- Clean up expired sessions once a day
-- 
create event cleanup_sessions
on schedule every 1 day
do
begin
  delete session
  from session
  where expiration < now();
end //
