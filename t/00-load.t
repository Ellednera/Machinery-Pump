#!perl
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Machinery::Pump' ) || print "Bail out!\n";
}

diag( "Testing Machinery::Pump $Machinery::Pump::VERSION, Perl $], $^X" );
