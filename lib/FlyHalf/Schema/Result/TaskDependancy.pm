use utf8;
package FlyHalf::Schema::Result::TaskDependancy;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

FlyHalf::Schema::Result::TaskDependancy

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

=head1 TABLE: C<task_dependancies>

=cut

__PACKAGE__->table("task_dependancies");

=head1 ACCESSORS

=head2 task

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 block_state

  data_type: 'tinyint'
  is_nullable: 1

=head2 blocking_task

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "task",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "block_state",
  { data_type => "tinyint", is_nullable => 1 },
  "blocking_task",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</task>

=item * L</blocking_task>

=back

=cut

__PACKAGE__->set_primary_key("task", "blocking_task");

=head1 RELATIONS

=head2 blocking_task

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::Task>

=cut

__PACKAGE__->belongs_to(
  "blocking_task",
  "FlyHalf::Schema::Result::Task",
  { id => "blocking_task" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 task

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::Task>

=cut

__PACKAGE__->belongs_to(
  "task",
  "FlyHalf::Schema::Result::Task",
  { id => "task" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07014 @ 2011-12-11 06:28:16
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:uW4eNVupI2bDDlcBsYjytA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
