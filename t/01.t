#!perl
# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { $| = 1; print "1..16\n"; }
END {print "not ok 1\n" unless $loaded;}
use AutoSplit;
use File::Path;
$loaded = 1;
print "ok 1\n";

print $AutoSplit::VERSION > 1 ? "" : "not ", "ok 2 ($AutoSplit::VERSION)\n";

rmtree "auto";
mkdir "auto", 0755;
autosplit("AutoSplit.pm", "auto");
opendir DIR, "auto";
@files = grep { -f "auto/$_" } readdir DIR;
print @files == 0 ? "" : "not ", "ok 3 (@files)\n";

autosplit("AutoSplit.pm", "auto", 0, 0, 0);
print -d "auto/AutoSplit" ? "" : "not ", "ok 4\n";
opendir DIR, "auto";
@dirs = grep { -d "auto/$_" } readdir DIR;
print @dirs == 5 ? "" : "not ", "ok 5\n";

my $i = 6;
for my $file (
	      qw(
auto/AutoSplit/test1.al
auto/AutoSplit/test2.al
auto/AutoSplit/test3.al
auto/AutoSplit/testtesttesttest4_1.al
auto/AutoSplit/testtesttesttest4_2.al
auto/AutoSplit/test6.al
auto/AutoSplit/autosplit.ix
auto/Just/Another/test5.al
auto/Yet/Another/AutoSplit/testtesttesttest4_1.al
auto/Yet/Another/AutoSplit/testtesttesttest4_2.al
		)
	     ) {
    print -f $file ? "" : "not ", "ok ", $i++, " ($file)\n";
}
unshift @INC, ".";
require AutoLoader;
*AutoSplit::AUTOLOAD =
*AutoSplit::AUTOLOAD = \&AutoLoader::AUTOLOAD;

print AutoSplit::test6()=~/^AutoSplit/ ? "ok 16\n" : "not ok 16\n";

rmtree "auto";
