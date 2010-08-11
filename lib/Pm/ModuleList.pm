package Pm::ModuleList;

use Moose;

use Pm::Module

has qw(modules is ro isa ArrayRef[Pm::Module]),
  default => sub {[]},
  traits  => ['Array'],
  handles => {
      add_module => 'push',
  };

1;
