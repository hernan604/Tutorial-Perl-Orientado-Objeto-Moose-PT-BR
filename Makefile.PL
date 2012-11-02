

use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME         => 'Tutorial::Perl::Orientado::Objeto::Moose::PT::BR',
    VERSION_FROM => 'lib/Tutorial/Perl/Orientado/Objeto/Moose/PT/BR.pm', # finds \$VERSION
    AUTHOR       => 'Hernan Lopes (hernanlopes . gmail.com)',
    ABSTRACT     => 'Tutorial perl Orientação a Objeto com Moose',
    PREREQ_PM    => {
                     'Test::Simple' => 0.44,
                     'Moose' => 0,
                    },
);
