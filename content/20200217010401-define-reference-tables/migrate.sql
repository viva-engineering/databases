

-- 
-- Entity: Emoji
-- Description: Contains the full list of supported emojis to be used as reactions.
-- 
create table emoji (
  id smallint unsigned not null,

  -- The utf8 character(s) comprising this particular emoji. The size is left fairly large to
  -- allow for the possibility of longer, complex code sequences in the future
  content varchar(255) not null,

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

