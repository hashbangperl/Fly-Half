package FlyHalf::Schema::Result::SprintUnavailability;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

FlyHalf::Schema::Result::SprintUnavailability

=cut

__PACKAGE__->table("sprint_unavailability");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 user_id

  data_type: 'integer'
  is_nullable: 1

=head2 start_date

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0

=head2 start_half_day

  data_type: 'tinyint'
  is_nullable: 1

=head2 end_date

  data_type: 'timestamp'
  default_value: '0000-00-00 00:00:00'
  is_nullable: 0

=head2 end_half_day

  data_type: 'tinyint'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "user_id",
  { data_type => "integer", is_nullable => 1 },
  "start_date",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
  },
  "start_half_day",
  { data_type => "tinyint", is_nullable => 1 },
  "end_date",
  {
    data_type     => "timestamp",
    default_value => "0000-00-00 00:00:00",
    is_nullable   => 0,
  },
  "end_half_day",
  { data_type => "tinyint", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07000 @ 2011-12-07 21:10:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:iHd6PUYFNnguVsFAPI8Nug


# You can replace this text with custom content, and it will be preserved on regeneration
1;
