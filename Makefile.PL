use ExtUtils::MakeMaker;

# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

WriteMakefile
(
	($] ge '5.005') ?
	(
		'AUTHOR' => 'Ron Savage (ron@savage.net.au)',
		'ABSTRACT' => 'Arrays as objects with lots of handy methods',
    ) : (),
	clean				=>
	{
		FILES			=> 'blib/* Makefile MANIFEST Set-Array-*'
	},
	dist				=>
	{
		COMPRESS		=> 'gzip',
		SUFFIX			=> 'gz'
	},
	DISTNAME			=> 'Set-Array',
	NAME				=> 'Set::Array',
	PL_FILES			=> {},
	PREREQ_PM			=>
	{
		Carp			=> 0,
		Test::More		=> 0,
		Test::Pod		=> 0,
		Want			=> 0,
	},
	VERSION_FROM		=> 'lib/Set/Array.pm',
);
