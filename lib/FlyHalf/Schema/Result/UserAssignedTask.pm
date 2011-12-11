use utf8;
package FlyHalf::Schema::Result::UserAssignedTask;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

FlyHalf::Schema::Result::UserAssignedTask

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

=head1 TABLE: C<user_assigned_tasks>

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

=head1 PRIMARY KEY

=over 4

=item * L</user_id>

=item * L</task_id>

=back

=cut

__PACKAGE__->set_primary_key("user_id", "task_id");


# Created by DBIx::Class::Schema::Loader v0.07014 @ 2011-12-08 21:21:00
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:8IegmDEve076q5JD/Q6WYw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
