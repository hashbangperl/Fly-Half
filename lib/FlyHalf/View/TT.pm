package FlyHalf::View::TT;

use strict;
use warnings;

use base 'Catalyst::View::TT';

use File::Assets;

our $include_path = FlyHalf->path_to( 'root', 'templates' );

our $assets = File::Assets->new( base => [ '/static' ] );

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    render_die => 1,
    WRAPPER => 'site-wrapper.tt',
    INCLUDE_PATH => [
        FlyHalf->path_to( 'root', 'templates' ),
    ],
    VARIABLES => {
	page_assets => $assets,
    }

);

=head1 NAME

FlyHalf::View::TT - TT View for FlyHalf

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
