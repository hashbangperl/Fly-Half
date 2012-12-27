package FlyHalf::Model::TaskBoard;
use strict;
use warnings;

=head1 NAME

FlyHalf::Model::TaskBoard

=cut

use base qw(Catalyst::Model::Factory);

__PACKAGE__->config( class => 'FlyHalf::TaskBoard' );

1;
