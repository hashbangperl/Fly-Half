use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'FlyHalf' }
BEGIN { use_ok 'FlyHalf::Controller::Project' }

ok( request('/project')->is_success, 'Request should succeed' );
done_testing();
