package FlyHalf;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

use Catalyst qw/
    -Debug
    ConfigLoader
    Static::Simple

    Authentication

    Session
    Session::Store::FastMmap
    Session::State::Cookie
/;

extends 'Catalyst';

our $VERSION = '0.01';
$VERSION = eval $VERSION;

__PACKAGE__->config(
    name => 'FlyHalf',

    default_view => 'Web',
    # Configure DB sessions
    'Plugin::Session' => {
        # dbic_class => 'DB::Session',
        expires => 3600,
        storage => '/tmp/session',
        # Stick the flash in the stash
        flash_to_stash => 1,
    },

    disable_component_resolution_regex_fallback => 1,
);


# Configure SimpleDB Authentication
# Passwords in this case are saved in plain text, change password_type
# to provide your own hashing/crypto or use an off the shelf option/plugin
__PACKAGE__->config->{ 'Plugin::Authentication' } = {
    default => {
        class => 'SimpleDB',
        user_model => 'DBIC::User',
        password_type   => 'clear',
        # password_type => 'self_check',
        use_userdata_from_session => 1,
    },
};


# Start the application
__PACKAGE__->setup();


=head1 NAME

FlyHalf - Catalyst based application

=head1 SYNOPSIS

    script/flyhalf_server.pl

=head1 DESCRIPTION

A simple Agile Project tool with DWIM

=head1 SEE ALSO

L<FlyHalf::Controller::Root>, L<Catalyst>

=head1 AUTHOR

Aaron Trevena

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
