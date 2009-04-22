use ExtUtils::MakeMaker;

WriteMakefile(
   NAME => 'LEOCHARRE::Dir',
   VERSION_FROM => 'lib/LEOCHARRE/Dir.pm',
   

   # gen /usr/bin/pmused by Wed Apr 22 10:35:47 EDT 2009 
   PREREQ_PM => {
      'Carp'                              => '1',
      'Cwd'                               => '3',
      'Exporter'                          => '5',
      'File::Path'                        => '2.07',
      'Test::Simple'                      => '0',
   },

   
   LICENSE => 'perl',
   
   
   
   EXE_FILES => [],
);


