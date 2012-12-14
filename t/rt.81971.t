#!/usr/bin/env perl

use strict;
use warnings;

use Set::Array;

use Test::More tests => 4;

# -------------

my($set) = Set::Array -> new(11, 12, 13);

$set -> delete('(');

my($get) = join(', ', $set -> print);

ok($get eq '11, 12, 13', 'Chars are quoted properly in delete()');

my($count) = $set -> count('.');

ok($count == 0, 'Chars are quoted properly in count()');

my($index) = $set -> index(1);

ok($index == 0, 'Prefix is quoted properly in index()');

my($rindex) = $set -> rindex(12);

diag $rindex;

ok($rindex == 1, 'Prefix is quoted properly in rindex()');
