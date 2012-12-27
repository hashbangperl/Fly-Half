package testdata;
use strict;

use DateTime;
use DateTime::Duration;
use FlyHalf::Schema;
use Data::Dumper;

my $schema = FlyHalf::Schema->connect(
    "dbi:mysql:dbname=flyhalf",
    'flyhalfuser','scrumta4stic'
);

my $unit;
my ($teams,$users);
my $sprints;
my $tasks;
my $states = [];
my $boards = { };

my $dur = DateTime::Duration->new(
    years       => 3,
    months      => 5,
    weeks       => 1,
    days        => 1,
    hours       => 6,
    minutes     => 15,
    seconds     => 45,
    nanoseconds => 12000
);

my $now = DateTime->now();

my $current_sprints_days = ();

my $historical_sprints;

sub populate_db {
    $unit = _add_capacity_units();
    _add_states();
    warn "states : ", map {$_->name . $_->id} @$states;
    $boards = _add_boards();
    ($teams,$users) = _add_users_teams($unit);
    $sprints = _add_sprints($teams, $users);
     _add_stories_tasks();

    return;
}

sub cleandown_db {
    $schema->resultset('AssignedToUser')->delete;
    $schema->resultset('ObjectTask')->delete;
    $schema->resultset('Task')->delete;
    $schema->resultset('ObjectStory')->delete;
    $schema->resultset('Story')->delete;
    $schema->resultset('Sprint')->delete;
    $schema->resultset('TeamUser')->delete;
    $schema->resultset('Team')->delete;
    $schema->resultset('User')->delete;
    $schema->resultset('EstimateUnit')->delete;
    $schema->resultset('BoardColumnState')->delete;
    $schema->resultset('BoardColumn')->delete;
    $schema->resultset('Board')->delete;
    $schema->resultset('State')->delete_all;
}


######################

sub _add_capacity_units {
    my $unit = $schema->resultset('EstimateUnit')->create({ name => "hours", abbreviation => 'h' });
    my $other = $schema->resultset('EstimateUnit')->create({ name => "points", abbreviation => 'p' });
    return $unit;
}

sub _add_states {
    my $rs = $schema->resultset('State');

    my $captured = $rs->create({ name => 'captured', description => 'Story not complete, needs to be defined'});
    my $complete = $rs->create({ name => 'complete', description => 'Story completed and signed off' });
    my $qa = $rs->create({ name => 'quality assurance', description => 'Story is in QA' });
    my $started = $rs->create({ name => 'started', description => 'Story in progress',});
    my $defined = $rs->create({ name => 'defined', description => 'Story ready to start',});

    $states = [ $captured, $defined, $started, $qa, $complete ];
}


sub _add_boards {
    my $scrum_board = $schema->resultset('Board')->create({
        name => 'Scrum Taskboard 1',
        board_type => 'SCRUM',
        description => 'Scrum taskboard',
        board_columns => [
            { name => 'Planned', display_order => 1, board_column_states => [ { state_id => $states->[0]->id}, { state_id => $states->[1]->id} ]},
            { name => 'Design/Development', display_order => 2, board_column_states => [ { state_id => $states->[2]->id} ]},
            { name => 'QA', display_order => 3, board_column_states => [ { state_id => $states->[3]->id } ]},
            { name => 'Delivered', display_order => 4, board_column_states => [ { state_id => $states->[4]->id} ]},
        ],
    });

    my $kanban_board =  $schema->resultset('Board')->create({
        name => 'Kanban 1',
        board_type => 'KANBAN',
        description => 'Kanban limited WIP',
        board_columns => [
            { name => 'Queued',  display_order => 1, board_column_states => [ { state_id => $states->[0]->id}, { state_id => $states->[1]->id} ]},
            { name => 'In Progress', display_order => 2, board_column_states => [ { state_id => $states->[2]->id }]},
            { name => 'QA', display_order => 3, board_column_states => [ { state_id =>  $states->[3]->id} ]},
            { name => 'Delivered', display_order => 4, board_column_states => [ { state_id => $states->[4]->id } ]},
        ],
    });

    $boards = [kanban => $kanban_board, scrum => $scrum_board];


    return;
}

sub _add_users_teams {
    my ($unit) = @_;
    my $default_args = { daily_developer_capacity_units => $unit->id };

    # Add teams and roles
    my $teams = [
		 $schema->resultset('Team')->create({
						     name => 'team 1', description => 'test 1',
						    }),
		 $schema->resultset('Team')->create({
						     name => 'team 2', description => 'test 2',
						    })
		];

    my $users_rs = $schema->resultset('User');



    my $users = [ ];
	my $user = $users_rs->create({
				   username => 'test_user',
				   password => 'test_password',
				   email    => 'foo@bar.tld',
				   location => 'Truro',
				   firstname => 'Test',
				   surname  => 'User',
				   active => 1,
				  });
    $user->create_related('user_teams' => {team_id =>  $teams->[0]->id} );
    push (@$users, $user);
    # you are here

    $user = $users_rs->create({
				   username => 'test_user2',
				   password => 'test_password',
				   email    => 'foo2@bar.tld',
				   location => 'Truro',
				   firstname => 'Anne-Other',
				   surname  => 'User',
				   active => 1,
				   });
    $user->create_related('user_teams' => {team_id =>  $teams->[0]->id} );
    push (@$users, $user);

    $user = $users_rs->create({
				   username => 'test_user3',
				   password => 'test_password',
				   email    => 'foo3@bar.tld',
				   location => 'Truro',
				   firstname => 'Aaron-Other',
				   surname  => 'User',
				   active => 1,
				  });
    $user->create_related('user_teams' => {team_id =>  $teams->[0]->id} );
    push (@$users, $user);

    $user = $users_rs->create({
				   username => 'test1',
				   password => 'test_password',
				   email    => 'foo1a@bar.tld',
				   location => 'Truro',
				   firstname => 'Fred',
				   surname  => 'Ubbba',
				   active => 1,
				  });
    $user->create_related('user_teams' => {team_id =>  $teams->[0]->id} );
    push (@$users, $user);

    $user = $users_rs->create({
				   username => 'test2',
				   password => 'test_password',
				   email    => 'foo2b@bar.tld',
				   location => 'Truro',
				   firstname => 'Irma',
				   surname  => 'Wanna',
				   active => 1,
				  });
    $user->create_related('user_teams' => {team_id =>  $teams->[1]->id} );
    push (@$users, $user);

    $user = $users_rs->create({
        username => 'test3',
        password => 'test_password',
        email    => 'foo3a@bar.tld',
        location => 'London',
        firstname => 'Ian',
        surname  => 'Drury',
        active => 1,
    });
    $user->create_related('user_teams' => {team_id =>  $teams->[1]->id} );
    push (@$users, $user);

    return ($teams, $users);
}

sub _add_sprints {
    my ($teams, $users) = @_;
    my $sprint1 = $schema->resultset('Sprint')->create({
							ref_code => 'sp4',
							name => 'initial prototype',
							description => 'initial prototype of flyhalf',
							team_id => $teams->[0]->id,
							start_date => \q{now()},
							created_by => $users->[0]->id,
							in_progress => 1,
						      });


    my $sprint2 = $schema->resultset('Sprint')->create({
							ref_code => 'sp5',
							name => 'Research stuff',
							description => 'research stuff for other projects',
							team_id => $teams->[1]->id,
							start_date => \q{now()},
							created_by => $users->[4]->id,
							in_progress => 1,
						       });
    $teams->[0]->current_sprint($sprint1->id);
    $teams->[0]->update();

    $teams->[1]->current_sprint($sprint2->id);
    $teams->[1]->update();


    return [$sprint1, $sprint2];
}

my $bacon_ipsum = [
    'Bacon ipsum dolor sit amet swine filet mignon leberkäse, tenderloin turducken bacon rump. Bacon pork jowl, t-bone bresaola sirloin ham hock pastrami boudin ribeye swine pork chop salami beef. Jerky venison corned beef, cow t-bone short loin kielbasa tri-tip capicola leberkäse beef bresaola rump tenderloin bacon. Flank venison t-bone, shoulder turducken pig pork loin short ribs tail. Sirloin venison short loin bacon prosciutto, tail meatloaf turkey fatback hamburger t-bone pig jerky. Ribeye swine turducken, leberkäse chicken rump ham shank beef ribs chuck beef t-bone meatloaf pork chop ham hock. Frankfurter filet mignon fatback drumstick.',
    'Strip steak pork chop shoulder chuck ground round pig. Pork flank t-bone prosciutto, short loin chicken pastrami shankle frankfurter boudin hamburger shank strip steak. Shankle cow venison chuck short loin. Beef ribs biltong venison rump. Drumstick filet mignon sausage, tri-tip pastrami beef tongue ribeye chicken ground round. Ham hamburger pancetta spare ribs tail. Andouille leberkäse jowl tail ball tip ribeye turkey hamburger, short loin bacon pork chop pastrami.',
    'Rump ribeye bresaola flank cow. Bresaola turducken leberkäse fatback ham hock, meatloaf boudin brisket shoulder. Bresaola short loin short ribs prosciutto chuck, shoulder corned beef brisket meatball pork turkey fatback. Strip steak spare ribs drumstick capicola, flank short loin chuck filet mignon andouille. Tri-tip capicola shoulder, pastrami chicken fatback pork belly filet mignon bacon. Frankfurter meatball swine filet mignon hamburger. Pork chop t-bone ball tip drumstick chicken, ham hock beef ribs hamburger andouille tongue shoulder pork belly short ribs pork turkey.'
    ];



sub _add_stories_tasks {
    $sprints->[0]->add_to_stories(
				  {
				   ref_code => "s8",
				   priority => 10, estimate => 5, estimate_unit => $unit->id, remaining_work => 5, completed_work => 0,
				   name => 'add users to project', summary => 'As a scrum master I need to be able to add users to the tool',
				   description => $bacon_ipsum->[0], start_date => $now, state => $states->[1],
				   created_by => $users->[2],
				  });

    my $task = $schema->resultset('Task')->create(
					     { name => 'basic form/action', estimate => 3, estimate_unit => $unit->id,
					       remaining_work => 3, completed_work => 1, start_date => \q{now()}, state => $states->[3],
					       description => $bacon_ipsum->[2], ref_code => 't1'
					     });
    $schema->resultset('ObjectTask')->create({
        task_id => $task->id, object_id => $sprints->[0]->id, object_type => 'story'
    });
    $schema->resultset('AssignedToUser')->create(
						   { object_id => $task->id, object_type => 'task', assigned_from_date => \q{now()}, user_id => $users->[0]->id, }
                       );

    $task = $schema->resultset('Task')->create(
					     { name => 'form validation, updated metrics', estimate => 4, estimate_unit => $unit->id,
					       remaining_work => 4, completed_work => 0, start_date => \q{now()}, state => $states->[2],
					       description => $bacon_ipsum->[1], , ref_code => 't2'
                       });

    $schema->resultset('ObjectTask')->create({
        task_id => $task->id, object_id => $sprints->[0]->id, object_type => 'story'
    });
    $schema->resultset('AssignedToUser')->create(
						   { object_id => $task->id, object_type => 'task', assigned_from_date => \q{now()}, user_id => $users->[1]->id, }
                       );


    $sprints->[0]->add_to_stories({
				   ref_code => "s9",
				   priority => 10, estimate => 5, estimate_unit => $unit->id, remaining_work => 5, completed_work => 0,
				   name => 'add users to project', summary => 'As a scrum master I need to be able to get a burndown from the tool',
				   description => $bacon_ipsum->[0], start_date => $now, state => $states->[1],
				   created_by => $users->[1],
               });


    $task = $schema->resultset('Task')->create(
        { name => 'track progress and capacoty', estimate => 3, estimate_unit => $unit->id,
          remaining_work => 3, completed_work => 1, start_date => \q{now()}, state => $states->[2],
          description => $bacon_ipsum->[2], , ref_code => 't3'
      });

    $schema->resultset('ObjectTask')->create({
        task_id => $task->id, object_id => $sprints->[0]->id, object_type => 'story'
    });

    $schema->resultset('AssignedToUser')->create(
        { object_id => $task->id, object_type => 'task', assigned_from_date => \q{now()}, user_id => $users->[1]->id, }
    );

    my $story = $schema->resultset('Story')->create(
        {
            ref_code => "s19",
            priority => 10, estimate => 5, estimate_unit => $unit->id, remaining_work => 5, completed_work => 0,
            name => 'add stories', summary => 'As a scrum master I need to be able to add stories to the backlog',
            description => $bacon_ipsum->[0], start_date => \q{now()}, state => $states->[1],
            created_by => $users->[2]
        });
    $schema->resultset('AssignedToUser')->create(
        { object_id => $story->id, object_type => 'story', assigned_from_date => \q{now()}, user_id => $users->[4]->id, }
    );

    $schema->resultset('AssignedToUser')->create(
        { object_id => $story->id, object_type => 'story', assigned_from_date => \q{now()}, user_id => $users->[3]->id, }
    );

    $task = $schema->resultset('Task')->create(

					     { name => 'basic form/action', estimate => 3, estimate_unit => $unit->id,
					       remaining_work => 3, completed_work => 1, start_date => \q{now()}, state => $states->[1],
					       description => $bacon_ipsum->[2], , ref_code => 't4'
					     });
    $schema->resultset('AssignedToUser')->create(
        { object_id => $task->id, object_type => 'task', assigned_from_date => \q{now()}, user_id => $users->[4]->id, }
    );

    $task = $schema->resultset('Task')->create(
					     { name => 'form validation, updated metrics', estimate => 4, estimate_unit => $unit->id,
					       remaining_work => 4, completed_work => 0, start_date => \q{now()}, state => $states->[1],
					       description => $bacon_ipsum->[1], ref_code => 't5'

					     },
				 );
    $schema->resultset('AssignedToUser')->create(
        { object_id => $task->id, object_type => 'task', assigned_from_date => \q{now()}, user_id => $users->[5]->id, }
    );
    $schema->resultset('AssignedToUser')->create(
        { object_id => $task->id, object_type => 'task', assigned_from_date => \q{now()}, user_id => $users->[3]->id, }
    );

    $task = $schema->resultset('Task')->create(
        { name => 'draw graph', estimate => 4, estimate_unit => $unit->id,
          remaining_work => 4, completed_work => 0, state => $states->[0],
          description => $bacon_ipsum->[1],
      });

    $schema->resultset('AssignedToUser')->create(
        { object_id => $task->id, object_type => 'task', assigned_from_date => \q{now()}, user_id => $users->[0]->id, }
    );

    $schema->resultset('TaskPlanningDate')->create({task => $task, planning_date => 1});

    return;
}

1;
