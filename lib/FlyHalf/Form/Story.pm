package FlyHalf::Form::Story;

use strict;

use warnings;
use HTML::FormHandler::Moose;

extends 'HTML::FormHandler::Model::DBIC';
with 'HTML::FormHandler::Render::Simple';

has_field 'name'        => ( type => 'Text',     required => 1 );
has_field 'ref_code'    => ( type => 'Text',     required => 1 );
has_field 'summary'     => ( type => 'TextArea', required => 0 );
has_field 'description' => ( type => 'TextArea', required => 0 );
has_field 'start_date'  => ( type => 'Date', required => 0);
has_field 'estimate_unit' => ( type=> 'Select' );
has_field 'estimate'    => ( type => 'Text', required => 0 );
has_field 'sprint'      => ( type => 'Select');
has_field 'priority'    => ( type => 'Text', required => 0 );

sub options_estimate_unit {
   my $self = shift;
   return unless $self->schema;
   my @rows =
      $self->schema->resultset( 'EstimateUnit' )->
         search( {}, { order_by => ['name'] } )->all;
   return [ map { $_->id, $_->to_string } @rows ];
}

sub options_sprint {
   my $self = shift;
   return unless $self->schema;
   my @rows =
      $self->schema->resultset( 'Sprint' )->
         search( {}, { order_by => ['name'] } )->all;
   return [ map { $_->id, $_->name } @rows ];
}

1;
