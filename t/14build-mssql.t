use strict;
BEGIN {
  use Test::More;
  use Test::Exception;
  use lib 't';
  use PgLinkTestUtil;
  my $ts = PgLinkTestUtil::load_conf;
  if (!exists $ts->{TEST_MSSQL}) {
    plan skip_all => 'TEST_MSSQL not configured';
  } else {
    plan tests => 1;
  }
}

my $dbh = PgLinkTestUtil::connect();
PgLinkTestUtil::init_test();

ok(
  $dbh->selectrow_array(
    'SELECT dbix_pglink.build_accessors(?, ?, ?, ?, ?, ?::text[], ?)', 
    {}, 
    'TEST_MSSQL', # conn_name
    'northwind',  # local_schema
    'Northwind',  # remote_catalog
    'dbo',     # remote_schema
    '%',       # remote_object
    '{TABLE,VIEW}',     # remote_object_types
    undef,     # object_name_mapping
  ),
  'build accessor'
);
