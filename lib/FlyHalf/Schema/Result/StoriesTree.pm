use utf8;
package FlyHalf::Schema::Result::StoriesTree;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

FlyHalf::Schema::Result::StoriesTree

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

=head1 TABLE: C<stories_tree>

=cut

__PACKAGE__->table("stories_tree");

=head1 ACCESSORS

=head2 story

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 ancestor

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 depth

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "story",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "ancestor",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "depth",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</story>

=item * L</ancestor>

=back

=cut

__PACKAGE__->set_primary_key("story", "ancestor");

=head1 RELATIONS

=head2 ancestor

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::Story>

=cut

__PACKAGE__->belongs_to(
  "ancestor",
  "FlyHalf::Schema::Result::Story",
  { id => "ancestor" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 story

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::Story>

=cut

__PACKAGE__->belongs_to(
  "story",
  "FlyHalf::Schema::Result::Story",
  { id => "story" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07014 @ 2012-02-29 20:39:50
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:R/lJeKbeACRNWS4VWen6Ug


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
