package FlyHalf::Schema::Result::TaskPlanningDate;

=head1 NAME

FlyHalf::Schema::Result::TaskPlanningDate

=cut

use strict;
use warnings;

use base 'FlyHalf::Schema::Result::ObjectPlanningDate';

=head1 RELATIONS

=head2 story

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::Story>

=head2 sprint

Type: belongs_to

Related object: L<FlyHalf::Schema::Result::Task>

=cut

__PACKAGE__->belongs_to(
  "sprint",
  "FlyHalf::Schema::Result::Task",
  { id => "object_id" },
);

sub insert {
    my $self = shift;
    $self->object_type('task');
    return $self->next::method(@_);
}


1;


1;
