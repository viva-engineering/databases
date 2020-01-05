
-- 
-- Entity: User
-- Description: Contains the list of all users in the system and their core
--   identifying attributes
-- 
create table user (
  id bigint unsigned auto_increment not null,

  -- The user's login name and related flags
  username varchar(255) unique not null,
  username_discoverable tinyint unsigned not null default 0,

  -- The user's email address (optional) and related flags
  email varchar(255),
  email_discoverable tinyint unsigned not null default 0,

  -- The user's phone number (optional) and related flags
  phone varchar(255),
  phone_discoverable tinyint unsigned not null default 0,

  -- Randomly generated user code, acting as the user's public facing ID. Anyone who
  -- has this code can find this user's profile (although they may not be able to
  -- see much beyond that depending on other settings). User codes are intended to be
  -- re-generated at any time, and are therefore never referenced in any stored data.
  user_code varchar(255) unique not null collate utf8mb4_bin,

  -- User role, used for assigning elevated permissions
  user_role_id tinyint unsigned not null default 0,

  -- Record Metadata
  create_timestamp timestamp not null default now(),
  update_timetsamp timestamp not null default now() on update now(),

  -- Indexes
  primary key (id),
  index idx_user_username (username, username_discoverable),
  index idx_user_email (email, email_discoverable),
  index idx_user_phone (phone, phone_discoverable),
  index idx_user_user_code (user_code),

  -- Constraints
  constraint fk_user_user_role_id
    foreign key (user_role_id) references user_role (id)
)
engine InnoDB
character set utf8mb4
collate utf8mb4_unicode_ci;





-- 
-- Entity: User Preferences
-- Description: Represents a user's preferences, settings, and profile. This table has a
--   1-to-1 relationship with the user table, storing additional user info to keep the
--   user table thinner.
-- 
create table user_preferences (
  user_id bigint unsigned not null,

  -- The user's display name, used in the UI in place of username
  display_name varchar(255) not null default '',

  -- Does this user see explicit content by default?
  explicit_content_visible tinyint(1) not null default 0,

  -- Content privacy defaults
  default_post_visibility_id tinyint unsigned not null default 0,
  default_image_visibility_id tinyint unsigned not null default 0,

  -- The user's location (optional) and related flags
  location varchar(255),
  location_visibility_id tinyint unsigned not null default 0,

  -- The user's birthday (optional) and related flags
  birthday date,
  birthday_visibility_id tinyint unsigned not null default 0,

  -- The user's bio (optional) and related flags
  bio varchar(1024),
  bio_visibility_id tinyint unsigned not null default 0,

  -- Additional visibility flags
  email_visibility_id tinyint unsigned not null default 0,
  phone_visibility_id tinyint unsigned not null default 0,

  -- Auto-accept follow requests?
  auto_accept_follows tinyint unsigned not null default 0,

  -- The user's preferred language for the UI (references `viva_i18n`.`code`)
  preferred_language varchar(255) not null default 'en-us',

  -- Record Metadata
  create_timestamp timestamp not null default now(),
  update_timetsamp timestamp not null default now() on update now(),

  -- Indexes
  primary key (user_id),

  -- Constraints
  constraint fk_user_preferences_user_id
    foreign key (user_id) references user (id),
  constraint fk_user_preferences_default_post_visibility_id
    foreign key (default_post_visibility_id) references visibility_scheme (id),
  constraint fk_user_preferences_default_image_visibility_id
    foreign key (default_image_visibility_id) references visibility_scheme (id),
  constraint fk_user_preferences_email_visibility_id
    foreign key (email_visibility_id) references visibility_scheme (id),
  constraint fk_user_preferences_phone_visibility_id
    foreign key (phone_visibility_id) references visibility_scheme (id),
  constraint fk_user_preferences_location_visibility_id
    foreign key (location_visibility_id) references visibility_scheme (id),
  constraint fk_user_preferences_birthday_visibility_id
    foreign key (birthday_visibility_id) references visibility_scheme (id),
  constraint fk_user_preferences_bio_visibility_id
    foreign key (bio_visibility_id) references visibility_scheme (id)
)
engine InnoDB
character set utf8mb4
collate utf8mb4_unicode_ci;





-- 
-- Entity: Follow
-- Description: Represents a user following another user
-- 
create table follow (
  follower_user_id bigint unsigned not null,
  followed_user_id bigint unsigned not null,

  -- Follow requests can be declined or accepted by the user being followed. This flag
  -- represents if request has been approved (users who allow anyone to follow will have
  -- this flag set to 1 automatically for all follow requests).
  approved tinyint unsigned not null default 0,

  -- Record Metadata
  create_timestamp timestamp not null default now(),
  update_timetsamp timestamp not null default now() on update now(),

  -- Indexes
  primary key (follower_user_id, followed_user_id),
  index idx_follow_followed_user_id (followed_user_id),

  -- Constraints
  constraint fk_follow_follower_user_id
    foreign key (follower_user_id) references user (id),
  constraint fk_follow_followed_user_id
    foreign key (followed_user_id) references user (id)
)
engine InnoDB
character set utf8mb4
collate utf8mb4_unicode_ci;





-- 
-- Entity: User Group
-- Description: Represents a group of users, created by another user to control visibility
--   of content, or to create customized views
-- 
create table user_group (
  id bigint unsigned not null auto_increment,

  -- The owner (creator) of the group
  owner_user_id bigint unsigned not null,

  -- A name for the group, assigned by the owner
  name varchar(255) not null,

  -- Record Metadata
  create_timestamp timestamp not null default now(),
  update_timetsamp timestamp not null default now() on update now(),

  -- Indexes
  primary key (id),
  index idx_user_group_owner_user_id (owner_user_id),

  -- Constraints
  constraint fk_user_group_owner_user_id
    foreign key (owner_user_id) references user (id)
)
engine InnoDB
character set utf8mb4
collate utf8mb4_unicode_ci;





-- 
-- Entity: User Group User
-- Description: Join table used to store the list of users in a given group
-- 
create table user_group_user (
  user_group_id bigint unsigned not null,
  user_id bigint unsigned not null,

  -- Record Metadata
  create_timestamp timestamp not null default now(),
  update_timetsamp timestamp not null default now() on update now(),

  -- Indexes
  primary key (user_group_id, user_id),

  -- Constraints
  constraint fk_user_group_user_user_group_id
    foreign key (user_group_id) references user_group (id),
  constraint fk_user_group_user_user_id
    foreign key (user_id) references user (id)
)
engine InnoDB
character set utf8mb4
collate utf8mb4_unicode_ci;





-- 
-- Entity: Application
-- Description: Represents an application that can access the API services on behalf of a user
-- 
create table application (
  -- Application IDs are randomly generated strings
  id varchar(255) not null,

  -- The name of the application as displayed to users
  name varchar(255) not null,

  -- The hashed digest of the application's secret key, used to identify the application
  secret_key_digest varchar(255) not null,

  -- The user that owns the application
  owner_user_id bigint unsigned not null,

  -- Is this application active
  active tinyint(1) not null default 1,

  -- Is this application approved (applications must be approved by an admin user)
  approved tinyint(1) not null default 0,

  -- Record metadata
  created_timestamp timestamp not null default now(),
  updated_timestamp timestamp not null default now() on update now(),

  -- Keys/Indexes
  primary key (id),
  index idx_application_owner_user_id (owner_user_id),

  -- Foreign Keys
  constraint fk_application_owner_user_id
    foreign key (owner_user_id) references user (id)
)
engine InnoDB
character set utf8mb4
collate utf8mb4_unicode_ci;





-- 
-- Entity: Credential
-- Description: Stores user credentials used to authenticate
-- 
create table credential (
  id bigint unsigned not null auto_increment,

  -- The user the credential authenticates
  user_id bigint unsigned not null,

  -- If this credential is allocated to a given application, this references the application
  application_id varchar(255),

  -- The hash digest of the password / key
  key_digest varchar(255) not null,

  -- Expiration timestamp for the credential. Expired password credentials can still be used to
  -- authenticate, but must be updated at that time. Other credential types are purged when they
  -- expire.
  expiration_timestamp timestamp not null,

  -- A counter that keeps track of the number of recent failed authentication attempts with this
  -- credential. If the count raises above a certain point, the credentials can be listed as
  -- compromised, or simply removed (depending on the type of credential). The number is reduced
  -- when a successful authentication with this credential occurs.
  recent_failures int not null default 0,

  -- Security compromised flag. A user attempting to login with compromised credentials must
  -- verify their identify with a second auth factor, and then the compromised credentials
  -- must be updated or removed. This flag might be set automatically after a number of failed
  -- login attempts, or could be set manually in the event of a breach to force users to
  -- update credentials.
  compromised tinyint not null default 0,

  -- Record Metadata
  create_timestamp timestamp not null default now(),
  update_timetsamp timestamp not null default now() on update now(),

  -- Indexes
  primary key (id),
  index idx_credential_user_id_application_id (user_id, application_id),

  -- Constraints
  constraint fk_credentials_user_id
    foreign key (user_id) references user (id),
  constraint fk_credentials_application_id
    foreign key (application_id) references application (id)
)
engine InnoDB
character set utf8mb4
collate utf8mb4_unicode_ci;




