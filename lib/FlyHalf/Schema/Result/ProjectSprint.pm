use utf8;
package FlyHalf::Schema::Result::ProjectSprint;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

FlyHalf::Schema::Result::ProjectSprint

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

=head1 TABLE: C<project_sprints>

=cut

__PACKAGE__->table("project_sprints");

=head1 ACCESSORS

=head2 project_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 sprint_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

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
  "project_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "sprint_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
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

=item * L</project_id>

=item * L</sprint_id>

=back

=cut

__PACKAGE__->set_primary_key("project_id", "sprint_id");

=head1 RELATIONS

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

=head2 project

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::Project>

=cut

__PACKAGE__->belongs_to(
  "project",
  "FlyHalf::Schema::Result::Project",
  { id => "project_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

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
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:uVrn4UIzyayRF9mBB5ubjw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
