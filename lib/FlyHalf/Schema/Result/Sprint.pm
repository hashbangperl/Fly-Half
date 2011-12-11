use utf8;
package FlyHalf::Schema::Result::Sprint;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

FlyHalf::Schema::Result::Sprint

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

=head1 TABLE: C<sprint>

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
  is_foreign_key: 1
  is_nullable: 1

=head2 start_date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 sprint_length

  data_type: 'integer'
  default_value: 14
  is_nullable: 0

=head2 end_date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 created_by

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 created_date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

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
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "start_date",
  {
    data_type => "datetime",
    "datetime_undef_if_invalid" => 1,
    is_nullable => 1,
  },
  "sprint_length",
  { data_type => "integer", default_value => 14, is_nullable => 0 },
  "end_date",
  {
    data_type => "datetime",
    "datetime_undef_if_invalid" => 1,
    is_nullable => 1,
  },
  "created_by",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "created_date",
  {
    data_type => "datetime",
    "datetime_undef_if_invalid" => 1,
    is_nullable => 1,
  },
  "archived",
  { data_type => "tinyint", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

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

=head2 project_sprints

Type: has_many

Related object: L<FlyHalf::Schema::Result::ProjectSprint>

=cut

__PACKAGE__->has_many(
  "project_sprints",
  "FlyHalf::Schema::Result::ProjectSprint",
  { "foreign.sprint_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 stories

Type: has_many

Related object: L<FlyHalf::Schema::Result::Story>

=cut

__PACKAGE__->has_many(
  "stories",
  "FlyHalf::Schema::Result::Story",
  { "foreign.sprint" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 team

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::Team>

=cut

__PACKAGE__->belongs_to(
  "team",
  "FlyHalf::Schema::Result::Team",
  { id => "team_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07014 @ 2011-12-11 06:28:16
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:lsaus9+2NI5bDwDQyR+ZXg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
