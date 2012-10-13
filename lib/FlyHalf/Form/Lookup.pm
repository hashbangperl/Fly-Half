package FlyHalf::Form::Lookup;

use Moose::Role;

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

sub options_state {
   my $self = shift;
   return unless $self->schema;
   my @rows =
      $self->schema->resultset( 'State' )->
         search( {}, { order_by => ['name'] } )->all;
   return [ map { $_->id, $_->name } @rows ];
}

1;
