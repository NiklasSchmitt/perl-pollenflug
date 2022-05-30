#!/usr/bin/perl

package DANCER::Server;
use strict;
use warnings;
use Dancer2 appname => 'DANCER::Server';
use Data::Dumper;
use LWP::UserAgent;
use JSON;

set charset => 'utf8';

# Note that the public directory name is not included in the URL.
# A file ./public/css/style.css is made available as http://example.com/css/style.css

get '/' => sub {
	my $lastUpdate = "n/a";
	my $nextUpdate = "n/a";

	my $legend;
	$legend->{"0"} = "keine Belastung";
	$legend->{"0-1"} = "keine bis geringe Belastung";
	$legend->{"1"} = "geringe Belastung";
	$legend->{"1-2"} = "geringe bis mittlere Belastung";
	$legend->{"2"} = "mittlere Belastung";
	$legend->{"2-3"} = "mittlere bis hohe Belastung";
	$legend->{"3"} = "hohe Belastung";

	my @tableData;

	my $dwd = "https://opendata.dwd.de/climate_environment/health/alerts/s31fg.json";

	my $json = JSON->new()->canonical(1);
	$json->utf8(1);
	my $ua = new LWP::UserAgent;
	my $request = new HTTP::Request('GET', $dwd);
	my $response = $ua->request($request);
	my $data;

	if ($response->is_success)
	{
		$data = $json->decode($response->content);
		my $pollen = $data->{'content'};

		$nextUpdate = $data->{'next_update'};
		$lastUpdate = $data->{'last_update'};

		my $i = 0;
		while (defined($data->{'content'}[$i]))
		{
			my $info = $data->{'content'}[$i];
			my $weed;

			foreach my $types (qw(Birke Erle Hasel Esche Graeser Roggen Beifuss Ambrosia))
			{
				$weed->{lc($types)} = $info->{'Pollen'}{$types}{'today'};
				$weed->{lc($types).'legend'} = "$types - $info->{'Pollen'}{$types}{'today'} - $legend->{$info->{'Pollen'}{$types}{'today'}}";
			}

			$weed->{'region'} = $info->{'region_name'};
			$weed->{'partregion'} = $info->{'partregion_name'};
			if ($weed->{'partregion'} eq "")
			{
				$weed->{'partregion'} = $weed->{'region'};
				$weed->{'region'} = "";
			}

			push @tableData, $weed;
			$i++;
		}
	}
	else
	{
		template "index", {error => "error while requesting data from DWD: $response->status_line\n", lastUpdate => "n/a", nextUpdate => "n/a"};
	}

	template "index", {lastUpdate => $lastUpdate, nextUpdate => $nextUpdate, tableData => \@tableData};
};

dance;
