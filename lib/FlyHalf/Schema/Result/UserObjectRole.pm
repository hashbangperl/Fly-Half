package FlyHalf::Schema::Result::UserObjectRole;

=head1 NAME

FlyHalf::Schema::Result::UserObjectRole

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

=head1 TABLE: C<user_object_roles>

=cut

__PACKAGE__->table("user_object_roles");

=head1 ACCESSORS

=head2 user_id

  data_type: 'integer'
  is_nullable: 0

=head2 role_id

  data_type: 'integer'
  is_nullable: 0

=head2 object

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 object_id

  data_type: 'integer'
  is_nullable: 0

=head2 created_by

  data_type: 'integer'
  is_nullable: 1

=head2 created_date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "user_id",
  { data_type => "integer", is_nullable => 0 },
  "role_id",
  { data_type => "integer", is_nullable => 0 },
  "object",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "object_id",
  { data_type => "integer", is_nullable => 0 },
  "created_by",
  { data_type => "integer", is_nullable => 1 },
  "created_date" => {
    data_type => "datetime",
    "datetime_undef_if_invalid" => 1,
    is_nullable => 1,
    set_on_create => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</user_id>

=item * L</role_id>

=item * L</object>

=item * L</object_id>

=back

=cut

__PACKAGE__->set_primary_key("user_id", "role_id", "object", "object_id");


=head2 created_by

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "created_by",
  "FlyHalf::Schema::Result::User",
  { id => "created_by" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 user

Type: user

Related object: L<FlyHalf::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "FlyHalf::Schema::Result::User",
  { id => "user_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


=head2 role

Type: role

Related object: L<FlyHalf::Schema::Result::Role>

=cut

__PACKAGE__->belongs_to(
  "role",
  "FlyHalf::Schema::Result::Role",
  { id => "role_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


1;
