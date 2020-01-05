
-- 
-- Entity: User Role
-- Description: Reference table containing a list of valid user roles
-- 
create table user_role (
  id tinyint unsigned not null,
  description varchar(255) not null,

  -- Record metadata
  created_timestamp timestamp not null default now(),
  updated_timestamp timestamp not null default now() on update now(),

  -- Keys/Indexes
  primary key (id)
)
engine InnoDB,
character set utf8mb4
collate utf8mb4_unicode_ci;





-- 
-- Entity: Visibility Scheme
-- Description: Reference table containing a list of valid visibility schemes
-- 
create table visibility_scheme (
  id tinyint unsigned not null,
  description varchar(255) not null,

  -- Record metadata
  created_timestamp timestamp not null default now(),
  updated_timestamp timestamp not null default now() on update now(),

  -- Keys/Indexes
  primary key (id)
)
engine InnoDB,
character set utf8mb4
collate utf8mb4_unicode_ci;

