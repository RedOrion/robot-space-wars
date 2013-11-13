use strict;
use warnings;

use Safe;

my $compartment = new Safe;
#$compartment->permit(":default");

my $a = {
    foo => 'bar',
    bar => {
        fee => 2,
    },
};

sub w_get {
    return $a;
}

sub w_print {
    my ($val) = @_;
    print $val;
}
$compartment->share('&w_print');
$compartment->share('&w_get');

my $code = <<'EOT';
    my $a = w_get();
    $a->{bar}{fee}++;
    w_print $a->{bar}{fee}." ###\n";
    #print("test");
EOT

my $result = $compartment->reval($code);
if ($@) {
    print "ERROR: $@";
}


print "result [$result][$a->{bar}{fee}]\n";
1;
