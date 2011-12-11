use utf8;
package FlyHalf::Schema::Result::Story;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

FlyHalf::Schema::Result::Story

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

=head1 TABLE: C<story>

=cut

__PACKAGE__->table("story");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 sprint

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 priority

  data_type: 'integer'
  default_value: 100
  is_nullable: 0

=head2 estimate

  data_type: 'integer'
  is_nullable: 1

=head2 estimate_unit

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 remaining_work

  data_type: 'integer'
  is_nullable: 1

=head2 completed_work

  data_type: 'integer'
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

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "sprint",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "priority",
  { data_type => "integer", default_value => 100, is_nullable => 0 },
  "estimate",
  { data_type => "integer", is_nullable => 1 },
  "estimate_unit",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "remaining_work",
  { data_type => "integer", is_nullable => 1 },
  "completed_work",
  { data_type => "integer", is_nullable => 1 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 200 },
  "summary",
  { data_type => "text", is_nullable => 1 },
  "description",
  { data_type => "text", is_nullable => 1 },
  "start_date",
  {
    data_type => "datetime",
    "datetime_undef_if_invalid" => 1,
    is_nullable => 1,
  },
  "end_date",
  {
    data_type => "datetime",
    "datetime_undef_if_invalid" => 1,
    is_nullable => 1,
  },
  "state_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

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

=head2 sprint

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::Sprint>

=cut

__PACKAGE__->belongs_to(
  "sprint",
  "FlyHalf::Schema::Result::Sprint",
  { id => "sprint" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
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

=head2 tasks

Type: has_many

Related object: L<FlyHalf::Schema::Result::Task>

=cut

__PACKAGE__->has_many(
  "tasks",
  "FlyHalf::Schema::Result::Task",
  { "foreign.story_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07014 @ 2011-12-11 06:28:16
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:gOwGU+WqViasWGP7B+qfqA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;