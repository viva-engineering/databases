
create user 'viva_auth_service'@'%' identified by '%AUTH_SERVICE_PASSWORD%';

grant select, insert, update, delete on viva_users.user to 'viva_auth_service'@'%';
grant select, insert, update, delete on viva_users.application to 'viva_auth_service'@'%';
grant select, insert, update, delete on viva_users.credential to 'viva_auth_service'@'%';
-- grant select, insert, update, delete on viva_users.session to 'viva_auth_service'@'%';
grant select, insert, update, delete on viva_users.user_role to 'viva_auth_service'@'%';
grant select, insert, update, delete on viva_users.visibility_scheme to 'viva_auth_service'@'%';
grant select, insert, update, delete on viva_users.credential_type to 'viva_auth_service'@'%';
grant select, insert, update, delete on viva_users.verification_type to 'viva_auth_service'@'%';

flush privileges;
