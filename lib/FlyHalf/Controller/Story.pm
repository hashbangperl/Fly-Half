package FlyHalf::Controller::Story;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

FlyHalf::Controller::Story - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

use HTML::FormHandler;

=head2 index

=cut

sub backlog : Local :Args(0) {
    my ( $self, $c ) = @_;

    $c->stash->{template} = 'story/backlog.tt';
    $c->stash->{title} = {
        title => 'Backlog',
    };

    my $this_state = $c->model("DBIC::State")->find({name => 'captured'});
    my $states = [ $this_state ];
    while (my $next_state = $this_state->next_state) {
	$this_state = $next_state;
	push (@$states, $this_state);
    }
    $c->stash->{states} = $states;

    $c->stash->{stories} = [ $c->model("DBIC::Story")->search(
							    {},
							    {prefetch => [qw/sprint created_by estimate_unit state/ ] }
							   )];

    return 1;
}

sub add : Local : Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'story/add.tt';

    my $form = HTML::FormHandler->new( field_list => [
						      'username' => { type => 'Text' },
						      'selections' => { type => 'Select' },
						     ]
				     );
    return 1;
}

=head1 AUTHOR

Aaron Trevena

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
