use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'App::Pm',
    license             => 'perl',
    dist_author         => q{brian greenfield <briang@cpan.org>},
    dist_version_from   => 'lib/App/Pm.pm',
    build_requires => {
        'Test::More' => 0,
    },
    add_to_cleanup      => [ 'App-Pm-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
