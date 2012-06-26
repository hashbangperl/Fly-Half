package FlyHalf::Form::Field::Sprint;
use strict;
use HTML::FormHandler::Moose;

extends 'HTML::FormHandler::Model::DBIC';

sub options_sprint {
   my $self = shift;
   return unless $self->schema;
   my @rows =
      $self->schema->resultset( 'Sprint' )->
         search( {}, { order_by => ['name'] } )->all;
   return [ map { $_->id, $_->name } @rows ];
}

1;
