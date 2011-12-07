use flyhalf;

create table if not exists team (
        id                              int                             not null auto_increment,
        name	varchar(100),
	description text,
        unique  key name ( name ),
	current_sprint int references sprint(id),
	daily_developer_capacity int default 5,
	daily_developer_capacity_units int references estimate_unit(id),
        primary key ( id )
) ENGINE=InnoDB;

create table if not exists team_sprints (
       team_id int not null references team(id),
       sprint_id int not null references sprint(id),
       primary key (team_id, sprint_id)
) ENGINE=InnoDB;

create table if not exists users (
        id                      int             not null auto_increment,
        username                varchar(50)     not null,
        password                varchar(74)     not null,
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

create table if not exists user_assigned_tasks (
       user_id int not null references users(id),
       task_id int not null references task(id),
       primary key ( user_id, task_id )
)  ENGINE=InnoDB;

create table if not exists project (
  id                              int                             not null auto_increment,
  state_id			  int not null references states(id),
  name				  varchar(200) not null,
  description			  text,
  start_date			  timestamp,
  projected_end_date		  timestamp,
  end_date			  timestamp,
  created_by			  int references users(id),
  created_date			  timestamp,
  archived			  tinyint(0),
  primary key ( id )  
)  ENGINE=InnoDB;

create table if not exists project_sprints (
       project_id int not null references project(id),
       sprint_id int not null references sprint(id),
       primary key (project_id, sprint_id)
)  ENGINE=InnoDB;


create table if not exists sprint (
  id                              int                             not null auto_increment,
  name				  varchar(200) not null,
  description			  text,
  team_id			  int references team(id),
  start_date			  timestamp,
  sprint_length			  int not null default 14,
  end_date			  timestamp,
  created_by			  int references users(id),
  created_date			  timestamp,
  archived			  tinyint(0),
  primary key ( id )  
)  ENGINE=InnoDB;

create table if not exists sprint_unavailability (
  id                              int                             not null auto_increment,
  user_id			  int references users(id),
  start_date			  timestamp,
  start_half_day		  tinyint(1),
  end_date			  timestamp,
  end_half_day		  	  tinyint(1),
  primary key ( id )  
)  ENGINE=InnoDB;

create table if not exists story (
  id                              int                             not null auto_increment,
  sprint 			  int not null references sprint(id),
  priority 			  int not null default 100,
  estimate 			  int,
  estimate_unit 		  int references estimate_unit(id),
  name				  varchar(200) not null,
  summary			  text,  
  description			  text,
  start_date			  timestamp,
  end_date			  timestamp,
  state_id			  int not null references state(id),
  primary key ( id )  
)  ENGINE=InnoDB;

create table if not exists task (
  id                              int                             not null auto_increment,
  estimate 			  int,
  estimate_unit 		  int references estimate_unit(id),
  story_id 			  int references story(id),
  reviewed_by 			  int references users(id),
  name				  varchar(200) not null,
  summary			  text,  
  description			  text,
  start_date			  timestamp,
  end_date			  timestamp,
  state_id			  int not null references state(id),
  primary key ( id )                
)  ENGINE=InnoDB;

create table if not exists task_dependancies ( 
   task      	    	   int not null references task(id),
   block_state 	    	   tinyint(1),
   blocking_task    	   int not null references task(id),
   primary key(task, blocking_task)
)  ENGINE=InnoDB;

create table if not exists task_assigned_to (
   id                              int                             not null auto_increment,
   assigned_from_date 		   timestamp not null,
   assigned_to_date 		   timestamp,
   user_id 			   int not null references users(id),
   task_id 			   int not null references task(id),
   key (user_id, task_id),
   primary key ( id )                
)  ENGINE=InnoDB;


create table if not exists state (
   id                             int                             not null auto_increment,
   name				  varchar(200) not null,
   description			  text,
   next_state			  int references state(id),
   next_state_requirement	  text,
   primary key ( id )                
)  ENGINE=InnoDB;


create table if not exists state_transitions (
   id                             int                             not null auto_increment,
   name				  varchar(200) not null,
   primary key ( id )                       
) ENGINE=InnoDB;

create table if not exists estimate_unit (
   id                              int                             not null auto_increment,
   name				   varchar(20) not null,
   abbreviation			   varchar(4),
   primary key ( id )
)  ENGINE=InnoDB;

create table if not exists checklist (
   id                              int                             not null auto_increment,
   name				   varchar(200) not null,
   task				   int references task(id), 
   primary key ( id )
)  ENGINE=InnoDB;

create table if not exists checklist_items (
   id                              int                             not null auto_increment,
   name				   varchar(200) not null,
   checklist			   int references checklist(id),
   primary key ( id )
)  ENGINE=InnoDB;
