package FlyHalf::Schema::Result::Task;

=head1 NAME

FlyHalf::Schema::Result::Task

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

=head1 TABLE: C<task>

=cut

__PACKAGE__->table("task");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 ref_code

  data_type: 'integer'
  is_nullable: 0
  dynamic default fall back to copy of id

=head2 estimate

  data_type: 'integer'
  is_nullable: 1

=head2 estimate_unit

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 story_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 reviewed_by

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 200

=head2 summary

  data_type: 'text'
  is_nullable: 1

=head2 description

  data_type: 'text'
  is_nullable: 1

=head2 start_date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 end_date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 state_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

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

=cut

__PACKAGE__->add_columns(
  "id" => { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  ref_code =>
  { data_type => "varchar(100)", is_nullable => 0,
    dynamic_default_on_create => \&fallback_to_id },
  "estimate" => { data_type => "integer", is_nullable => 1 },
  "estimate_unit" => { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "remaining_work" => { data_type => "integer", is_nullable => 1 },
  "completed_work" => { data_type => "integer", is_nullable => 1 },
  "story_id" => { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "reviewed_by" => { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "name" => { data_type => "varchar", is_nullable => 0, size => 200 },
  "summary" => { data_type => "text", is_nullable => 1 },
  "description" => { data_type => "text", is_nullable => 1 },
  "start_date" => {
    data_type => "datetime",
    "datetime_undef_if_invalid" => 1,
    is_nullable => 1,
  },
  "end_date" => {
    data_type => "datetime",
    "datetime_undef_if_invalid" => 1,
    is_nullable => 1,
  },
  "state_id" => { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "created_by" => { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "created_date" => {
    data_type => "datetime",
    "datetime_undef_if_invalid" => 1,
    is_nullable => 1,
    set_on_create => 1,
  },
  "updated_date" => {
    data_type => "datetime",
    "datetime_undef_if_invalid" => 1,
    is_nullable => 1,
    set_on_create => 1,
    set_on_update => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 checklists

Type: has_many

Related object: L<FlyHalf::Schema::Result::Checklist>

=cut

__PACKAGE__->has_many(
  "checklists",
  "FlyHalf::Schema::Result::Checklist",
  { "foreign.task" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

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

=head2 estimate_unit

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::EstimateUnit>

=cut

__PACKAGE__->belongs_to(
  "estimate_unit",
  "FlyHalf::Schema::Result::EstimateUnit",
  { id => "estimate_unit" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 reviewed_by

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "reviewed_by",
  "FlyHalf::Schema::Result::User",
  { id => "reviewed_by" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 state

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::State>

=cut

__PACKAGE__->belongs_to(
  "state",
  "FlyHalf::Schema::Result::State",
  { id => "state_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 story

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::Story>

=cut

__PACKAGE__->belongs_to(
  "story",
  "FlyHalf::Schema::Result::Story",
  { id => "story_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 task_dependancies_blocking_tasks

Type: has_many

Related object: L<FlyHalf::Schema::Result::TaskDependancy>

=cut

__PACKAGE__->has_many(
  "task_dependancies_blocking_tasks",
  "FlyHalf::Schema::Result::TaskDependancy",
  { "foreign.blocking_task" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 task_dependancies_tasks

Type: has_many

Related object: L<FlyHalf::Schema::Result::TaskDependancy>

=cut

__PACKAGE__->has_many(
  "task_dependancies_tasks",
  "FlyHalf::Schema::Result::TaskDependancy",
  { "foreign.task" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 tasks_assigned_to

Type: has_many

Related object: L<FlyHalf::Schema::Result::TaskAssignedTo>

=cut

__PACKAGE__->has_many(
  "tasks_assigned_to",
  "FlyHalf::Schema::Result::TaskAssignedTo",
  { "foreign.task_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


######

sub fallback_to_id {
    return shift->id;
}

1;
