use utf8;
package FlyHalf::Schema::Result::SprintProgress;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

FlyHalf::Schema::Result::SprintProgress

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

=head1 TABLE: C<sprint_progress>

=cut

__PACKAGE__->table("sprint_progress");

=head1 ACCESSORS

=head2 sprint_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 story_id

  data_type: 'integer'
  is_nullable: 0

=head2 remaining_work

  data_type: 'integer'
  is_nullable: 0

=head2 estimated_work

  data_type: 'integer'
  is_nullable: 0

=head2 progress_date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: '0000-00-00 00:00:00'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "sprint_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "story_id",
  { data_type => "integer", is_nullable => 0 },
  "remaining_work",
  { data_type => "integer", is_nullable => 0 },
  "estimated_work",
  { data_type => "integer", is_nullable => 0 },
  "progress_date",
  {
    data_type => "datetime",
    "datetime_undef_if_invalid" => 1,
    default_value => "0000-00-00 00:00:00",
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</sprint_id>

=item * L</progress_date>

=back

=cut

__PACKAGE__->set_primary_key("sprint_id", "progress_date");

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


# Created by DBIx::Class::Schema::Loader v0.07014 @ 2011-12-16 07:54:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:h4jJ9Xrx2sZ5aln+W75T4g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
