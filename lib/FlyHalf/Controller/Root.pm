package FlyHalf::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=head1 NAME

FlyHalf::Controller::Root - Root Controller for FlyHalf

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    # Hello World
    $c->response->body( $c->welcome_message );
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}


=head2 login

Forward to the user-facing login

=cut

sub login : Path( 'login' ) : Args( 0 ) {
    my ( $self, $c ) = @_;

    # Redirect to user login
    $c->go( 'User', 'login' );
}


=head2 logout

Forward to the logout handler

=cut

sub logout : Path( 'logout' ) : Args( 0 ) {
    my ( $self, $c ) = @_;

    # Redirect to user logout
    $c->go( 'User', 'logout' );
}

sub auto : Private {
    my ( $self, $c ) = @_;
    # Bounce if user isn't logged in and this isn't login page
    unless ( $c->user_exists
             or $c->action->private_path =~ m{user/log(out|in)} )  {
        $c->stash->{ errors } = "You must be logged in to access this site.";
        $c->stash->{redirect} = $c->action->private_path;
        $c->forward( 'user', 'login' );
        return 0;
    }
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
