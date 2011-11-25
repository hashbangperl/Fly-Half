#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install;
use Module::Install::Catalyst; # Complain loudly if you don't have
                               # Catalyst::Devel installed or haven't said
                               # 'make dist' to create a standalone tarball.

name 'FlyHalf';
all_from 'lib/FlyHalf.pm';

requires 'Catalyst::Runtime' => '5.80032';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'Moose';
requires 'namespace::autoclean';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats


requires (
        'Catalyst::Plugin::Authentication'           => '0',
        'Catalyst::Plugin::Authorization::Roles'     => '0',
        'Catalyst::Plugin::Session'                  => '0',
        'Catalyst::Plugin::Session::Store::DBIC'     => '0',
        'Catalyst::Plugin::Session::State::Cookie'   => '0',
        'Catalyst::Authentication::Realm::SimpleDB'  => '0',
        'Catalyst::View::Email'                      => '0',
        'Catalyst::TraitFor::Request::BrowserDetect' => '0',
        'CatalystX::RoleApplicator'                  => '0',
        'DBIx::Class::EncodedColumn'                 => '0',
        'DBIx::Class::Schema::Loader'                => '0',
        'DBIx::Class::TimeStamp'                     => '0',
        'DBIx::Class::InflateColumn::FS'             => '0',
        'HTML::FormHandler'                           => '0',
        'Method::Signatures::Simple'                 => '0',
        'MooseX::NonMoose'                           => '0',
        'XML::Feed'                                  => '0',
        'Captcha::reCAPTCHA'                         => '0',
        'HTML::Restrict'                             => '0',
        'Email::Sender'                              => '0.102360', # gets rid of -alias/-excludes warnings
        'Email::Valid'                               => '0',
        'Net::Domain::TLD'                           => '0',
        'Text::CSV::Simple'                          => '0',
        'File::Pid'                                  => '0',
);



test_requires 'Test::More' => '0.88';
catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
