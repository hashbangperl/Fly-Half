use flyhalf;

create table if not exists team (
        id                              int                             not null auto_increment,
        name	varchar(100),
	description text,
        unique  key name ( name ),
        primary key ( id )
) ENGINE=InnoDB;

create table if not exists user (
        id                              int                             not null auto_increment,
        username                varchar(50)             not null,
        password                varchar(74)             not null,
        email                   varchar(200)    not null,

        firstname               varchar(50)             ,
        surname                 varchar(50)             ,

        profile_pic             varchar(100)    ,
        profile_description     text                    ,

        location                varchar(100)    ,

        active                  int                             not null default 1,
	team			int		references team(id),

        unique  key username ( username ),
        primary key ( id )
)  ENGINE=InnoDB;

create table if not exists project (

)  ENGINE=InnoDB;

create table if not exists story (

)  ENGINE=InnoDB;

create table if not exists task (

)  ENGINE=InnoDB;

create table if not exists checklist (

)  ENGINE=InnoDB;

create table if not exists checklist_items (

)  ENGINE=InnoDB;
