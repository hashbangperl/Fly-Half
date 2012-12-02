package FlyHalf::Schema::Result::Sprint;

=head1 NAME

FlyHalf::Schema::Result::Sprint

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=back

=cut

__PACKAGE__->load_components(qw/DynamicDefault InflateColumn::DateTime TimeStamp/);

=head1 TABLE: C<sprint>

=cut

__PACKAGE__->table("sprint");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 ref_code

  data_type: 'integer'
  is_nullable: 0
  dynamic default fall back to copy of id

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 200

=head2 description

  data_type: 'text'
  is_nullable: 1

=head2 team_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 start_date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 sprint_length

  data_type: 'integer'
  default_value: 14
  is_nullable: 0

=head2 end_date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 created_by

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

=head2 archived

  data_type: 'tinyint'
  is_nullable: 0

=head2 in_progress

  data_type: 'tinyint'
  is_nullable: 0


=cut

__PACKAGE__->add_columns(
  "id" => { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  ref_code =>
  { data_type => "varchar(100)", is_nullable => 0,
    dynamic_default_on_create => \&fallback_to_id },
  "name" => { data_type => "varchar", is_nullable => 0, size => 200 },
  "description" => { data_type => "text", is_nullable => 1 },
  "team_id" => { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "start_date" => {
    data_type => "datetime",
    "datetime_undef_if_invalid" => 1,
    is_nullable => 1,
  },
  "sprint_length" => { data_type => "integer", default_value => 14, is_nullable => 0 },
  "end_date" => {
    data_type => "datetime",
    "datetime_undef_if_invalid" => 1,
    is_nullable => 1,
  },
  "created_by" => { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "created_date" => {
    data_type => "datetime",
    "datetime_undef_if_invalid" => 1,
    is_nullable => 1,
    set_on_create => 1
  },
  "updated_date" => {
    data_type => "datetime",
    "datetime_undef_if_invalid" => 1,
    is_nullable => 1,
    set_on_create => 1,
    set_on_update => 1,
  },
  "archived" => { data_type => "tinyint", is_nullable => 0 },
  "in_progress" => { data_type => "tinyint", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 created_by

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "created_by",
  "FlyHalf::Schema::Result::User",
  { id => "created_by" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 project_sprints

Type: has_many

Related object: L<FlyHalf::Schema::Result::ProjectSprint>

=cut

__PACKAGE__->has_many(
  "project_sprints",
  "FlyHalf::Schema::Result::ProjectSprint",
  { "foreign.sprint_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 sprint_capacity_days

Type: has_many

Related object: L<FlyHalf::Schema::Result::SprintCapacity>

=cut

__PACKAGE__->has_many(
  "sprint_capacity_days",
  "FlyHalf::Schema::Result::SprintCapacity",
  { "foreign.sprint_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 sprint_progresses

Type: has_many

Related object: L<FlyHalf::Schema::Result::SprintProgress>

=cut

__PACKAGE__->has_many(
  "sprint_progresses",
  "FlyHalf::Schema::Result::SprintProgress",
  { "foreign.sprint_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);



=head2 stories

Type: has_many

Related object: L<FlyHalf::Schema::Result::Story>

=cut

__PACKAGE__->has_many(
  "sprint_stories",
  "FlyHalf::Schema::Result::SprintStory",
  { "foreign.object_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0, where => {'foreign.object_type' => 'sprint'} },
);

__PACKAGE__->many_to_many('stories', 'sprint_stories', 'story');


=head2 team

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::Team>

=cut

__PACKAGE__->belongs_to(
  "team",
  "FlyHalf::Schema::Result::Team",
  { id => "team_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

sub fallback_to_id {
    return shift->id;
}

1;
