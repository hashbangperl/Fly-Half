use strict;

use lib qw(t/lib);
use testdata;

use Test::More;

testdata::cleandown_db();

testdata::populate_db();

ok(1);

done_testing;
