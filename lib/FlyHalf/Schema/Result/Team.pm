package FlyHalf::Schema::Result::Team;
use strict;
use warnings;

=head1 NAME

FlyHalf::Schema::Result::Team

=cut

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");

=head1 TABLE: C<team>

=cut

__PACKAGE__->table("team");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 description

  data_type: 'text'
  is_nullable: 1

=head2 current_sprint

  data_type: 'integer'
  is_nullable: 1

=head2 daily_developer_capacity

  data_type: 'integer'
  default_value: 5
  is_nullable: 1

=head2 daily_developer_capacity_units

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 created_date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 updated_date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 board_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "description",
  { data_type => "text", is_nullable => 1 },
  "current_sprint",
  { data_type => "integer", is_nullable => 1 },
  "daily_developer_capacity",
  { data_type => "integer", default_value => 5, is_nullable => 1 },
  "daily_developer_capacity_units",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "created_date",
  {
    data_type => "datetime",
    "datetime_undef_if_invalid" => 1,
    is_nullable => 1,
    set_on_create => 1
  },
  "updated_date",
  {
    data_type => "datetime",
    "datetime_undef_if_invalid" => 1,
    is_nullable => 1,
    set_on_create => 1,
    set_on_update => 1,
  },
  "board_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0, default => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<name>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("name", ["name"]);

=head1 RELATIONS

=head2 daily_developer_capacity_unit

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::EstimateUnit>

=cut

__PACKAGE__->belongs_to(
  "daily_developer_capacity_unit",
  "FlyHalf::Schema::Result::EstimateUnit",
  { id => "daily_developer_capacity_units" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 sprints

Type: has_many

Related object: L<FlyHalf::Schema::Result::Sprint>

=cut

__PACKAGE__->has_many(
  "sprints",
  "FlyHalf::Schema::Result::Sprint",
  { "foreign.team_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


=head2 users

Type: many to many

Related object: L<FlyHalf::Schema::Result::User>

=cut

__PACKAGE__->has_many('team_users' => 'FlyHalf::Schema::Result::TeamUser', 'team_id');
__PACKAGE__->many_to_many('users' => 'team_users', 'user');


=head2 board

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::Board>

=cut

__PACKAGE__->belongs_to(
  "board",
  "FlyHalf::Schema::Result::Board",
  { id => "board_id" }
);

1;
