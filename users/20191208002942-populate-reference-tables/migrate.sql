
-- 
-- Populate the list of User Roles
-- 
insert into user_role
  (id, description)
values
  (0, 'user'),
  (1, 'system'),
  (2, 'admin'),
  (3, 'super_moderator'),
  (4, 'moderator'),
  (5, 'localization');





-- 
-- Populate the list of Visibility Schemes
-- 
insert into visibility_scheme
  (id, description)
values
  (0, 'private'),
  (1, 'public'),
  (2, 'visible_to_followers');





-- 
-- Populate the list of Credential Types
-- 
insert into credential_type
  (id, description)
values
  (0, 'password'),
  (1, 'temp_credential'),
  (2, 'application');
