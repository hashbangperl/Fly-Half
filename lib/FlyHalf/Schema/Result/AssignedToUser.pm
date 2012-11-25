use utf8;
package FlyHalf::Schema::Result::AssignedToUser;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

FlyHalf::Schema::Result::AssignedToUser

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

=head1 TABLE: C<assigned_to_user>

=cut

__PACKAGE__->table("assigned_to_user");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 assigned_from_date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

=head2 assigned_to_date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 object_id

  data_type: 'integer'
  is_nullable: 0

=head2 object_type

  data_type: 'varchar'
  is_nullable: 1
  size: 128

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "assigned_from_date",
  {
    data_type => "datetime",
    "datetime_undef_if_invalid" => 1,
    is_nullable => 0,
  },
  "assigned_to_date",
  {
    data_type => "datetime",
    "datetime_undef_if_invalid" => 1,
    is_nullable => 1,
  },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "object_id",
  { data_type => "integer", is_nullable => 0 },
  "object_type",
  { data_type => "varchar", is_nullable => 1, size => 128 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 user

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "FlyHalf::Schema::Result::User",
  { id => "user_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07014 @ 2012-11-23 17:14:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:OdbY438sR6MFbkz2W5G3Fg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
