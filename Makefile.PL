use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
	      'NAME'	=> 'AutoSplit',
	      'VERSION_FROM' => 'AutoSplit.pm', # finds $VERSION
	      'INSTALLDIRS' => 'perl',
	      'dist' => { COMPRESS => 'gzip -9f' },
);
