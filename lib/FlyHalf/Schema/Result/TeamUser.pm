use utf8;
package FlyHalf::Schema::Result::TeamUser;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

FlyHalf::Schema::Result::TeamUser

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

=head1 TABLE: C<team_users>

=cut

__PACKAGE__->table("team_users");

=head1 ACCESSORS

=head2 team_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "team_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</user_id>

=item * L</team_id>

=back

=cut

__PACKAGE__->set_primary_key("user_id", "team_id");

=head1 RELATIONS

=head2 team

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::Team>

=cut

__PACKAGE__->belongs_to(
  "team",
  "FlyHalf::Schema::Result::Team",
  { id => "team_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 user

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "FlyHalf::Schema::Result::User",
  { id => "user_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07014 @ 2012-11-10 20:55:14
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Gl+mcR89EXOWx6g4NUPwWQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
