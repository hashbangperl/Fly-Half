package testdata;
use strict;

use FlyHalf::Schema;

my $schema = FlyHalf::Schema->connect(
    "dbi:mysql:dbname=flyhalf",
    'flyhalfuser','scrumta4stic'
);

sub populate_db {
    my $unit = _add_capacity_units;
    my ($teams,$users) = _add_users_teams($unit);
    my $sprints = _add_sprints($teams, $users);
    return;
}

sub cleandown_db {
    $schema->resultset('Team')->delete;
    $schema->resultset('User')->delete;
    $schema->resultset('Sprint')->delete;
    $schema->resultset('EstimateUnit')->delete;
}


######################

sub _add_capacity_units {
    my $unit = $schema->resultset('EstimateUnit')->create({ name => "hours", abbreviation => 'h' });
    return $unit;
}

sub _add_users_teams {
    my ($unit) = @_;
    my $default_args = { daily_developer_capacity_units => $unit->id }

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

    my $users = [
		 $users_rs->create({
				   username => 'test_user',
				   password => 'test_password',
				   email    => 'foo@bar.tld',
				   location => 'Truro',
				   firstname => 'Test',
				   surname  => 'User',
				   active => 1,
				   team => $team1->id
				  }),

		 $users_rs->create({
				   username => 'test_user2',
				   password => 'test_password',
				   email    => 'foo2@bar.tld',
				   location => 'Truro',
				   firstname => 'Anne-Other',
				   surname  => 'User',
				   active => 1,
				   team => $team1->id
				   }),
		 $users_rs->create({
				   username => 'test_user3',
				   password => 'test_password',
				   email    => 'foo3@bar.tld',
				   location => 'Truro',
				   firstname => 'Aaron-Other',
				   surname  => 'User',
				   active => 1,
				   team => $team1->id
				  }),
		 $users_rs->create({
				   username => 'test1',
				   password => 'test_password',
				   email    => 'foo1a@bar.tld',
				   location => 'Truro',
				   firstname => 'Fred',
				   surname  => 'Ubbba',
				   active => 1,
				   team => $team2->id
				  }),
		 $users_rs->create({
				   username => 'test2',
				   password => 'test_password',
				   email    => 'foo2b@bar.tld',
				   location => 'Truro',
				   firstname => 'Irma',
				   surname  => 'Wanna',
				   active => 1,
				   team => $team2->id
				  }),
		 $users_rs->create({
				   username => 'test3',
				   password => 'test_password',
				   email    => 'foo3a@bar.tld',
				   location => 'London',
				   firstname => 'Ian',
				   surname  => 'Drury',
				   active => 1,
				   team => $team2->id
				  })
		];

    return ($teams, $users);
}

sub _add_sprints {
    my ($teams, $users) = @_;
    my $sprint = $schema->resultset('sprint')->create({
						       name => 'initial prototype',
						       description => 'initial prototype of flyhalf',
						       team_id => $teams[0]->id,
						       start_date => \'now()',
						       created_by => $users[0]->id,
						       created_date => \'now()',
						      });


    return [$sprint];
}

1;
