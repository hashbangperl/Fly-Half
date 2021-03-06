use utf8;
package FlyHalf::Schema::Result::SprintCapacity;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

FlyHalf::Schema::Result::SprintCapacity

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

=head1 TABLE: C<sprint_capacity>

=cut

__PACKAGE__->table("sprint_capacity");

=head1 ACCESSORS

=head2 sprint_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 sprint_day

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

=head2 day_capacity

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "sprint_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "sprint_day",
  {
    data_type => "datetime",
    "datetime_undef_if_invalid" => 1,
    is_nullable => 0,
  },
  "day_capacity",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</sprint_id>

=item * L</sprint_day>

=back

=cut

__PACKAGE__->set_primary_key("sprint_id", "sprint_day");

=head1 RELATIONS

=head2 sprint

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::Sprint>

=cut

__PACKAGE__->belongs_to(
  "sprint",
  "FlyHalf::Schema::Result::Sprint",
  { id => "sprint_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07014 @ 2012-01-09 20:27:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:IYMuOLWRh14BdiSGsfeR6g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
