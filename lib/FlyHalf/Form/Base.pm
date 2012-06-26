package FlyHalf::Form::Base;

use strict;

use warnings;
use HTML::FormHandler::Moose;

extends 'HTML::FormHandler::Model::DBIC';
with 'HTML::FormHandler::Render::Simple';

has '+widget_name_space' => ( default => sub {['FlyHalf::Form::Field']} );



1;
