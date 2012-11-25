use utf8;
package FlyHalf::Schema::Result::Action;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

FlyHalf::Schema::Result::Action

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

=head1 TABLE: C<actions>

=cut

__PACKAGE__->table("actions");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 description

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
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

=head2 actions_objects

Type: has_many

Related object: L<FlyHalf::Schema::Result::ActionsObject>

=cut

__PACKAGE__->has_many(
  "actions_objects",
  "FlyHalf::Schema::Result::ActionsObject",
  { "foreign.action_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07014 @ 2012-11-23 17:14:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Nhl0o59DIwLSJrV0tWVz1A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
