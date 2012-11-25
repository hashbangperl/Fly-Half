use utf8;
package FlyHalf::Schema::Result::Role;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

FlyHalf::Schema::Result::Role

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

=head1 TABLE: C<role>

=cut

__PACKAGE__->table("role");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 parent_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 200

=head2 token

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=head2 description

  data_type: 'text'
  is_nullable: 1

=head2 created_by

  data_type: 'integer'
  is_nullable: 1

=head2 created_date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "parent_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 200 },
  "token",
  { data_type => "varchar", is_nullable => 0, size => 20 },
  "description",
  { data_type => "text", is_nullable => 1 },
  "created_by",
  { data_type => "integer", is_nullable => 1 },
  "created_date",
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

=head2 parent

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::Role>

=cut

__PACKAGE__->belongs_to(
  "parent",
  "FlyHalf::Schema::Result::Role",
  { id => "parent_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 sub_roles

Type: has_many

Related object: L<FlyHalf::Schema::Result::Role>

=cut

__PACKAGE__->has_many(
  "sub_roles",
  "FlyHalf::Schema::Result::Role",
  { "foreign.parent_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 user_object_roles

Type: has_many

Related object: L<FlyHalf::Schema::Result::UserObjectRole>

=cut

__PACKAGE__->has_many(
  "user_object_roles",
  "FlyHalf::Schema::Result::UserObjectRole",
  { "foreign.role_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 users_roles

Type: has_many

Related object: L<FlyHalf::Schema::Result::UsersRole>

=cut

__PACKAGE__->has_many(
  "users_roles",
  "FlyHalf::Schema::Result::UsersRole",
  { "foreign.role_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07014 @ 2012-11-23 17:14:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:q8ItQR1k31sfyForAJg++w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
