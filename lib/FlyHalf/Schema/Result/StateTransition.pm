use utf8;
package FlyHalf::Schema::Result::StateTransition;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

FlyHalf::Schema::Result::StateTransition

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

=head1 TABLE: C<state_transition>

=cut

__PACKAGE__->table("state_transition");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 200

=head2 from_state

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 to_state

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 requirement

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 200 },
  "from_state",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "to_state",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "requirement",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 from_state

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::State>

=cut

__PACKAGE__->belongs_to(
  "from_state",
  "FlyHalf::Schema::Result::State",
  { id => "from_state" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 to_state

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::State>

=cut

__PACKAGE__->belongs_to(
  "to_state",
  "FlyHalf::Schema::Result::State",
  { id => "to_state" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07014 @ 2012-11-23 17:14:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:VxNEmCIYOYDyTfOKRoLczA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
