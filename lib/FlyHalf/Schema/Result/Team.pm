package FlyHalf::Schema::Result::Team;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

FlyHalf::Schema::Result::Team

=cut

__PACKAGE__->table("team");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 description

  data_type: 'text'
  is_nullable: 1

=head2 current_sprint

  data_type: 'integer'
  is_nullable: 0

=head2 daily_developer_capacity

  data_type: 'integer'
  default_value: 5
  is_nullable: 1

=head2 daily_developer_capacity_units

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "description",
  { data_type => "text", is_nullable => 1 },
  "current_sprint",
  { data_type => "integer", is_nullable => 0 },
  "daily_developer_capacity",
  { data_type => "integer", default_value => 5, is_nullable => 1 },
  "daily_developer_capacity_units",
  { data_type => "integer", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("name", ["name"]);


# Created by DBIx::Class::Schema::Loader v0.07000 @ 2011-12-07 21:10:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:/TmGDZ1FeIXTeV4KnVzGZw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
