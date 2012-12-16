package FlyHalf::Schema::Result::BoardColumn;
use strict;
use warnings;

=head1 NAME

FlyHalf::Schema::Result::BoardColumn

=cut

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");

=head1 TABLE: C<board_column>

=cut

__PACKAGE__->table("board_column");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 200

=head2 updated_date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 board_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 updated_by

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 created_by

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 created_date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 200 },
  "updated_date",
  {
    data_type => "datetime",
    "datetime_undef_if_invalid" => 1,
    is_nullable => 1,
    set_on_create => 1,
    set_on_update => 1,
  },
  "board_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  display_order => { data_type => "integer",  is_nullable => 1, default => 1 },
  "updated_by",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "created_by",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "created_date",
  {
    data_type => "datetime",
    "datetime_undef_if_invalid" => 1,
    is_nullable => 1,
    set_on_create => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 board

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::Board>

=cut

__PACKAGE__->belongs_to(
  "board",
  "FlyHalf::Schema::Result::Board",
  { id => "board_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 board_column_states

Type: has_many

Related object: L<FlyHalf::Schema::Result::BoardColumnState>

=cut

__PACKAGE__->has_many(
  "board_column_states",
  "FlyHalf::Schema::Result::BoardColumnState",
  { "foreign.board_column_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

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

=head2 updated_by

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "updated_by",
  "FlyHalf::Schema::Result::User",
  { id => "updated_by" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07014 @ 2012-11-25 14:55:43
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:zKnwLbyZImYv/wMxVgfB+Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
