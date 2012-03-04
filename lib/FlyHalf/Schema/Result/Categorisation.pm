use utf8;
package FlyHalf::Schema::Result::Categorisation;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

FlyHalf::Schema::Result::Categorisation

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

=head1 TABLE: C<categorisation>

=cut

__PACKAGE__->table("categorisation");

=head1 ACCESSORS

=head2 object

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 object_id

  data_type: 'integer'
  is_nullable: 0

=head2 relation_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 category

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 added_by

  data_type: 'integer'
  is_nullable: 0

=head2 added_date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "object",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "object_id",
  { data_type => "integer", is_nullable => 0 },
  "relation_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "category",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "added_by",
  { data_type => "integer", is_nullable => 0 },
  "added_date",
  {
    data_type => "datetime",
    "datetime_undef_if_invalid" => 1,
    is_nullable => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</object>

=item * L</object_id>

=item * L</category>

=back

=cut

__PACKAGE__->set_primary_key("object", "object_id", "category");

=head1 RELATIONS

=head2 category

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::Category>

=cut

__PACKAGE__->belongs_to(
  "category",
  "FlyHalf::Schema::Result::Category",
  { id => "category" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07014 @ 2012-03-04 17:58:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Y6/GSDa34ck8PYm4xnZ1Mg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
