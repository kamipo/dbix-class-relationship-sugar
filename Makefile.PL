use inc::Module::Install;
name 'DBIx-Class-Relationship-Sugar';
all_from 'lib/DBIx/Class/Relationship/Sugar.pm';

requires 'DBIx::Class::Schema';
requires 'autobox::String::Inflector';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
