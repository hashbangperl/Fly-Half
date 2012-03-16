package FlyHalf::Controller::Sprint;
use Moose;
use namespace::autoclean;

use Data::Dumper;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

FlyHalf::Controller::Sprint - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 view

=cut

sub view :Chained('by_id') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{title} = {
        title => 'View Sprint : ' . $c->stash->{this_sprint}->name,
    };

    $c->stash->{template} = 'sprint/view.tt';

    return 1;
}

=head2 taskboard

=cut

sub taskboard :Chained('by_id') :Args(0) {
    my ($self, $c) = @_;
    $c->stash->{template} = 'sprint/taskboard.tt';
    $c->stash->{title} = {
        title => 'Sprint : ' . $c->stash->{this_sprint}->name,
    };

    my $this_state = $c->model("DBIC::State")->find({name => 'defined'});
    my $states = [ $this_state ];
    while (my $next_state = $this_state->next_state) {
	$this_state = $next_state;
	push (@$states, $this_state);
    }
    $c->stash->{states} = $states;

    my $story_tasks = {  };
    foreach my $story ($c->stash->{this_sprint}->stories) {
	my $story_id = $story->id;
	warn "story : $story_id\n";
	foreach my $task ($story->tasks({ }, {prefetch=>['estimate_unit', {tasks_assigned_to => 'user'}]})) {
	    warn "task : $task\n";
	    my $state = $task->get_column('state_id');
	    warn "state $state";
	    push(@{$story_tasks->{$story_id}{$state}}, $task);
	}
    }

    $c->stash->{story_tasks} = $story_tasks;

    return 1;

}


=head2 by_id

chained action handler for /sprint, populates sprint being modifed/viewed

checks authorisation

=cut

sub by_id : PathPart('sprint') :Chained('/') :CaptureArgs(1) {
    my ($self, $c, $sprint_id) = @_;


    my $this_sprint = $c->model( 'DBIC::Sprint' )->search(
	{'me.id' => $sprint_id},
	{ prefetch => ['stories'] }
	)->first;

    unless ($this_sprint) {
	$c->forward('/default');
	$c->stash->{area} = 'sprint';
        $c->stash->{message} = 'sprint ' . $sprint_id . 'not found';
	return 0;
    }

    $c->stash->{this_sprint} = $this_sprint;
    $c->stash->{sprint_id} = $sprint_id;

    return;
}


=head2 add_story

=cut

sub add_story :Chained('by_id') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{add_to_object} = {type=>'sprint', object => $c->stash->{this_sprint}};

    $c->go($c->controller('Story')->action_for('add'));

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
