package FlyHalf::Controller::Team;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

FlyHalf::Controller::Team - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 view

=cut

sub view : Local : Args( 1 ) {
    my ($self, $c, $team_id) = @_;
    $c->stash->{template} = 'team/view.tt';

    my $this_team = $c->model( 'DBIC::Team' )->search(
	{'me.id' => $team_id},
	{ prefetch => ['sprints','daily_developer_capacity_unit'] }
	)->first;

    unless ($this_team) {
	$c->forward('/default');
	return 0;
    }

    $c->stash->{this_team} = $this_team;
    ($c->stash->{current_sprint}) = grep { $_->id == $this_team->current_sprint } $this_team->sprints;

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
