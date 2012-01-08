package FlyHalf::Controller::User;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

FlyHalf::Controller::User - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

use HTML::FormHandler;

=head2 login

Login logic.

=cut

sub login : Local : Args( 0 ) {
    my ( $self, $c ) = @_;

    warn "in login : \n";

    # If we already have a logged-in user, bounce them to their profile
    if ( $c->user_exists ) {
        $c->response->redirect( $c->uri_for( '/user/profile' ) );
        return;
    }

    $c->stash->{template} = 'login.tt';
    # Get the username and password from form
    my $username = $c->request->param( 'username' ) || undef;
    my $password = $c->request->param( 'password' ) || undef;

    # If the username and password values were found in form
    if ( $username and $password ) {
        # Check the account is active
        my $check = $c->model( 'DBIC::User' )->find({ username => $username });
        unless ( $check ) {
            $c->stash->{ errors } = ["Bad username or password."];
            return;
        }
        unless ( $check->active ) {
            $c->stash->{ errors } = ['Account unavailable.'];
            $c->response->redirect( $c->uri_for( '/' ) );
            return;
        }
        # Attempt to log the user in
        my $authenticated = $c->authenticate({ username => $username,
                                               password => $password });
        if ( $authenticated ) {
            # If successful, bounce them back to the referring page or profile
            if ( $c->request->param('redirect') and
                 $c->request->param('redirect') !~ m{user/log(out|in)} ) {
                $c->response->redirect( $c->request->param( 'redirect' ) );
            } else {
                $c->forward( '/user/profile' );
            }
            return;
        } else {
            # Set an error message
            $c->stash->{ errors } = ['Bad username or password.'];
        }
        $c->stash->{message} = 'Unable to log in, please see error message';
    }

    return 1;
}

=head2 profile

=cut

sub profile : Local : Args( 0 ) {
    my ($self, $c) = @_;
    $c->stash->{template} = 'user/profile.tt';
}

=head2 logout

Logout logic.

=cut

sub logout : Local : Args( 0 ) {
    my ( $self, $c ) = @_;

    # Clear the user's session
    $c->logout;

    # Set a status message
    $c->stash->{ status_msg } = 'You have been logged out.';

    # Send the user to the site's homepage
    $c->forward( '/user/login' );
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
