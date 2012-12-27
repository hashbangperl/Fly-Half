package FlyHalf::Controller::Boards;
use Moose;
use namespace::autoclean;

use Data::Dumper;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

FlyHalf::Controller::Boards - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut



=head2 taskboard

=cut

sub taskboard :Chained('by_object') :Args(0) {
    my ($self, $c) = @_;

    my $board = $c->stash->{board};
    $c->stash->{template} = 'boards/taskboard.tt';

    my $TaskBoard = $c->model('TaskBoard',
                              { Team => $c->stash->{this_team},
                                Board => $c->stash->{this_board} });

    # move this into model
    $c->stash->{title} = $TaskBoard->title;

    return 1;
}

=head2 by_object

chained action handler for /Boards, populates Board with relevent object
and metadata

=cut

sub by_object : PathPart('Boards') :Chained('/') :CaptureArgs(1) {
    my ($self, $c, $team_id) = @_;

    # Probably sketch out code here to get current relevent project/etc for board
    # then move into a Model

    if ($team_id eq 'current') {
        $team_id = $c->user->teams->[0];
    }

    my $this_team;
    if ( $team_id ) {
        $this_team = $c->model( 'DBIC::Sprint' )->search(
            {'me.id' => $team_id},
            { prefetch => ['stories'] }
        )->first;
    }

    unless ($this_team) {
        $c->forward('/default');
        $c->stash->{area} = 'team';
        $c->stash->{message} = 'team ' . $team_id . 'not found';
        return 0;
    }

    $c->stash->{this_team} = $this_team;
    $c->stash->{team_id} = $team_id;
    $c->stash->{this_board} = $this_team->board;

    return;
}



=head1 AUTHOR

Aaron Trevena

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
