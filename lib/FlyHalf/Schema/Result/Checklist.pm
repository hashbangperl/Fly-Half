use utf8;
package FlyHalf::Schema::Result::Checklist;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

FlyHalf::Schema::Result::Checklist

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

=head1 TABLE: C<checklist>

=cut

__PACKAGE__->table("checklist");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 200

=head2 task

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 200 },
  "task",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 checklist_items

Type: has_many

Related object: L<FlyHalf::Schema::Result::ChecklistItem>

=cut

__PACKAGE__->has_many(
  "checklist_items",
  "FlyHalf::Schema::Result::ChecklistItem",
  { "foreign.checklist" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 task

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::Task>

=cut

__PACKAGE__->belongs_to(
  "task",
  "FlyHalf::Schema::Result::Task",
  { id => "task" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07014 @ 2011-12-11 06:28:16
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:WHyBjAyxg5/31gOW1pW1Ww


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
