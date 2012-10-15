package FlyHalf::Form::User;

use strict;

use warnings;
use HTML::FormHandler::Moose;

extends 'HTML::FormHandler::Model::DBIC';
with 'HTML::FormHandler::Render::Simple';
with 'FlyHalf::Form::Lookup';
with 'HTML::FormHandlerX::Form::JQueryValidator';

has_field 'username' => ( type => 'Text', required => 1 );
has_field 'password' => ( type => 'Text', required => 1 );
has_field 'email' => (  type => 'Email', required => 1 );
has_field 'firstname' => ( type => 'Text', required => 0);
has_field 'surname' => (  type => 'Text', required => 0);
has_field 'profile_pic' => ( );
has_field 'profile_description' => ( type => 'TextArea', cols=>60, row=>5, required => 0 );
has_field 'location' => ( type => 'Text', required => 0);
has_field 'active' => (type=>"Checkbox");
has_field 'team' => ( type => 'Select');


1;
