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
$track->track_title('title of track');
$track->update();
my $track1 = $schema->resultset('Track')->find(1);
use Data::Dumper 'Dumper';
is $track1->title, 'title of track', "update without arguments works";
$track->update({title => 'new title of track'});
my $track2 = $schema->resultset('Track')->find(1);
is $track2->title, 'new title of track', "update without arguments works";

