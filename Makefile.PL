use ExtUtils::MakeMaker;

WriteMakefile(
   NAME => 'LEOCHARRE::Dir',
   VERSION_FROM => 'lib/LEOCHARRE/Dir.pm',


   # gen /usr/bin/pmused by Wed Oct  1 17:58:58 EDT 2008 
   PREREQ_PM => {
      'Carp'                              => '1',
      'Cwd'                               => '3',
      'Exporter'                          => '5',
      'Test::Simple'                      => '0',
   },


   EXE_FILES => [],
);


