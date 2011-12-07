package FlyHalf::Schema::Result::ProjectSprint;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

FlyHalf::Schema::Result::ProjectSprint

=cut

__PACKAGE__->table("project_sprints");

=head1 ACCESSORS

=head2 project_id

  data_type: 'integer'
  is_nullable: 0

=head2 sprint_id

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "project_id",
  { data_type => "integer", is_nullable => 0 },
  "sprint_id",
  { data_type => "integer", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("project_id", "sprint_id");


# Created by DBIx::Class::Schema::Loader v0.07000 @ 2011-12-07 21:10:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:raXb35GD22ZF8hHTdKgWcQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
