package FlyHalf::Model::Base;
use Moose;
use namespace::clean -except => 'meta';

=head1 NAME

Flyhalf::Model::Base

=head1 SYNOPSIS


=head1 DESCRIPTION

Base model super class for Flyhalf application models

=cut

extends qw/ Catalyst::Model /;

__PACKAGE__->config( schema => undef );


=head2 ACCEPT_CONTEXT

Take the context of this model as provided by Catalyst. From this we
get a handle on the DB model, which is the data source for all the
other models we create.

=cut

sub ACCEPT_CONTEXT {
    my ($self, $c, @args) = @_;
    $self->config->{schema} = $c->model('DBIC')
      unless ($self->config->{schema});
    $self->config->{context} = $c;
    return $self;
}

__PACKAGE__->meta->make_immutable;

1;
