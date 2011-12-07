package FlyHalf::Schema::Result::TeamSprint;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

FlyHalf::Schema::Result::TeamSprint

=cut

__PACKAGE__->table("team_sprints");

=head1 ACCESSORS

=head2 team_id

  data_type: 'integer'
  is_nullable: 0

=head2 sprint_id

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "team_id",
  { data_type => "integer", is_nullable => 0 },
  "sprint_id",
  { data_type => "integer", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("team_id", "sprint_id");


# Created by DBIx::Class::Schema::Loader v0.07000 @ 2011-12-07 21:10:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:e267IJVsKQZG01qU9nnF0A


# You can replace this text with custom content, and it will be preserved on regeneration
1;
