#!/usr/bin/perl -w
use strict;
use File::Find qw(find);
use File::Spec qw(splitdir);

my $depth           = 0;
my $number_of_dir   = 0;
my $number_of_files = 0;

find( \&wanted, shift || '.' );

print sprintf "%d directories, %d files\n", $number_of_dir, $number_of_files;

sub wanted {
    if ( $_ eq '.' || $_ eq '..' ) {
        print $File::Find::name, $/;
        $number_of_dir--;
    }

    if (-d) {
        ++$number_of_dir;
        $depth = scalar File::Spec->splitdir($File::Find::name);
        print "   |" x $depth, '-- ', $_, '/', $/ unless $_ eq '.' or $_ eq '..';
    }
    else {
        ++$number_of_files;
        print "   |" x ( $depth + 1 ), '-- ', $_, $/;
    }
}