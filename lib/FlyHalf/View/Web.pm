package FlyHalf::View::Web;

use strict;
use warnings;

use base 'Catalyst::View::TT';

use File::Assets;

our $include_path = FlyHalf->path_to( 'root', 'templates' );

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    render_die => 1,
    WRAPPER => 'site-wrapper.tt',
    INCLUDE_PATH => [
        FlyHalf->path_to( 'root', 'templates' ),
    ],
    VARIABLES => { },
    expose_methods => [qw/get_fresh_file_assets/],

);

sub get_fresh_file_assets {
    #TODO use config to get this path
    return File::Assets->new( base => [ '/static' ] );
}

=head1 NAME

FlyHalf::View::Web - Web TT View for FlyHalf

=head1 DESCRIPTION

TT View for FlyHalf.

=head1 SEE ALSO

L<FlyHalf>

=head1 AUTHOR

Aaron Trevena

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
