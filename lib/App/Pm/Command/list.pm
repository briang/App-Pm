package App::Pm::Command::list;

use App::Pm -command;

sub abstract { 'list installed modules' }

sub opt_spec {
    [ 'local|L' => 'Only those modules installed in a $PERL5LIB directory, or in /usr/local' ], # XXX
    [ 'long|l'  => 'List the fullpath to each installed modules' ],
    [ 'sort|s'  => 'Sort the output' ],
    [ 'uc|lc|i' => 'Ignore case when sorting' ],
}


sub execute {
    my ($self, $opt, $args) = @_;
}

1;
