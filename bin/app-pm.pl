#!/usr/local/bin/perl

use 5.010;

use strict;
use warnings FATAL => 'all';
#use Carp;
#use diagnostics;

use Data::Dump 'pp';
#use Data::Dumper; sub pp { print Dumper @_ }

$|=1;

###############################################################################
use File::Basename;
use File::Find::Rule;
use File::Spec;
use Getopt::Long qw(GetOptionsFromArray);
use Pod::Usage;

our $VERSION = '0.01';

run(@ARGV);

sub run {
    my @argv = @_;

@argv = qw(-li parser);

    my %PROGRAM_OPTIONS = (
        'list|l'  => 'List all installed modules',
        'long|L'  => 'List all installed modules, with locations',
        'local'   => 'Only those modules installed in a $PERL5LIB directory, or in /usr/local',
        'sort|s'  => 'Sort the output',
        'uc|lc|i' => 'Ignore case when sorting',
        'help|h'  => 'This help message (try --man for more)',
        'man'     => 'The full documentation',
        'which|w' => 'which module will be used XXX',
    );

    Getopt::Long::Configure (
        qw( auto_version bundling ),
        qw( no_auto_abbrev no_ignore_case no_permute ),
    );

    GetOptionsFromArray( \@argv, \my %options, keys %PROGRAM_OPTIONS );

    cmd_help(\%PROGRAM_OPTIONS) if $options{help};
    pod2usage(-exitstatus => 0, -verbose => 2) if $options{man};

    cmd_list(\%options, \@argv) if $options{list};
}

sub cmd_help {
    my $opt = shift;

    say "usage: ", File::Basename::basename($0), " options";
    say "\nWhere options are:\n";

    for my $o (sort keys %$opt) {
        my $h = $opt->{$o};
        my @o = split /\|/, $o;

        say "    ", length $_ > 1 ? "--$_" : " -$_" for sort @o;
        say "        $h";
    }

    say "\nBut only a few of those work :-("; # XXX

    exit 0;
}

sub cmd_list {
    my $options = shift;
    my $argv    = shift;

    my @mods = get_installed_modules(@INC);

    my $sort_func = $options->{sort}
                    ? $options->{uc} ? sub { uc $a cmp uc $b }
                                     : sub {    $a cmp    $b }
                    : undef;
    @mods = sort $sort_func @mods
      if $sort_func;

    die "regexp wants to execute code: $_"
      if grep {/\Q(?{/} @$argv;
    my $matcher = join "|", @$argv;
    $matcher = "(?i)$matcher"
      if $options->{uc};

    for (@mods) {
        say if /$matcher/;
    }
}

sub get_installed_modules {
    my @inc = shift;

    my @found;
    for my $inc (@inc) {
        for ( File::Find::Rule->file->name('*.pm')->in($inc) ) {
            substr($_, 0, 1+length $inc) = '';
            s/\.pm$//;
            push @found, join '::', File::Spec->splitdir($_);
        }
    }

    return @found;
}
