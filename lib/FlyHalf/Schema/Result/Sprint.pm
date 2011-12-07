package FlyHalf::Schema::Result::Sprint;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

FlyHalf::Schema::Result::Sprint

=cut

__PACKAGE__->table("sprint");

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

=head2 team_id

  data_type: 'integer'
  is_nullable: 1

=head2 start_date

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0

=head2 sprint_length

  data_type: 'integer'
  default_value: 14
  is_nullable: 0

=head2 end_date

  data_type: 'timestamp'
  default_value: '0000-00-00 00:00:00'
  is_nullable: 0

=head2 created_by

  data_type: 'integer'
  is_nullable: 1

=head2 created_date

  data_type: 'timestamp'
  default_value: '0000-00-00 00:00:00'
  is_nullable: 0

=head2 archived

  data_type: 'tinyint'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 200 },
  "description",
  { data_type => "text", is_nullable => 1 },
  "team_id",
  { data_type => "integer", is_nullable => 1 },
  "start_date",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
  },
  "sprint_length",
  { data_type => "integer", default_value => 14, is_nullable => 0 },
  "end_date",
  {
    data_type     => "timestamp",
    default_value => "0000-00-00 00:00:00",
    is_nullable   => 0,
  },
  "created_by",
  { data_type => "integer", is_nullable => 1 },
  "created_date",
  {
    data_type     => "timestamp",
    default_value => "0000-00-00 00:00:00",
    is_nullable   => 0,
  },
  "archived",
  { data_type => "tinyint", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07000 @ 2011-12-07 21:10:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:OiOA+eqpJB/P9NAQ56HgAg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
