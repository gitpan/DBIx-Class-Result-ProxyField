package t::app::Main::Result::Artist;
use base qw/DBIx::Class::Core/;
__PACKAGE__->table('artist');
__PACKAGE__->add_columns( 'artistid', {datatype => 'integer'},
                          'name', {datatype => 'varchar', public_name => 'artist_name'} );
__PACKAGE__->set_primary_key('artistid');
__PACKAGE__->has_many('cds' => 't::app::Main::Result::Cd', 'artistid');

__PACKAGE__->load_components(qw/ Result::ProxyField /);
__PACKAGE__->init_proxy_field();
1;
