package t::app::Main::Result::Cd;
use base qw/DBIx::Class::Core/;
__PACKAGE__->load_components(qw/InflateColumn::DateTime/);
__PACKAGE__->table('cd');
__PACKAGE__->add_columns( 'cdid', {datatype => 'integer'}, 
                          'artistid', {datatype => 'integer'},
                          'title', {datatype => 'varchar'} );
__PACKAGE__->set_primary_key('cdid');
__PACKAGE__->belongs_to('artist' => 't::app::Main::Result::Artist', 'artistid');
__PACKAGE__->has_many('tracks' => 't::app::Main::Result::Track', 'cdid');

__PACKAGE__->load_components(qw/ Result::ProxyField /);
__PACKAGE__->init_proxy_field();
1;
