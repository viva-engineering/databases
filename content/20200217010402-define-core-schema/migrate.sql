
-- 
-- Entity: User Post
-- Description: Contains a single user content post
-- 
create table user_post (
  id bigint unsigned auto_increment not null,

  -- The user that created the post
  user_id bigint unsigned not null,

  -- The actual text content of the post
  content text not null default '',

  -- Does the post contain explicit content?
  explicit_content tinyint not null,

  -- Is the explicit content flag locked by moderator action?
  explicit_content_locked tinyint not null default 0,

  -- Record Metadata
  create_timestamp timestamp not null default now(),
  update_timetsamp timestamp not null default now() on update now(),

  -- Indexes
  primary key (id),
  index idx_user_post_user_id (user_id)
)
engine InnoDB
character set utf8mb4
collate utf8mb4_unicode_ci;





-- 
-- Entity: User Post Reaction
-- Description: Contains a reaction to a user post, in the form of a single unicode character (generally
--   intended to be an emoji).
-- 
create table user_post_reaction (
  -- The user post being reacted to
  user_post_id bigint unsigned not null,

  -- The user reacting to the post
  user_id bigint unsigned not null,

  -- The actual text content of the post (size 4 bytes for a single multibyte character)
  character varchar(4) not null,

  -- Record Metadata
  create_timestamp timestamp not null default now(),
  update_timetsamp timestamp not null default now() on update now(),

  -- Indexes
  primary key (id),
  index idx_user_post_user_id (user_id),

  -- Constraints
  constraint fk_user_post_reaction_user_post_id
    foreign key (user_post_id) references user_post (id)
)
engine InnoDB
character set utf8mb4
collate utf8mb4_unicode_ci;





-- 
-- Tables:
--  - user_post
--  - user_post_reaction
--  - user_post_comment
--  - user_post_comment_reaction
-- 


-- 
-- Possibly in another DB:
--  - user_post_report
--  - user_post_report_review
-- 


-- 
-- Potential other tables for "pages":
--  - page
--  - user_post_page (`user_post` >-- `page`)
--    - some mechanism to allow users to not show page posts in followers' feeds?
--      - potentially a flag on `user_post_page` that is a "page only" post?
--  - page_follow (`user`.`user` --< `page`)
-- 

