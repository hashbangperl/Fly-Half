package FlyHalf::Schema::Result::ObjectStory;

=head1 NAME

FlyHalf::Schema::Result::ObjectStory

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

=head1 TABLE: C<object_stories>

=cut

__PACKAGE__->table("object_stories");

=head1 ACCESSORS

=head2 story_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 object_id

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "story_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "object_id",
  { data_type => "integer", is_nullable => 0 },
  "object_type",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 128 },
);

=head1 PRIMARY KEY

=over 4

=item * L</story_id>

=item * L</object_id>

=item * L</object_type>

=back

=cut

__PACKAGE__->set_primary_key("story_id", "object_id", "object_type");

=head1 RELATIONS

=head2 story

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::Story>

=cut

__PACKAGE__->belongs_to(
  "story",
  "FlyHalf::Schema::Result::Story",
  { id => "story_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

sub inflate_result {
    my $self = shift;
    my $ret = $self->next::method(@_);
    my $subclass = 'FlyHalf::Schema::Result::'.ucfirst($ret->object_type).'Story';

    $self->ensure_class_loaded( $subclass );
    bless $ret, $subclass;
    return $ret;
}


1;
