use utf8;
package FlyHalf::Schema::Result::TeamSprint;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

FlyHalf::Schema::Result::TeamSprint

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

=head1 TABLE: C<team_sprints>

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

=head1 PRIMARY KEY

=over 4

=item * L</team_id>

=item * L</sprint_id>

=back

=cut

__PACKAGE__->set_primary_key("team_id", "sprint_id");


# Created by DBIx::Class::Schema::Loader v0.07014 @ 2011-12-11 06:28:16
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:nRJGVcAAe0G75BQ6z3uwZA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
