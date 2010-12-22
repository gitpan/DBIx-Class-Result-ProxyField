use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'DBIx::Class::Result::ProxyField',
    AUTHOR              => q{Nicolas Oudard <noudard@weborama.com>},
    VERSION_FROM        => 'lib/DBIx/Class/Result/ProxyField.pm',
    ABSTRACT_FROM       => 'lib/DBIx/Class/Result/ProxyField.pm',
    LICENSE             => 'perl',
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'DBIx-Class-Result-ProxyField-*' },
);
