#!/usr/bin/perl -w
use strict;

use DBI;
use CGI;

my $dsn = "dbi:mysql:database=students;host=localhost;port=3306";
my $dbh = DBI->connect($dsn, "root", "PerlStudent") or die "SQL Error: $DBI::errstr\n";

my $cgi = CGI->new();

my $name = $cgi->param('name');
my $comment = $cgi->param('comment');

my $sth;
if($name eq '')
{
	$sth = $dbh->do("insert into Comments_Book (comment, time) values (?, ?)", {}, $comment, time) or die "SQL Error: $DBI::errstr\n";
}
else
{
	$sth = $dbh->do("insert into Comments_Book (name, comment, time) values (?, ?, ?)", {}, $name, $comment, time) or die "SQL Error: $DBI::errstr\n";
}

$dbh->disconnect;

print $cgi->redirect('index.pl');