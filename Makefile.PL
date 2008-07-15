use ExtUtils::MakeMaker;

WriteMakefile(
   NAME => 'LEOCHARRE::Dir',
   VERSION_FROM => 'lib/LEOCHARRE/Dir.pm',


   # gen /usr/bin/pmused by Tue Jul 15 15:05:32 EDT 2008 
   PREREQ_PM => {
      'Cwd'                               => '3',
      'Exporter'                          => '5',
      'Test::Simple'                      => '0',
   },


   EXE_FILES => [],
);


