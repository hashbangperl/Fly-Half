use flyhalf;

create table if not exists estimate_unit (
   id                              int not null auto_increment,
   name				   varchar(20) not null,
   abbreviation			   varchar(4),
   primary key ( id )
)  ENGINE=InnoDB;


create table if not exists team (
        id                              int                             not null auto_increment,
        name	varchar(100),
	description text,
        unique  key name ( name ),
	current_sprint int references sprint(id),
	daily_developer_capacity int default 5,
	daily_developer_capacity_units int,
	created_date			  datetime,
  	updated_date			  datetime,
	foreign key (daily_developer_capacity_units) references estimate_unit(id),
        primary key ( id )
) ENGINE=InnoDB;

create table if not exists users (
        id                      int             not null auto_increment,
        username                varchar(50)     not null,
        password                varchar(74)     not null,
        email                   varchar(200)    not null,
        firstname               varchar(50),
        surname                 varchar(50),
        profile_pic             varchar(100),
        profile_description     text,
        location                varchar(100),
        active                  int not null default 1,
	team			int,
        unique  key username ( username ),
        primary key ( id )
)  ENGINE=InnoDB;

create table if not exists team_users (
   team_id int not null,
   user_id int not null,
   foreign key (team_id) references team(id),
   foreign key (user_id) references users(id),
   primary key (user_id, team_id)
)  ENGINE=InnoDB;

create table if not exists state (
   id                             int not null auto_increment,
   name				  varchar(200) not null,
   description			  text,
   primary key ( id )                
)  ENGINE=InnoDB;

create table state_transition (
   id                             int not null auto_increment,
   name                           varchar(200) not null,
   from_state			  int not null,
   to_state			  int not null,
   requirement			  text,
   primary key ( id ),
   foreign key (from_state)	  references state(id),
   foreign key (to_state)       references state(id)
) ENGINE=InnoDB;

create table if not exists project (
  id                              int not null auto_increment,
  state_id			  int not null,
  name				  varchar(200) not null,
  description			  text,
  start_date			  datetime,
  projected_end_date		  datetime,
  end_date			  datetime,
  created_by			  int,
  created_date			  datetime,
  updated_date			  datetime,
  archived			  tinyint(0),
  foreign key (state_id) references state(id),
  foreign key (created_by) references users(id),
  primary key ( id )  
)  ENGINE=InnoDB;


create table if not exists sprint (
  id                              int  not null auto_increment,
  ref_code 			  varchar(100) not null,
  name				  varchar(200) not null,
  description			  text,
  team_id			  int,
  start_date			  datetime,
  sprint_length			  int not null default 14,
  end_date			  datetime,
  created_by			  int,
  created_date			  datetime,
  updated_date			  datetime,
  in_progress			  tinyint(1) default 0,
  archived			  tinyint(1) default 0,
  foreign key (created_by) references users(id),
  foreign key (team_id) references team(id),
  primary key ( id )  
)  ENGINE=InnoDB;

create table if not exists team_sprints (
       team_id int not null,
       sprint_id int not null,
       created_by			  int,
       created_date			  datetime,
       foreign key (created_by) 	  references users(id),
       foreign key (team_id) references team(id),
       foreign key (sprint_id) references sprint(id),
       primary key (team_id, sprint_id)
) ENGINE=InnoDB;


create table if not exists sprint_capacity (
       sprint_id int not null,
       sprint_day datetime not null,
       day_capacity int not null default 0,
       foreign key (sprint_id) references sprint(id),
       primary key (sprint_id, sprint_day)
) ENGINE=InnoDB;


create table if not exists project_sprints (
       project_id int not null,
       sprint_id int not null,
       created_by			  int,
       created_date			  datetime,
       foreign key (project_id) references project(id),
       foreign key (sprint_id) references sprint(id),
       foreign key (created_by) 	  references users(id),
       primary key (project_id, sprint_id)
)  ENGINE=InnoDB;


create table if not exists sprint_unavailability (
  id                              int                             not null auto_increment,
  user_id			  int not null,
  start_date			  datetime,
  start_half_day		  tinyint(1),
  end_date			  datetime,
  end_half_day		  	  tinyint(1),
  created_by			  int,
  created_date			  datetime,
  updated_date			  datetime,
  foreign key (user_id) references users(id),
  foreign key (created_by) 	  references users(id),
  primary key ( id )  
)  ENGINE=InnoDB;

create table if not exists story (
  id                              int not null auto_increment,
  ref_code                        varchar(100) not null,
  priority 			  int not null default 100,
  estimate 			  int,
  estimate_unit 		  int,
  remaining_work		  int,
  completed_work		  int,
  name				  varchar(200) not null,
  summary			  text,  
  description			  text,
  start_date			  datetime,
  end_date			  datetime,
  state_id			  int not null,
  created_by			  int,
  created_date			  datetime,
  updated_date			  datetime,
  foreign key (sprint) references sprint(id),
  foreign key (estimate_unit) references estimate_unit(id),
  foreign key (state_id) references state(id),
  foreign key (created_by) 	  references users(id),
  primary key ( id )  
)  ENGINE=InnoDB;

create table object_stories (
   story_id                    int not null,
   object_id                       int not null,
   foreign key (story_id)           references task(id),
   object_type                     varchar(128),
   primary key (story_id, object_id, object_type)
)  ENGINE=InnoDB;



create table if not exists stories_tree (
    story                INT NOT NULL, 
    ancestor            INT,
    depth               INT NOT NULL default 0,
    PRIMARY KEY ( story, ancestor ),
    foreign key (story)            REFERENCES story(id),
    foreign key (ancestor)        references story(id)
)  ENGINE=InnoDB;


create table if not exists task (
  id                              int  not null auto_increment,
  ref_code                        varchar(100) not null,
  estimate 			  int,
  estimate_unit 		  int,
  remaining_work		  int,
  completed_work		  int,
  reviewed_by 			  int,
  name				  varchar(200) not null,
  summary			  text,  
  description			  text,
  start_date			  datetime,
  end_date			  datetime,
  state_id			  int not null,
  created_by			  int,
  created_date			  datetime,
  updated_date			  datetime,
  foreign key (estimate_unit) 	  references estimate_unit(id),
  foreign key (created_by) 	  references users(id),
  foreign key (state_id)	  references state(id),
  primary key ( id )                
)  ENGINE=InnoDB;

create table if not exists tasks_tree (
    task                INT NOT NULL,
    ancestor            INT,
    depth               INT NOT NULL default 0,
    PRIMARY KEY ( task, ancestor ),
    foreign key (task)            REFERENCES task(id),
    foreign key (ancestor)        references task(id)
)  ENGINE=InnoDB;

create table if not exists task_dependancies ( 
   task      	    	   int not null,
   block_state 	    	   tinyint(1),
   blocking_task    	   int not null,
   created_by			  int,
   created_date			  datetime,
   foreign key (task) 	   references task(id),
   foreign key (blocking_task) references task(id),
   foreign key (created_by) 	  references users(id),
   primary key(task, blocking_task)
)  ENGINE=InnoDB;

create table object_tasks (
   task_id                    int not null,
   object_id                       int not null,
   foreign key (task_id)           references task(id),
   object_type                     varchar(128),
   primary key (task_id, object_id, object_type)
)  ENGINE=InnoDB;

create table if not exists assigned_to_user (
   id                              int not null auto_increment,
   assigned_from_date 		   datetime not null,
   assigned_to_date 		   datetime,
   user_id 			   int not null,
   object_id 			   int not null,
   foreign key (user_id) 	   references users(id),
   object_type                     varchar(128),
   key (user_id, object_id, object_type),
   primary key ( id )                
)  ENGINE=InnoDB;

create table if not exists sprint_progress (
   sprint_id 			   int not null,
   story_id			   int not null,
   remaining_work		   int not null,
   estimated_work		   int not null,
   progress_date		   datetime,
   foreign key (sprint_id) 	   references sprint(id),
   primary key (sprint_id, progress_date)                
)  ENGINE=InnoDB;


create table if not exists checklist (
   id                              int not null auto_increment,
   name				   varchar(200) not null,
   created_by			   int,
   created_date			   datetime,
   updated_date			   datetime,
   foreign key (created_by) 	   references users(id),
   primary key ( id )
)  ENGINE=InnoDB;

create table if not exists checklist_items (
   id                              int not null auto_increment,
   name				   varchar(200) not null,
   checklist			   int,
   created_by			   int,
   created_date			   datetime,
   foreign key (checklist) 	   references checklist(id),
   foreign key (created_by) 	   references users(id),
   primary key ( id )
)  ENGINE=InnoDB;

create table if not exists category (
   id                              int not null auto_increment,
   name                            varchar(200) not null,
   description                     text,
   created_by                      int,
   created_date                    datetime,
   primary key (id)
)  ENGINE=InnoDB;

create table if not exists categorisation (
   object			   varchar(255) not null,
   object_id			   int not null,
   relation_name                   varchar(255),
   category			   int not null,
   added_by                        int not null,
   added_date                      datetime,
   primary key (object, object_id, category),
   foreign key (category)	   references category(id)
)  ENGINE=InnoDB;

create table if not exists role (
   id                              int not null auto_increment,
   parent_id			   int,
   name                            varchar(200) not null,
   token			   varchar(20) not null,
   description                     text,
   created_by                      int,
   created_date                    datetime,
   foreign key parent ( parent_id ) references role(id),
   primary key (id)
) ENGINE=InnoDB;


create table if not exists users_roles (
   user_id int not null,
   role_id int not null,
   primary key (user_id, role_id),
   foreign key (role_id) references role(id),
   foreign key (user_id) references users(id)
) ENGINE=InnoDB;

create table if not exists user_object_roles (
   user_id int not null,
   role_id int not null,
   object                          varchar(255) not null,
   object_id                       int not null,
   foreign key (role_id) references role(id),
   foreign key (user_id) references users(id),
   created_by 			   int not null,
   foreign key (created_by) references users(id),
   created_date                    datetime,
   primary key (user_id, role_id, object, object_id)
) ENGINE=InnoDB;

create table if not exists actions (
   id                              int not null auto_increment,
   name				   varchar(255) not null,
   description			   text,
   primary key (id)
) ENGINE=InnoDB;

create table if not exists actions_objects (
   id                              int not null auto_increment,
   action_id                          int not null,
   foreign key (action_id) references actions(id),
   object                          varchar(255) not null,
   object_id                       int not null,
   comment			   text,
   action_by 		           int not null,
   foreign key (action_by) references users(id),
   action_time datetime,
   primary key (id)
) ENGINE=InnoDB;

create table board (
   id                              int not null auto_increment,
   name                            varchar(200) not null,
   board_type                      ENUM('KANBAN', 'SCRUM', 'OTHER'),
   description                     text,
   updated_date			   datetime,
   updated_by			   int,
   created_by                      int,
   created_date                    datetime,
   foreign key (created_by) references users(id),
   foreign key (updated_by) references users(id),
   primary key (id)
) ENGINE=InnoDB;

create table board_column (
   id                              int not null auto_increment,
   name                            varchar(200) not null,
   updated_date                    datetime,
   board_id                        int not null,
   updated_by                      int,
   created_by                      int,
   created_date                    datetime,
   foreign key (created_by) references users(id),
   foreign key (updated_by) references users(id),
   foreign key (board_id) references board(id),
   primary key (id)
) ENGINE=InnoDB;

create table board_column_states (
  state_id    int not null,
  board_column_id int not null,
  foreign key (state_id) references state(id),
  foreign key (board_column_id) references board_column(id),
  primary key (state_id, board_column_id) 
) ENGINE=InnoDB;

