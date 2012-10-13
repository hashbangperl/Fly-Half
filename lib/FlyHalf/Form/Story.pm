package FlyHalf::Form::Story;

use strict;

use warnings;
use HTML::FormHandler::Moose;

use JSON;
use URI::Escape;

extends 'HTML::FormHandler::Model::DBIC';
with 'HTML::FormHandler::Render::Simple';
with 'FlyHalf::Form::Lookup';
with 'HTML::FormHandlerX::Form::JQueryValidator';

has_field 'name'        => ( type => 'Text',     required => 1 );
has_field 'ref_code'    => ( type => 'Text',     required => 1 );
has_field 'summary'     => ( type => 'TextArea', required => 0 );
has_field 'description' => ( type => 'TextArea', required => 0 );
has_field 'start_date'  => ( type => 'Date', required => 0, format => "%d-%m-%y" );

has_field 'sprint'      => ( type => 'Select');

has_field 'priority'    => ( type => 'Text', required => 1 );

has_field 'estimate'    => ( type => 'Text', required => 0 );
has_field 'estimate_unit' => ( type=> 'Select' );

has_field 'state'  => ( type=> 'Select' );

1;
