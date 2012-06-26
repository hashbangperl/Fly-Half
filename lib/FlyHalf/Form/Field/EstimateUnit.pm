package FlyHalf::Form::Field::Sprint;
use strict;
use HTML::FormHandler::Moose;

extends 'HTML::FormHandler::Model::DBIC';

sub options_estimate_unit {
   my $self = shift;
   return unless $self->schema;
   my @rows =
      $self->schema->resultset( 'EstimateUnit' )->
         search( {}, { order_by => ['name'] } )->all;
   return [ map { $_->id, $_->to_string } @rows ];
}


1;
