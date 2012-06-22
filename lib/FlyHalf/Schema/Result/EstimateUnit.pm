use utf8;
package FlyHalf::Schema::Result::EstimateUnit;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

FlyHalf::Schema::Result::EstimateUnit

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

=head1 TABLE: C<estimate_unit>

=cut

__PACKAGE__->table("estimate_unit");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=head2 abbreviation

  data_type: 'varchar'
  is_nullable: 1
  size: 4

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 20 },
  "abbreviation",
  { data_type => "varchar", is_nullable => 1, size => 4 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 stories

Type: has_many

Related object: L<FlyHalf::Schema::Result::Story>

=cut

__PACKAGE__->has_many(
  "stories",
  "FlyHalf::Schema::Result::Story",
  { "foreign.estimate_unit" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 tasks

Type: has_many

Related object: L<FlyHalf::Schema::Result::Task>

=cut

__PACKAGE__->has_many(
  "tasks",
  "FlyHalf::Schema::Result::Task",
  { "foreign.estimate_unit" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 teams

Type: has_many

Related object: L<FlyHalf::Schema::Result::Team>

=cut

__PACKAGE__->has_many(
  "teams",
  "FlyHalf::Schema::Result::Team",
  { "foreign.daily_developer_capacity_units" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 to_string

=cut

sub to_string {
    my $self = shift;
    return $self->name . ' ('. $self-> abbreviation .' )';
}

# Created by DBIx::Class::Schema::Loader v0.07014 @ 2011-12-16 07:54:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:dm9VVXhuE2+3kkfEETY5hw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
