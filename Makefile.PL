use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'Set::Array',
    'VERSION_FROM'	=> 'Array.pm',
    'PREREQ_PM'		=> {'Want' => '0.05'},
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'Array.pm', # retrieve abstract from module
       AUTHOR     => 'Daniel Berger <djberg96@hotmail.com>') : ()),
);
