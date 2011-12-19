use utf8;
package FlyHalf::Schema::Result::TaskProgress;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

FlyHalf::Schema::Result::TaskProgress

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", 'TimeStamp');

=head1 TABLE: C<task_progress>

=cut

__PACKAGE__->table("task_progress");

=head1 ACCESSORS

=head2 task_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 remaining_work

  data_type: 'integer'
  is_nullable: 0

=head2 progress_date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: '0000-00-00 00:00:00'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "task_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "remaining_work",
  { data_type => "integer", is_nullable => 0 },
  "progress_date",
  {
    data_type => "datetime",
    "datetime_undef_if_invalid" => 1,
    is_nullable => 0,  set_on_create => 1
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</task_id>

=item * L</progress_date>

=back

=cut

__PACKAGE__->set_primary_key("task_id", "progress_date");

=head1 RELATIONS

=head2 task

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::Task>

=cut

__PACKAGE__->belongs_to(
  "task",
  "FlyHalf::Schema::Result::Task",
  { id => "task_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07014 @ 2011-12-11 06:28:16
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:OLM5GO4CCz8bxHeUhnawvQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
