use utf8;
package FlyHalf::Schema::Result::ActionsObject;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

FlyHalf::Schema::Result::ActionsObject

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

=head1 TABLE: C<actions_objects>

=cut

__PACKAGE__->table("actions_objects");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 action_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 object

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 object_id

  data_type: 'integer'
  is_nullable: 0

=head2 comment

  data_type: 'text'
  is_nullable: 1

=head2 action_by

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 action_time

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "action_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "object",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "object_id",
  { data_type => "integer", is_nullable => 0 },
  "comment",
  { data_type => "text", is_nullable => 1 },
  "action_by",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "action_time",
  {
    data_type => "datetime",
    "datetime_undef_if_invalid" => 1,
    is_nullable => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 action

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::Action>

=cut

__PACKAGE__->belongs_to(
  "action",
  "FlyHalf::Schema::Result::Action",
  { id => "action_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 action_by

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "action_by",
  "FlyHalf::Schema::Result::User",
  { id => "action_by" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07014 @ 2012-11-23 17:14:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:kO+N3LKNl10vRl1bf42MEA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
