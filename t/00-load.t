#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'App::Pm' ) || print "Bail out!
";
}

diag( "Testing App::Pm $App::Pm::VERSION, Perl $], $^X" );
