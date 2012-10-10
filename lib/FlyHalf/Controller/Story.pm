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

use Carp qw(carp cluck confess);
use Data::Dumper;

use HTML::FormHandler;
use FlyHalf::Form::Story;

=head2 backlog

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

=head2 add

=cut

sub add : Local : Args(0) {
    my ( $self, $c ) = @_;

    return $c->forward('save');
}

=head2 edit

=cut

sub edit : Chained('by_id') :Args(0) {
    my ( $self, $c ) = @_;

    return $c->forward('save');
}


=head2 by_id

chained action handler for /sprint, populates sprint being modifed/viewed

checks authorisation

=cut

sub by_id : PathPart('story') :Chained('/') :CaptureArgs(1) {
    my ($self, $c, $story_id) = @_;

    my $this_story = $c->model( 'DBIC::Story' )->search(
        {'me.id' => $story_id},
        { prefetch => [qw/state tasks estimate_unit/] }
	)->first;

    unless ($this_story) {
        $c->forward('/default');
        $c->stash->{area} = 'story';
        $c->stash->{message} = 'story ' . $story_id . 'not found';
        return 0;
    }

    $c->stash->{this_story} = $this_story;
    $c->stash->{story_id} = $story_id;

    return;
}


####


# both creation and editing happens here
sub save : Private {
    my ($self, $c) = @_;

    # if the item doesn't exist, we'll just create a new result
    my $item = $c->stash->{item} || $c->model('DBIC::Story')->new_result({});
    my $form = FlyHalf::Form::Story->new( item => $item );

    $c->stash( form => $form, template => 'story/edit.tt' );

    if($c->req->param('submitted')) {

        # the "process" call has all the saving logic,
        #   if it returns False, then a validation error happened
        my $params = $c->req->params;

        # get current sprint, state, etc and put in params

        my $ok = $form->process( params => $params,   );
        carp Dumper(form => $form);
        unless ($ok) {
            carp Dumper (errors=>$form->errors);
            return;
        }

        $c->stash->{status_msg} = "Story saved!";
        $c->res->redirect('/story/view/'. $item->id);
    }
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
