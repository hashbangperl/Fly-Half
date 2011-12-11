use utf8;
package FlyHalf::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

FlyHalf::Schema::Result::User

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<users>

=cut

__PACKAGE__->table("users");

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
  "team",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
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

=head1 RELATIONS

=head2 projects

Type: has_many

Related object: L<FlyHalf::Schema::Result::Project>

=cut

__PACKAGE__->has_many(
  "projects",
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

=head2 sprints

Type: has_many

Related object: L<FlyHalf::Schema::Result::Sprint>

=cut

__PACKAGE__->has_many(
  "sprints",
  "FlyHalf::Schema::Result::Sprint",
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

=head2 team

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::Team>

=cut

__PACKAGE__->belongs_to(
  "team",
  "FlyHalf::Schema::Result::Team",
  { id => "team" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07014 @ 2011-12-11 06:28:16
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Q7P4JvZD7shBetHjlsX+MQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
