#!/usr/bin/perl -w
# ret.pl - Version 1.0.0
# Store file viewer/editor
# ret.pl [-e] <filename.store>

use strict;
use warnings;

use File::Temp;
use Storable qw( store retrieve );
use Data::Dumper;
use Getopt::Long;


my $edit;
GetOptions('e' => \$edit);

my $store = $ARGV[0];
$Data::Dumper::Sortkeys = 1;

unless (-f $store)
{
	print STDERR "$store is not a file\n";
	exit 1;
}

unless ($edit)
{
	print Dumper retrieve $store;
	exit 0;
}

my $fh = new File::Temp();
my $tmp = $fh->filename;
print "Retrieving store...\n";
print $fh Dumper retrieve $store;
$fh->close();
my $md5 = `md5sum $tmp`;
system('vim', $tmp, "+set filetype=perl");

if ($md5 eq `md5sum $tmp`)
{
	print "No change\n";
}
else
{
	print "Saving changes\n";
	our $VAR1 = undef;
	my $ret = do $tmp;
	
	die "Couldn't parse $tmp: $@" if $@;
	die "Couldn't do $tmp: $!"    unless defined $ret;
	die "Couldn't run $tmp"       unless $ret;
	
	store $VAR1, $store;
	print "Done\n";
}

1;

