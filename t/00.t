use Test::Simple 'no_plan';
use lib './lib';
use LEOCHARRE::Dir ':all';
use strict;

my $x = 0;
sub ok_part {
   no warnings;
   printf STDERR "\n\n===\nPART %s %s\n\n", $x++, (+shift);
   return 1;
}

ok_part();

my $_d = './t/testdir';
system( "rm -rf '$_d'") if -d $_d;

ok ( ! -d $_d );

my $dir = reqdir($_d);
ok($dir, "dir $dir");

ok -d $dir, 'made';

ok ! lsa($dir), 'nothing there yet';

ok reqdir( "$dir/one" );
ok reqdir( "$dir/two" );
ok reqdir( "$dir/three");

ok_part();



for ( 0 .. 1 ) {
   `touch '$dir/f$_'`;
   ok -f "$dir/f$_",'made file';
}


my @l = ls($dir);
ok( scalar @l, "have [@l]");

@l = lsa($dir);
ok( scalar @l, "lsa have [@l]");

@l = lsf($dir);
ok( scalar @l, "lsf have [@l]");

@l = lsd($dir);
ok( scalar @l, "lsd have [@l]");


@l = lsda($dir);
ok( scalar @l, "lsda have [@l]");

@l = lsfa($dir);
ok( scalar @l, "lsfa have [@l]");


ok_part('failtest');

ok( ! eval { ls(); } );




ok_part('rels');
require Cwd;
$ENV{DOCUMENT_ROOT} = Cwd::cwd() .'/t';

my @r = lsr($dir);
ok scalar @r, "have rels [@r]";

@r = lsfr($dir);
ok scalar @r, "lsfr have rels [@r]";

@r = lsdr($dir);
ok scalar @r, "lsdr have rels [@r]";








system( "rm -rf $_d");
exit;
