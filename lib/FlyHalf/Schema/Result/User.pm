package FlyHalf::Schema::Result::User;
use strict;
use warnings;

=head1 NAME

FlyHalf::Schema::Result::User

=cut

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");

=head1 TABLE: C<users>

=cut

__PACKAGE__->table("users");

=head1 METHODS

=head2 has_role

Object method providing a check that a user has appropriate role, checking
roles against a given object, i.e. a Team if provided

Takes hashref of arguments role is arrayref, object and object id are optional

my $ok = $user->has_object_role({ role => [ ROLE_TOKEN, .. ], object => 'team', object_id => $team_id });

=cut

my $roles;
sub has_object_role {
    my ( $self, $args ) = @_;
    my $roles = $args->{roles};

    $self->_check_roles($roles);

    my $schema = $self->result_source->schema;

#     my $has_role = $schema->resultset( $table )->search(
#         {
#             -and => {
#                 'me.id' => $args->{object_id},
#                 -or => [
#                     'me.user_id' => $c->user->id,
#                     'users_groups.user_id' => $c->user->id,
#                 ]
#             },
#         },
#         { join => { 'groups' => 'users_groups' } },
#     )->count;

#     unless ($authorised) {
#         return $self->user_authorised_for_action({
#             roles => [$args->{role}],
#             action => $args->{permission},
#             redirect => $args->{redirect}
#         });
#     }

#     return $authorised;
    return 1;
}

sub _check_roles {
    my ($self, $roles) = @_;
    $self->_get_valid_roles;
    foreach my $role (@$roles) {
        unless ($roles->{ $role }) {
            die "[ERROR] tried to check with unrecognised role ($role)." ;
        }
    }
    return 1;
}

sub _get_valid_roles {
    my $self = shift;
    unless ( $roles ) {
        my $schema = $self->result_source->schema;
        my @roles = $schema->resultset( 'Role' )->all;
        $roles = { map { $_->name => 1 } @roles };
    }
    return $roles;
}

sub roles {
    my $self = shift;
    my $schema = $self->result_source->schema;
    return $schema->resultset( 'UsersRole' )->search(
        { user_id => $self->id},
        {
            prefetch => [qw/role/],
        }
    );
}

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 username

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=head2 password

  data_type: 'varchar'
  is_nullable: 0
  size: 74

=head2 email

  data_type: 'varchar'
  is_nullable: 0
  size: 200

=head2 firstname

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 surname

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 profile_pic

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 profile_description

  data_type: 'text'
  is_nullable: 1

=head2 location

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 active

  data_type: 'integer'
  default_value: 1
  is_nullable: 0

=head2 team

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "username",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "password",
  { data_type => "varchar", is_nullable => 0, size => 74 },
  "email",
  { data_type => "varchar", is_nullable => 0, size => 200 },
  "firstname",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "surname",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "profile_pic",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "profile_description",
  { data_type => "text", is_nullable => 1 },
  "location",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "active",
  { data_type => "integer", default_value => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<username>

=over 4

=item * L</username>

=back

=cut

__PACKAGE__->add_unique_constraint("username", ["username"]);

=head1 METHODS

=head2 fullname

=cut

sub fullname {
    my $self = shift;
    return join (' ', $self->firstname, $self->surname);
}

=head1 RELATIONS

=head2 created_checklist_items

Type: has_many

Related object: L<FlyHalf::Schema::Result::ChecklistItem>

=cut

__PACKAGE__->has_many(
  "created_checklist_items",
  "FlyHalf::Schema::Result::ChecklistItem",
  { "foreign.created_by" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 created_checklists

Type: has_many

Related object: L<FlyHalf::Schema::Result::Checklist>

=cut

__PACKAGE__->has_many(
  "created_checklists",
  "FlyHalf::Schema::Result::Checklist",
  { "foreign.created_by" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 created_project_sprints

Type: has_many

Related object: L<FlyHalf::Schema::Result::ProjectSprint>

=cut

__PACKAGE__->has_many(
  "created_project_sprints",
  "FlyHalf::Schema::Result::ProjectSprint",
  { "foreign.created_by" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 created_projects

Type: has_many

Related object: L<FlyHalf::Schema::Result::Project>

=cut

__PACKAGE__->has_many(
  "created_projects",
  "FlyHalf::Schema::Result::Project",
  { "foreign.created_by" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 sprint_unavailabilities

Type: has_many

Related object: L<FlyHalf::Schema::Result::SprintUnavailability>

=cut

__PACKAGE__->has_many(
  "sprint_unavailabilities",
  "FlyHalf::Schema::Result::SprintUnavailability",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 sprint_unavailabilities_created_by

Type: has_many

Related object: L<FlyHalf::Schema::Result::SprintUnavailability>

=cut

__PACKAGE__->has_many(
  "sprint_unavailabilities_created_by",
  "FlyHalf::Schema::Result::SprintUnavailability",
  { "foreign.created_by" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 created_sprints

Type: has_many

Related object: L<FlyHalf::Schema::Result::Sprint>

=cut

__PACKAGE__->has_many(
  "created_sprints",
  "FlyHalf::Schema::Result::Sprint",
  { "foreign.created_by" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 created_stories

Type: has_many

Related object: L<FlyHalf::Schema::Result::Story>

=cut

__PACKAGE__->has_many(
  "created_stories",
  "FlyHalf::Schema::Result::Story",
  { "foreign.created_by" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 created_task_dependancies

Type: has_many

Related object: L<FlyHalf::Schema::Result::TaskDependancy>

=cut

__PACKAGE__->has_many(
  "created_task_dependancies",
  "FlyHalf::Schema::Result::TaskDependancy",
  { "foreign.created_by" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 tasks

Type: has_many

Related object: L<FlyHalf::Schema::Result::Task>

=cut

__PACKAGE__->has_many(
  "tasks",
  "FlyHalf::Schema::Result::Task",
  { "foreign.reviewed_by" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 tasks_assigned_to

Type: has_many

Related object: L<FlyHalf::Schema::Result::TaskAssignedTo>

=cut

__PACKAGE__->has_many(
  "tasks_assigned_to",
  "FlyHalf::Schema::Result::TaskAssignedTo",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 tasks_created_by

Type: has_many

Related object: L<FlyHalf::Schema::Result::Task>

=cut

__PACKAGE__->has_many(
  "tasks_created_by",
  "FlyHalf::Schema::Result::Task",
  { "foreign.created_by" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


=head2 teams

Type: has many

Related object: L<FlyHalf::Schema::Result::Team>

=cut

__PACKAGE__->has_many('user_teams' => 'FlyHalf::Schema::Result::TeamUser', 'user_id');
__PACKAGE__->many_to_many('teams' => 'user_teams', 'team');


1;
