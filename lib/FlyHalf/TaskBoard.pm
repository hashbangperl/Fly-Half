package FlyHalf::TaskBoard;
use strict;
use warnings;

=head1 NAME

FlyHalf::TaskBoard

=cut

use Moose;
use Carp qw(cluck confess croak carp);

has Board => (
    is => 'ro',
    isa => 'FlyHalf::Schema::Result::Board',
    required => 1,
);

has Team => (
    is => 'ro',
    isa => 'FlyHalf::Schema::Result::Team',
    required => 0,
);

has Sprint => (
    is => 'ro',
    isa => 'FlyHalf::Schema::Result::Sprint',
    required => 0,
);

has User => (
    is => 'ro',
    isa => 'FlyHalf::Schema::Result::User',
    required => 0,
);

has _story_tasks => (
    is => 'rw',
    isa => 'ArrayRef'
);

sub title {
    my $self = shift;

    my $title = $self->Team->name . ' ' . $self->board_type . ' Board';

    return $title;
}

# TODO: Cunning Plan -- columns can be schedules or states, use same subclassing as for object_story, etc

sub BUILD {
    my $self = shift;

    unless ($self->has_Team || $self->has_Sprint || $self->has_User) {
        confess ('FlyHalf::TaskBoard::new method requires Team, Sprint or User');
    }

    # get stories from sprint team or user here

    my $story_tasks = {  };
#     foreach my $story ($c->stash->{this_sprint}->stories) {
# 	my $story_id = $story->id;
# 	warn "story : $story_id\n";
# 	foreach my $task ($story->tasks({ }, {prefetch=>['estimate_unit', {tasks_assigned_to => 'user'}]})) {
# 	    warn "task : $task\n";
# 	    my $state = $task->get_column('state_id');
# 	    warn "state $state";
# 	    push(@{$story_tasks->{$story_id}{$state}}, $task);
# 	}
#     }


    #TODO: also use new planning_dates table to get things via board_column_planning side-table (todo)

    $self->_story_tasks($story_tasks);

    return;
}


sub _setup_kanban {

}


sub columns {
    my $self = shift;

    my $columns = $self->Board->columns;

    # whether to use tasks or stories should be model logic, sketch out here

}


no Moose;
__PACKAGE__->meta->make_immutable;

1;
