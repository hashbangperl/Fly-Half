use utf8;
package FlyHalf::Schema::Result::State;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

FlyHalf::Schema::Result::State

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

=head2 next_state

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 next_state_requirement

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
  "next_state",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "next_state_requirement",
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

=head2 states

Type: has_many

Related object: L<FlyHalf::Schema::Result::State>

=cut

__PACKAGE__->has_many(
  "states",
  "FlyHalf::Schema::Result::State",
  { "foreign.next_state" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 stories

Type: has_many

Related object: L<FlyHalf::Schema::Result::Story>

=cut

__PACKAGE__->has_many(
  "stories",
  "FlyHalf::Schema::Result::Story",
  { "foreign.state_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 tasks

Type: has_many

Related object: L<FlyHalf::Schema::Result::Task>

=cut

__PACKAGE__->has_many(
  "tasks",
  "FlyHalf::Schema::Result::Task",
  { "foreign.state_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07014 @ 2011-12-11 06:28:16
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:0Kiyx9F+7PuMfW7EqdM5SA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
