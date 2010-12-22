package t::app::Main::Result::Track;
use base qw/DBIx::Class::Core/;
__PACKAGE__->table('track');
__PACKAGE__->add_columns( 'trackid', {datatype => 'integer'}, 
                          'cdid', {datatype => 'integer', public_name => 'cd_id'},
                          'title', {datatype => 'varchar', public_name => 'track_title'});
__PACKAGE__->set_primary_key('trackid');
__PACKAGE__->belongs_to('cd' => 't::app::Main::Result::Cd', 'cdid');

1;
