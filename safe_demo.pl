use strict;
use warnings;

use Safe;
use Data::Dumper;

my $compartment = new Safe;
$compartment->permit(":load",qw(pack sort print));

my $scratchpad = {};

sub w_get_scratchpad {
    return $scratchpad;
}

sub w_print {
    my ($val) = @_;
    print $val;
}
sub w_Dumper {
    my ($arg) = @_;
    print "got here\n";
    print Dumper(\$arg);
}
w_print(w_Dumper({foo => 1}));

$compartment->share('w_print');
$compartment->share('$scratchpad');
$compartment->share('w_Dumper');

my $code = <<'EOT';
    use strict;
    use warnings;
    use Data::Dumper;

    my $s = $scratchpad;
    if (not $s->{init}) {
        $s->{init} = 1;
        $s->{counter} = 1;
    }
    else {
        $s->{counter}++;
    }
    w_print "Counter: ".w_Dumper($s)."\n";
EOT

for (my $i = 0; $i < 10; $i++) {
    my $result = $compartment->reval($code);
    if ($@) {
        print "ERROR: $@";
        exit;
    }
}

print 'result: '.Dumper($scratchpad);
1;
