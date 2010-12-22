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

my $track1 = $schema->resultset('Track')->find(1);
my @track2 = $schema->resultset('Track')->search({track_title => $track1->title});
is $track1->id, $track2[0]->id, "search is possible with public name";

my $track3 = $schema->resultset('Track')->create({track_title => "this is a track title", cd_id => 1});
my $track4 = $schema->resultset('Track')->find($track3->id);
is_deeply $track3->track_title, $track4->track_title, "create is possible with public name";

