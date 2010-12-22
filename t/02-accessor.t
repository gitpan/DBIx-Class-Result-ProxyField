#!/usr/bin/perl -w

use Test::More;

use t::app::Main;
use strict;

system "sqlite3 t/app/db/example.db < t/app/db/example.sql";
if ($@)
{
  plan skip_all => "sqlite3 is require for these tests : $@";
  exit;
}
else
{
  plan tests => 2;
}

system "perl t/app/insertdb.pl";

my $schema = t::app::Main->connect('dbi:SQLite:t/app/db/example.db');

use t::app::Main::Result::Track;
t::app::Main::Result::Track->load_components(qw/ Result::ProxyField /);
t::app::Main::Result::Track->init_proxy_field();

my $track = $schema->resultset('Track')->find(1);

# test accessor
$track->title('title of track');
is $track->track_title, $track->title, "object->public_name return object->database_name";

$track->track_title('new title');
is $track->title, 'new title', "object->public_name(value) set object database name";

