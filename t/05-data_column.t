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
  eval "use DBIx::Class::Result::ColumnData";
  if ($@)
  {
    plan skip_all => "columns_data test need Result::ColumnData component";
    exit;
  }
  plan tests => 1;
}

system "perl t/app/insertdb.pl";

my $schema = t::app::Main->connect('dbi:SQLite:t/app/db/example.db');

use t::app::Main::Result::Track;
# becarful to respect the order of loading module
t::app::Main::Result::Track->load_components(qw/ Result::ProxyField Result::ColumnData /);
t::app::Main::Result::Track->init_proxy_field();

my $track = $schema->resultset('Track')->find(1);

my $columns_data = {
  'cd_id' => $track->cdid,
  'track_title' => $track->title,
  'trackid' => $track->trackid
};
is_deeply($track->columns_data, $columns_data, "object->columns_data return object with public name");

