#!/usr/bin/env perl
# Copyright © 2012-2014 Thomas Sibley <tsibley@cpan.org>

package Nopaste;
use strict;
use warnings;
use utf8;

use lib ($ENV{'SHUTTER_ROOT'} || "/usr")."/share/shutter/resources/modules";

use parent 'Shutter::Upload::Shared';
use Encode qw(encode_utf8);

my %upload_plugin_info = (
    'module'                        => "Nopaste",
    'url'                           => "https://metacpan.org/release/App-Nopaste",
    'registration'                  => "https://metacpan.org/release/App-Nopaste",
    'name'                          => "App::Nopaste",
    'description'                   => "Upload screenshots via App::Nopaste",
    'supports_anonymous_upload'     => 1,
    'supports_authorized_upload'    => 0,
    'supports_oauth_upload'         => 0,
);

binmode( STDOUT, ":utf8" );
if ($ARGV[0] and exists $upload_plugin_info{$ARGV[0]}) {
    print $upload_plugin_info{$ARGV[0]};
    exit;
}

sub init {
    my $self = shift;
    eval { require App::Nopaste };
    if ($@) {
        warn "App::Nopaste is required for this plugin to work. Please install it.\n\nError was: $@\n";
        return 0;
    }
    return 1;
}

sub upload {
    my $self = shift;
    $self->{_filename} = shift;

    my $data = do {
        local $/;
        open my $fh, "<", $self->{_filename}
            or die "Unable to open file: $self->{_filename}: $!";
        binmode($fh);
        <$fh>;
    };

    my @errors;
    my $url = eval {
        App::Nopaste::nopaste(
            text        => $data,
            filename    => encode_utf8($self->{_filename}),
            error_handler => sub {
                my ($error, $service) = @_;
                push @errors, "$service: $error";
            },
        )
    };
    if ($@ or not $url) {
        $self->{_links}{'status'} = $@ || "Error pasting: " . join(" / ", @errors);
    } else {
        $self->{_links}{'direct_link'} = $url;
        $self->{_links}{'status'} = 200;
    }

    if (eval { require Browser::Open; 1 }) {
        Browser::Open::open_browser($url);
    }
    return %{$self->{_links}};
}

1;
