package FlyHalf::Schema::Result::State;
use strict;
use warnings;

=head1 NAME

FlyHalf::Schema::Result::State

=cut

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");

=head1 TABLE: C<state>

=cut

__PACKAGE__->table("state");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 200

=head2 description

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 200 },
  "description",
  { data_type => "text", is_nullable => 1 },

);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 next_state

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::State>

=cut

__PACKAGE__->belongs_to(
  "next_state",
  "FlyHalf::Schema::Result::State",
  { id => "next_state" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 projects

Type: has_many

Related object: L<FlyHalf::Schema::Result::Project>

=cut

__PACKAGE__->has_many(
  "projects",
  "FlyHalf::Schema::Result::Project",
  { "foreign.state_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 transitions

Type: has_many

Related object: L<FlyHalf::Schema::Result::StateTransition>

=cut

__PACKAGE__->has_many(
  "transitions",
  "FlyHalf::Schema::Result::StateTransition",
  { "foreign.from_state" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


1;
