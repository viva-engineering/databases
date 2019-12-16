
create table i18n_languages (
  code varchar(255) not null,
  description varchar(255) not null,
  native_description varchar(255) not null,
  active tinyint(1) not null default 0,

  -- Record metadata
  create_timestamp timestamp not null default now(),
  update_timestamp timestamp not null default now() on update now(),

  -- Indexes
  primary key (code)
)
engine InnoDB,
character set utf8mb4
collate utf8mb4_unicode_ci;





create table i18n_components (
  code varchar(255) not null,
  description varchar(255) not null,

  -- Record metadata
  create_timestamp timestamp not null default now(),
  update_timestamp timestamp not null default now() on update now(),

  -- Indexes
  primary key (code)
)
engine InnoDB,
character set utf8mb4
collate utf8mb4_unicode_ci;





create table i18n_labels (
  id int unsigned not null auto_increment,
  code varchar(255) not null,
  component_code varchar(255) not null,
  description varchar(255) not null,

  -- Record metadata
  create_timestamp timestamp not null default now(),
  update_timestamp timestamp not null default now() on update now(),

  -- Indexes
  primary key (id),

  -- Constraints
  constraint fk_i18n_labels_component_code
    foreign key (component_code) references i18n_components (code)
)
engine InnoDB,
character set utf8mb4
collate utf8mb4_unicode_ci;





create table i18n_translations (
  label_id int unsigned not null,
  language_code varchar(255) not null,
  label_text text not null,

  -- Record metadata
  create_timestamp timestamp not null default now(),
  update_timestamp timestamp not null default now() on update now(),

  -- Indexes
  primary key (label_id, language_code),

  -- Constraints
  constraint fk_i18n_translations_label_id
    foreign key (label_id) references i18n_labels (id),
  constraint fk_i18n_translations_language_code
    foreign key (language_code) references i18n_languages (code)
)
engine InnoDB,
character set utf8mb4
collate utf8mb4_unicode_ci;

