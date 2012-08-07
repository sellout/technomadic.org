#!/usr/bin/perl -w

my ($day, $month, $year, $wday) = (localtime(time))[3..6];
$year = ($year +1900) % 100;
if ($year < 10) {
	$year = "0$year";
}
my $cent = 20;
my @mon = ('jan','feb','mar','apr','may','jun','jul','aug','sep','oct','nov','dec');
my $mon = $mon[$month++];

%comics = (Superosity  => {url     => "http://superosity.com/",
                           comic   => "http://superosity.com/comics/sup$cent$year$month$day.gif",
                           archive => "http://superosity.com/d/$cent$year$month$day.html",
                           days    => [0,1,2,3,4,5,6]
                          },
           Bobbins     => {url     => "http://bobbins.org/",
                           comic   => "http://bobbins.org/comics/$cent$year$month$day.gif",
                           archive => "http://bobbins.org/b/$cent$year$month$day.html",
                           days    => [9,1,2,3,4,5]
                          },
           Goats       => {url     => "http://goats.com/",
                           comic   => "http://goats.com/comix/$year$month/goats$year$month$day.gif",
                           archive => "http://goats.com/archive/index.html?$cent$year$month$day",
                           days    => [9,1,2,3,4,5]
                          },
           "User Friendly" => {url => "http://userfriendly.org/",
                           comic   => "http://www.userfriendly.org/images/titles/title_topleft.gif",
                           archive => "http://ars.userfriendly.org/cartoons/?id=$cent$year$month$day",
                           days    => [0,1,2,3,4,5,6]
                          },
           "Waiting For Bob" => {url => "http://waitingforbob.com/",
                           comic   => "http://waitingforbob.com/comics/$cent$year$month/$day.gif",
                           archive => "http://waitingforbob.com/index.php/$cent$year$month$day",
                           days    => [9,1,2,3,4,5,6]
                          },
           Boondocks   => {url     => "http://www.uexpress.com/ups/comics/bo/",
                           comic   => "http://www.uexpress.com/ups/comics/images/bo.gif",
                           archive => "http://www.uexpress.com/ups/comics/bo/",
                           days    => [0,1,2,3,4,5,6]
                          },
           "Red Meat"  => {url     => "http://www.redmeat.com/",
                           comic   => "http://www.redmeat.com/redmeat/$cent$year-$month-$day/index-1.gif",
                           archive => "http://www.redmeat.com/redmeat/$cent$year-$month-$day/index.html",
                           days    => [9,9,2]
                          },
           PVP         => {url     => "http://pvponline.com/",
                           comic   => "http://pvponline.com/archive/$cent$year/pvp$cent$year$month$day.gif",
                           archive => "http://pvponline.com/archive.php3?archive=$cent$year$month$day",
                           days    => [0,1,2,3,4,5,6]
                          },
           "Sluggy Freelance" => {url => "http://www.sluggy.com/",
                           comic   => "http://pics.sluggy.com/comics/$year$month${day}a.gif",
                           archive => "http://www.sluggy.com/d/$year$month$day.html",
                           days    => [0,1,2,3,4,5,6]
                          },
           "Penny Arcade" => {url => "http://www.penny-arcade.com/",
                           comic   => "http://www.penny-arcade.com/images/$cent$year/$cent$year$month${day}l.jpg",
                           archive => "http://www.penny-arcade.com/view.php3?date=$cent$year-$month-$day\&res=l",
                           days    => [9,1,9,3,9,5]
                          }
          );

print <<EOHeading
Content-type: text/html

<html>
	<head>
		<title>Comics for $cent$year\-$month\-$day</title>
	</head>
	<body>
		<h1>Comics for $cent$year-$month-$day</h1>
EOHeading
;

foreach my $comic (keys %comics) {
	unless ($comics{$comic}{days}[$wday] == $wday) {
		delete $comics{$comic};
	}
}

print "<ul>\n";
foreach my $comic (sort keys %comics) {
	print "\t<li><a href='#$comic'>$comic</a> " .
	      "(<a href='$comics{$comic}{url}'>site</a>)</li>\n";
}
print "</ul>\n";

foreach my $comic (sort keys %comics) {
	print "<h2><a name='$comic' href='$comics{$comic}{url}'>$comic</a></h2>" .
	      "<a href='$comics{$comic}{archive}'>" .
	      "<img src='$comics{$comic}{comic}' />" .
	      "</a>\n";
}

print <<EOFooter
	</body>
</html>
EOFooter
