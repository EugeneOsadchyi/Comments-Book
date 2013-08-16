#!/usr/bin/perl -w
use strict;
use DBI;

my $dsn = "dbi:mysql:database=students;host=localhost;port=3306";
my $dbh = DBI->connect($dsn, "root", "PerlStudent") or die "SQL Error: $DBI::errstr\n";

print "Content-type: text/html\n\n";


print <<EOT;
	<!DOCTYPE html>
	<HTML lang="en">
	<HEAD>
		<TITLE>Comments Book</TITLE>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link href="css/bootstrap.min.css" rel="stylesheet">
	</HEAD>
	<BODY>
		<script src="http://code.jquery.com/jquery.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<div class="container">
			<div class="page-header">
				<H1>Comments Book <small>Leave your comments here</small></H1>
			</div>
			</div>
		<div class="container">
			<FORM CLASS="navbar-form pull-left" ACTION="make_comment.pl" METHOD="GET">
				<P class="lead">Name: 
				<INPUT TYPE="TEXT"  NAME="name" VALUE="" size="30", MAXLENGTH="50"></P>
				<P class="lead">Comment:<BR>
				<textarea NAME="comment" rows="10" size="700" VALUE="" style="width: 900px" required></textarea>
				</P>
				<P class="lead"><INPUT TYPE="SUBMIT" class="btn btn-primary" data-loading-text="Loading..." VALUE="Send">
				<INPUT TYPE="RESET" CLASS="btn" VALUE="Clear">
				</P>
			</FORM>
		</div>
EOT

my $sth = $dbh->prepare("SELECT * FROM Comments_Book ORDER BY time DESC");
$sth->execute();

print "<div class=\"container\">";
while (my @row = $sth->fetchrow_array) 
{
	print "<blockquote><p>$row[2]</P><small><strong>$row[1]</strong>, " . localtime($row[3]) . "</small></blockquote>";
}
print "<div class=\"container\">";
print <<EOT;
<div class="footer">
		<div class="container">
			<p class="muted credit" align="center">
			2013
			</p>
		</div>
		</div>
	</BODY>
</HTML>
EOT
