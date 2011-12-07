package FlyHalf::Schema::Result::TaskAssignedTo;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

FlyHalf::Schema::Result::TaskAssignedTo

=cut

__PACKAGE__->table("task_assigned_to");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 assigned_from_date

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0

=head2 assigned_to_date

  data_type: 'timestamp'
  default_value: '0000-00-00 00:00:00'
  is_nullable: 0

=head2 user_id

  data_type: 'integer'
  is_nullable: 0

=head2 task_id

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "assigned_from_date",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
  },
  "assigned_to_date",
  {
    data_type     => "timestamp",
    default_value => "0000-00-00 00:00:00",
    is_nullable   => 0,
  },
  "user_id",
  { data_type => "integer", is_nullable => 0 },
  "task_id",
  { data_type => "integer", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07000 @ 2011-12-07 21:10:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:vqhR2wzO49Fzxhu5hYvmUQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
