package FlyHalf::Controller::Planning;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

FlyHalf::Controller::Planning - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

use Carp qw(carp cluck confess);
use Data::Dumper;

use HTML::FormHandler;
use Calendar::List;

=head2 calendar

=cut

sub calendar : Path {
    my ( $self, $c ) = @_;

    $c->stash->{template} = 'planning/calendar.tt';
    $c->stash->{title} = {
        title => 'Calendar',
    };
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}


=head1 AUTHOR

Aaron Trevena

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
