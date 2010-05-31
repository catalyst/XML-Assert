## ----------------------------------------------------------------------------
# Copyright (C) 2010 NZ Registry Services
## ----------------------------------------------------------------------------
package Test::XML::Assert;

use 5.006000;
use strict;
use warnings;
#use base 'Test::Builder::Module';
use Test::Builder::Module;
our @ISA = qw(Test::Builder::Module);
use XML::LibXML;
use XML::Assert;

our @EXPORT = qw(
    is_xpath_count
    does_xpath_value_match
    do_xpath_values_match
);

our $VERSION = '0.01';

my $CLASS = __PACKAGE__;
my $PARSER = XML::LibXML->new();

sub plan {
    my $tb = $CLASS->builder();
    return $tb->plan(@_);
}

sub done_testing {
    my $tb = $CLASS->builder();
    $tb->done_testing(@_);
}

sub is_xpath_count($$$$;$) {
    my ($doc, $xmlns, $xpath, $count, $name) = @_;

    # create the $xml_assert object
    my $xml_assert = XML::Assert->new();
    $xml_assert->xmlns($xmlns);

    # do the test and remember the result
    my $is_ok = $xml_assert->is_xpath_count($doc, $xpath, $count);

    my $tb = $CLASS->builder();
    return $tb->ok($is_ok, $name);
}

sub does_xpath_value_match($$$$;$) {
    my ($doc, $xmlns, $xpath, $match, $name) = @_;

    my $xml_assert = XML::Assert->new();
    $xml_assert->xmlns($xmlns);

    # do the test and remember the result
    my $is_ok = $xml_assert->does_xpath_value_match($doc, $xpath, $match);

    my $tb = $CLASS->builder();
    return $tb->ok($is_ok, $name);
}

sub do_xpath_values_match($$$$;$) {
    my ($doc, $xmlns, $xpath, $match, $name) = @_;

    my $xml_assert = XML::Assert->new();
    $xml_assert->xmlns($xmlns);

    # do the test and remember the result
    my $is_ok = $xml_assert->does_xpath_value_match($doc, $xpath, $match);

    my $tb = $CLASS->builder();
    return $tb->ok($is_ok, $name);
}

1;

__END__

=head1 NAME

Test::XML::Assert - Tests XPaths into an XML Document for correct values/matches

=head1 SYNOPSIS

 use Test::XML::Assert tests => 2;

 my $xml1 = "<foo xmlns="urn:message"><bar baz="buzz">text</bar></foo>";
 my $xml2 = "<f:foo xmlns:f="urn:message"><f:bar baz="buzz">text</f:bar></f:foo>";
 my $xml3 = "<foo><bar baz="buzz">text</bar></foo>";

 ToDo

=head1 DESCRIPTION

This module allows you to test if two XML documents are semantically the
same. This also holds true if different prefixes are being used for the xmlns,
or if there is a default xmlns in place.

It uses XML::Assert to do all of it's checking.

=head1 SUBROUTINES

=over 4

=item is_xml_same $xml1, $xml2, $name;

Test passes if the XML string in C<$xml1> is semantically the same as the XML
string in C<$xml2>. Optionally name the test with C<$name>.

=item is_xml_different $xml1, $xml2, $name;

Test passes if the XML string in C<$xml1> is semantically different to the XML
string in C<$xml2>. Optionally name the test with C<$name>.

=back

=head1 EXPORTS

Everything in L<"SUBROUTINES"> by default, as expected.

=head1 SEE ALSO

L<Test::Builder>

L<XML::LibXML>

L<XML::Assert>

=head1 AUTHOR

Andrew Chilton, E<lt>andychilton@gmail.com<gt>, E<lt>andy@catalyst dot net dot nz<gt>

http://www.chilts.org/blog/

=head1 COPYRIGHT & LICENSE

This software development is sponsored and directed by New Zealand Registry
Services, http://www.nzrs.net.nz/

The work is being carried out by Catalyst IT, http://www.catalyst.net.nz/

Copyright (c) 2009, NZ Registry Services.  All Rights Reserved.  This software
may be used under the terms of the Artistic License 2.0.  Note that this
license is compatible with both the GNU GPL and Artistic licenses.  A copy of
this license is supplied with the distribution in the file COPYING.txt.

=cut
