use utf8;
package FlyHalf::Schema::Result::BoardColumnState;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

FlyHalf::Schema::Result::BoardColumnState

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

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");

=head1 TABLE: C<board_column_states>

=cut

__PACKAGE__->table("board_column_states");

=head1 ACCESSORS

=head2 state_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 board_column_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "state_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "board_column_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</state_id>

=item * L</board_column_id>

=back

=cut

__PACKAGE__->set_primary_key("state_id", "board_column_id");

=head1 RELATIONS

=head2 board_column

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::BoardColumn>

=cut

__PACKAGE__->belongs_to(
  "board_column",
  "FlyHalf::Schema::Result::BoardColumn",
  { id => "board_column_id" },
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


# Created by DBIx::Class::Schema::Loader v0.07014 @ 2012-11-25 14:55:43
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:BBQllWBl+fBbsy8Q24gZfg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
