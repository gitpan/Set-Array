##########################################################################
# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'
##########################################################################

use Test::More tests => 40;
BEGIN{ use_ok('Set::Array') }

my $s1 = Set::Array->new(qw(fname dan lname berger));
my $s2 = Set::Array->new(qw(to be cleared));
my $s3 = Set::Array->new(undef,1,undef,2,undef,3);
my $s4 = Set::Array->new(qw(one two three 1 2 3 one two three));
my $s5 = Set::Array->new(qw(alpha beta gamma delta));

my $alist = Set::Array->new(qw/alpha beta beta gamma delta Delta epsilon/);
my $blist = Set::Array->new(qw/gamma delta delta epsilon zeta eta 12345/);
my $dlist = Set::Array->new(qw/alpha alpha Alpha beta beta beta beta Beta/);
my $empty = Set::Array->new(undef, undef, undef);
my $flat  = Set::Array->new([1,2,3],['a','b','c']);
my $fe    = Set::Array->new(1,2,3,4,5);

# VERSION check
ok("$Set::Array::VERSION" == 0.16);

# as_hash() tests
ok(%hash = $s5->as_hash());         # base method
ok(%hash = $s5->to_hash());         # alias
ok(ref($s5->as_hash()) eq "HASH");  # return type

# at() tests
ok($s1->at(0) eq "fname");          # zero index
ok($s1->at(1) eq "dan");            # positive index
ok($s1->at(-1) eq "berger");        # negative index

# clear() tests
ok($s2->clear(1));                  # undef instead of destroy
ok(scalar(@$s2) == 3);              # make sure length remains
ok(! defined $$s2[0]);              # and that remaining values are undef
ok($s2->clear());                   # destroy instead of undef
ok(scalar(@$s2) == 0);              # make sure length is 0

# compact() tests
ok($s3->compact());                 # base method
$s3->compact();                     # call in void context...
ok(scalar(@$s3) == 3);              # ...and check that length is now 3

# count() tests
ok($s4->count("three") == 2);       # positive results
ok($s4->count("foo") == 0);         # no results
ok($s4->count("thr") == 0);         # make sure substrings/order is irrelevant

# delete() tests
ok($s4->delete("one"));             # base method
ok(scalar(@$s4) == 7);              # now only 7 elements
ok($s4->delete("thre"));            # should not delete anything
ok(scalar(@$s4) == 7);              # should still be 7

# delete_at() tests
ok(scalar(@$s1) == 4);
ok($s1->delete_at(0));              # single index
ok(scalar(@$s1) == 3);
ok($s1->delete_at(1,2));            # range
ok(scalar(@$s1) == 1);

# duplicates() tests
@ans = qw/alpha beta beta beta/;
@dups = $dlist->duplicates();
ok(eq_array(\@dups,\@ans));                  # duplicates
@dups = $s5->duplicates();
ok(eq_array(\@dups,[]));                     # no duplicates

# exists() tests
ok($s5->exists("alpha") == 1);               # should exist
ok($s5->exists("alph") == 0);                # should not exist

# fill() tests
ok($empty->fill("foo"));                     # base method
ok(eq_array($empty,["foo","foo","foo"]));    # fill

# first() tests
ok($s5->first eq "alpha");

# flatten() tests
@ans = qw/1 2 3 a b c/;
@t = $flat->flatten();
ok(eq_array(\@t,\@ans));

# foreach() tests
ok($fe->foreach(sub{ $_++ }));

{
	# object test - make sure that objects are returned if set consists of objects
	my $list1 = Set::Array->new(map { MyTestObj->new(value => $_) } 1..8);
	my $list2 = Set::Array->new(map { MyTestObj->new(value => $_) } 3..5);
	my @diff = $list1->difference($list2);
	my %items = map { ref($_) eq 'MyTestObj' ? ($_->value => 1) : () } @diff;
	ok($items{1} && $items{2} && !$items{3} && !$items{4} && !$items{5} &&
	$items{6} && $items{7} && $items{8});

	# simple test class

	package MyTestObj;

	use overload '""' => sub {
	 "MyTestObj=".shift->value;
	};

	sub new
	{
	 my $class = shift;
	 $class = ref($class) if ref($class);
	 bless { @_ }, $class;
	}

	sub value
	{
	 shift->{value}
	}
}

my($s6) = Set::Array -> new(0, 2, 4, 6);	# Test handling of 0.
my($s7) = Set::Array -> new(0, 3, 6, 9);

ok(is_deeply([$s6 -> intersection($s7)], [0, 6]) );

# Test intersection patch in V 0.15.

$s6 = Set::Array -> new(0, 2, 4, 6, 0, 6);
$s7 = Set::Array -> new(0, 3, 6, 9, 0, 6);

ok(eq_array([$s6 -> intersection($s7)], [0, 6, 0, 6]) );
