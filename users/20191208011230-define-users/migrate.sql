
create user 'viva_auth_service'@'%' identified by '%AUTH_SERVICE_PASSWORD%';
create user 'viva_user_service'@'%' identified by '%USER_SERVICE_PASSWORD%';



-- Auth Service Permissions
grant select, insert, update, delete on viva_users.user to 'viva_auth_service'@'%';
grant select, insert, update, delete on viva_users.application to 'viva_auth_service'@'%';
grant select, insert, update, delete on viva_users.credential to 'viva_auth_service'@'%';
grant select on viva_users.user_role to 'viva_auth_service'@'%';
grant select on viva_users.visibility_scheme to 'viva_auth_service'@'%';
grant select on viva_users.credential_type to 'viva_auth_service'@'%';
grant select on viva_users.verification_type to 'viva_auth_service'@'%';



-- User Service Permissions
grant select, insert, update, delete on viva_users.user to 'viva_user_service'@'%';
grant select, insert, update, delete on viva_users.follow to 'viva_user_service'@'%';
grant select, insert, update, delete on viva_users.user_group to 'viva_user_service'@'%';
grant select, insert, update, delete on viva_users.user_group_user to 'viva_user_service'@'%';
grant select on viva_users.user_role to 'viva_user_service'@'%';
grant select on viva_users.visibility_scheme to 'viva_user_service'@'%';



flush privileges;
