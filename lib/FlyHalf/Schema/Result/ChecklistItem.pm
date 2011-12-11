use utf8;
package FlyHalf::Schema::Result::ChecklistItem;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

FlyHalf::Schema::Result::ChecklistItem

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

=head1 TABLE: C<checklist_items>

=cut

__PACKAGE__->table("checklist_items");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 200

=head2 checklist

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 200 },
  "checklist",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 checklist

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::Checklist>

=cut

__PACKAGE__->belongs_to(
  "checklist",
  "FlyHalf::Schema::Result::Checklist",
  { id => "checklist" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07014 @ 2011-12-11 06:28:16
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:iDwgsmR6v5xkoeGnZo+ygQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
