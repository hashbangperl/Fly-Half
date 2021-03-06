package FlyHalf::Schema::Result::SprintStory;

=head1 NAME

FlyHalf::Schema::Result::SprintStory

=cut

use strict;
use warnings;

use base 'FlyHalf::Schema::Result::ObjectStory';


__PACKAGE__->table("object_stories");

=head1 ACCESSORS

=head2 story_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 object_id

  data_type: 'integer'
  is_nullable: 0


=over 4

=item * L</story_id>

=item * L</object_id>

=item * L</object_type>

=back

=head1 RELATIONS

=head2 story

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::Story>

=head2 sprint

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::Sprint>

=cut

__PACKAGE__->belongs_to(
  "sprint",
  "FlyHalf::Schema::Result::Sprint",
  { id => "object_id" },
);

sub insert {
    my $self = shift;
    $self->object_type('sprint');
    return $self->next::method(@_);
}


1;
