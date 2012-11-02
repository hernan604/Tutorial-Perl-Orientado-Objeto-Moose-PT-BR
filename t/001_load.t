# -*- perl -*-

# t/001_load.t - check module loading and create testing directory

use Test::More tests => 2;

BEGIN { use_ok( 'Tutorial::Perl::Orientado::Objeto::Moose::PT::BR' ); }

my $object = Tutorial::Perl::Orientado::Objeto::Moose::PT::BR->new ();
isa_ok ($object, 'Tutorial::Perl::Orientado::Objeto::Moose::PT::BR');


