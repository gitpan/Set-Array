# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 12 };
use Set::Array;

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

my $s1 = Set::Array->new(qw(fname dan lname berger));
my $s2 = Set::Array->new(qw(to be cleared));
my $s3 = Set::Array->new(undef,1,undef,2,undef,3);
my $s4 = Set::Array->new(qw(one two three 1 2 3 one two three));
my $s5 = Set::Array->new(qw(alpha beta gamma delta));
my $s6 = Set::Array->new([1,2,3],['a','b','c']);

my $alist = Set::Array->new(qw/alpha beta beta gamma delta Delta epsilon/);
my $blist = Set::Array->new(qw/gamma delta delta epsilon zeta eta 12345/);

ok(%hash = $s1->as_hash);
ok($s1->at(0) eq 'fname');
ok($s1->delete('berger','lname')->length == 2);
ok($s1->exists('dan') == 1);

ok($s2->clear->length == 0);
ok($s2->is_empty == 1);

ok($s3->compact->length == 3);
ok($s3->delete_at(2)->length == 2);

ok($s4->count('three') == 2);
ok($s4->fill('zz')->at(1) eq 'zz');

ok($s5->first() eq 'alpha');

ok($s6->flatten->length == 6);
ok($s6->impose('-appended')->at(0) eq '1-appended');
