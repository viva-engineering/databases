
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
