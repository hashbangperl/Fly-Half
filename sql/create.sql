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
	foreign key (team)	references team(id),
        unique  key username ( username ),
        primary key ( id )
)  ENGINE=InnoDB;

create table if not exists state (
   id                             int not null auto_increment,
   name				  varchar(200) not null,
   description			  text,
   next_state			  int,
   next_state_requirement	  text,
   foreign key (next_state) 	  references state(id),
   primary key ( id )                
)  ENGINE=InnoDB;

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
  sprint 			  int not null,
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

create table if not exists task (
  id                              int  not null auto_increment,
  ref_code                        varchar(100) not null,
  estimate 			  int,
  estimate_unit 		  int,
  remaining_work		  int,
  completed_work		  int,
  story_id 			  int,
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
  foreign key (story_id)	  references story(id),
  foreign key (reviewed_by) 	  references users(id),
  foreign key (created_by) 	  references users(id),
  foreign key (state_id)	  references state(id),
  primary key ( id )                
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


create table if not exists task_assigned_to (
   id                              int not null auto_increment,
   assigned_from_date 		   datetime not null,
   assigned_to_date 		   datetime,
   current_task			   tinyint(1) not null default 0,
   user_id 			   int not null,
   task_id 			   int not null,
   foreign key (user_id) 	   references users(id),
   foreign key (task_id) 	   references task(id),
   key (user_id, task_id),
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

create table if not exists state_transitions (
   id                             int not null auto_increment,
   name				  varchar(200) not null,
   primary key ( id )                       
) ENGINE=InnoDB;

create table if not exists checklist (
   id                              int not null auto_increment,
   name				   varchar(200) not null,
   task				   int,
   created_by			   int,
   created_date			   datetime,
   updated_date			   datetime,
   foreign key (task)  		   references task(id), 
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

