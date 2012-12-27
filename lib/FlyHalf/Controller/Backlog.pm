package FlyHalf::Controller::Backlog;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

FlyHalf::Controller::Backlog - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

use Carp qw(carp cluck confess);
use Data::Dumper;

use HTML::FormHandler;

=head2 default

=cut

sub default : Path {
    my ( $self, $c ) = @_;

    $c->stash->{template} = 'backlog/backlog.tt';
    $c->stash->{title} = {
        title => 'Backlog',
    };

    my $this_state = $c->model("DBIC::State")->find({name => 'captured'});
    my $states = [ $this_state ];
    my $seen = {};
    while (my $next_state = $this_state->next_state) {
        $this_state = $next_state;
        push (@$states, $this_state);
        if ($seen->{$this_state}) {
            warn "circular state links! $this_state already seen";
            last;
        }
        $seen->{$this_state}++;
    }

    $c->stash->{states} = $states;

    $c->stash->{stories} = [ $c->model("DBIC::Story")->search(
							    {},
							    {prefetch => [qw/sprint created_by estimate_unit state/ ] }
							   )];

    return 1;
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
