package FlyHalf::Schema::Result::TaskDependancy;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

FlyHalf::Schema::Result::TaskDependancy

=cut

__PACKAGE__->table("task_dependancies");

=head1 ACCESSORS

=head2 task

  data_type: 'integer'
  is_nullable: 0

=head2 block_state

  data_type: 'tinyint'
  is_nullable: 1

=head2 blocking_task

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "task",
  { data_type => "integer", is_nullable => 0 },
  "block_state",
  { data_type => "tinyint", is_nullable => 1 },
  "blocking_task",
  { data_type => "integer", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("task", "blocking_task");


# Created by DBIx::Class::Schema::Loader v0.07000 @ 2011-12-07 21:10:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:wXQCy+Ro8OhjnAucH1uUzg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
