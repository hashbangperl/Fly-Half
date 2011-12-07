package FlyHalf::Schema::Result::UserAssignedTask;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

FlyHalf::Schema::Result::UserAssignedTask

=cut

__PACKAGE__->table("user_assigned_tasks");

=head1 ACCESSORS

=head2 user_id

  data_type: 'integer'
  is_nullable: 0

=head2 task_id

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "user_id",
  { data_type => "integer", is_nullable => 0 },
  "task_id",
  { data_type => "integer", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("user_id", "task_id");


# Created by DBIx::Class::Schema::Loader v0.07000 @ 2011-12-07 21:10:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:tHhssPsdclwGHEPoQvidOg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
