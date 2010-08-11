package Pm::Module;

use Moose;

has qw(location is ro isa Str);
has qw(name     is ro isa Str);

1;
