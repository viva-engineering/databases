
create user 'viva_content_service'@'%' identified by '%CONTENT_SERVICE_PASSWORD%';



-- Content Service Permissions
grant select, insert, update, delete on viva_users.user to 'viva_content_service'@'%';



flush privileges;
