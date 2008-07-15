package LEOCHARRE::Dir;
use strict;
use vars qw($VERSION @ISA %EXPORT_TAGS @EXPORT_OK);
use Exporter;
@ISA = qw/Exporter/;
@EXPORT_OK = qw(reqdir ls lsa lsf lsfa lsd lsda lsr lsfr lsdr);
%EXPORT_TAGS = ( all => \@EXPORT_OK );
$VERSION = sprintf "%d.%02d", q$Revision: 1.2 $ =~ /(\d+)/g;


*reqdir = \&__require_dir;
*ls     = \&__ls;
*lsa    = \&__lsa;
*lsf    = \&__lsf;
*lsfa   = \&__lsfa;
*lsd    = \&__lsd;
*lsda   = \&__lsda;
*lsr    = \&__lsr;
*lsfr   = \&__lsfr;
*lsdr   = \&__lsdr;

sub __require_dir {
   require Cwd;
   my $_d = Cwd::abs_path(+shift) or die;
   -d $_d or mkdir $_d or warn("cant mkdir $_d") and return;
   return $_d;
}

sub __ls {
   my $abs = shift;
   $abs or die('missing argument');
   opendir(DIR, $abs) or die("cant open dir '$abs', $!");
   my @ls = grep { !/^\.+$/ } readdir DIR;
   closedir DIR;
   return @ls;
}
sub __lsa {
   my $abs = shift;
   $abs or die('missing argument');
   require Cwd;
   my $abs = Cwd::abs_path($abs) or die;
   my @ls = map { "$abs/$_" } __ls($abs);
   return @ls;
}


# no leading path
sub __lsf  { return ( grep { -f "$_[0]/$_" }       __ls(   $_[0]) ) }
sub __lsd  { return ( grep { -d "$_[0]/$_" }       __ls(   $_[0]) ) }

# absolute path
sub __lsfa { return ( grep   -f,                   __lsa(  $_[0]) ) } 
sub __lsda { return ( grep   -d,                   __lsa(  $_[0]) ) }

# relative path to docroot
sub __lsr  { return ( map { __rel2docroot($_) }    __lsa(  $_[0]) ) }
sub __lsfr { return ( map { __rel2docroot($_) }    __lsfa( $_[0]) ) }
sub __lsdr { return ( map { __rel2docroot($_) }    __lsda( $_[0]) ) }

sub __rel2docroot {
   $ENV{DOCUMENT_ROOT} or die("ENV DOCUMENT ROOT not set");
   my $p = shift;
   $p or die('missing argument');

   $p=~s/^$ENV{DOCUMENT_ROOT}// or return;
   return $p;   
}



1;


__END__

=pod

=head1 NAME

LEOCHARRE::Dir - subs for dirs

=head1 SYNOPSIS

   use LEOCHARRE::Dir ':all';

   my $dir = reqdir("./dirhere");

   my @ls = ls($dir);

   my @files = lsf($dir);

   my @dirs = lsd($dir);

   my @abs_dirs = lsda($dir);

   my @abs_files = lsfa($dir);

   my @abs_all = lsa($dir);

=head1 DESCRIPTION

Reading directories, etc.

=head1 SUBS

None are exported by default.

=head2 ls()

Argument is path to dir.
Returns list array with all files, including dirs files and symlinks, etc.

=head2 lsa()

Same as ls(), but paths are absolute.

=head2 lsf()

Argument is path to dir.
Returns list array with all files.

=head2 lsfa()

Same as lsf(), but paths are absolute.


=head2 lsd()

Argument is path to dir.
Returns list array with all dirs.

=head2 lsda()

Same as lsd(), but paths are absolute.

=head2 lsr()

Argument is path to dir.
Returns paths relative to ENV DOCUMENT ROOT.
Slash at front is included.
ENV DOCUMENT ROOT must be set or dies.
If none in list, returns undef;
If it is not within ENV DOCUMENT ROOT, returns undef.
This uses Cwd::abs_path thus it resolves symlinks, this cgi-bin may not be within
DOCUMENT ROOT, note.
Returns array list.

=head2 lsfr()

Like lsr() but returns files.

=head2 lsdr()

Like lsr() but returns dirs.

=head2 reqdir()

Argument is path to dir.
Requires that the dir exist, if not there, creates.
Returns abs path to dir requested.


=head1 SEE ALSO

Cwd

=head1 AUTHOR

Leo Charre leocharre at cpan dot org

=cut
