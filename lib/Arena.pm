package Arena;

# An arena contaning many ships

use Moose;
use Ship;
use namespace::autoclean;
use Data::Dumper;

use constant PI => 3.14159;

# An array of all the ships in the Arena
#
has 'ships' => (
    is      => 'rw',
    isa     => 'ArrayRef[Ship]',
    default => sub { [] },
);
# The width of the arena (in pixels)
#
has 'width' => (
    is      => 'rw',
    isa     => 'Int',
    default => 1000,
);
# The height of the arena (in pixels)
#
has 'height' => (
    is      => 'rw',
    isa     => 'Int',
    default => 1000,
);
# The 'time' (in seconds) from when the Tournament was started
# 
has 'start_time' => (
    is      => 'rw',
    isa     => 'Int',
    default => -1,
);
has 'end_time' => (
    is      => 'rw',
    isa     => 'Int',
    default => -1,
);
# The duration (in milliseconds) from each calculation
#
has 'duration' => (
    is      => 'rw',
    isa     => 'Int',
    default => 500,
);

# Create an Arena with random ships
#
sub BUILD {
    my ($self) = @_;

    my @ships;
    for (my $i=0; $i < 4; $i++) {
        my $start_x = int(rand(400) + 200);
        my $start_y = int(rand(400) + 200);
        my $speed   = rand(50) + 50;
        my $direction   = rand(PI * 2);

        my $ship = Ship->new({
            id              => $i,
            owner_id        => $i % 2,
            type            => 'ship',
            x               => $start_x,
            y               => $start_y,
            thrust_forward  => $speed,
            orientation     => $direction,
            rotation        => 0,
        });
        push @ships, $ship;
    }
    $self->ships(\@ships);
    $self->update($self->duration);
}

# Update the arena by a number of milliseconds
sub update {
    my ($self, $duration) = @_;

    if ($self->start_time < 0) {
        # then this is the first time.
        $self->start_time(0);
        $self->end_time($duration);
    }
    else {
        $self->start_time($self->start_time + $duration);
        $self->end_time($self->end_time + $duration);
    }
    # this is only temporary until we have some 'external' control programs.
    # 'drukards walk'
    # 
    foreach my $ship (@{$self->ships}) {
        my $new_direction;

        if ($ship->x > $self->width - 100) {
            $new_direction = rand(PI) + PI / 2;
        }
        if ($ship->x < 100) {
            $new_direction = rand(PI / 2);
        }
        if ($ship->y > $self->height - 100) {
            $new_direction = rand(PI);
        }
        if ($ship->y < 100) {
            $new_direction = rand(PI) + PI;
        }
        if (not $new_direction) {
            $new_direction = rand(PI * 2);
        }
        # Move the required distance
        my $distance = $ship->speed * $duration / 1000;
        my $delta_x = $distance * cos($ship->direction);
        my $delta_y = $distance * sin($ship->direction);
        $ship->x(int($ship->x + $delta_x));
        $ship->y(int($ship->y - $delta_y));

        $ship->direction($new_direction);
        $ship->orientation($new_direction);
    }
}


# Create a hash representation of the object
#
sub to_hash {
    my ($self) = @_;

    my @ships_ref;
    foreach my $ship (@{$self->ships}) {
        push @ships_ref, $ship->to_hash;
    }
    return {
        width   => $self->width,
        height  => $self->height,
        time    => $self->start_time,
        ships   => \@ships_ref,
    };
}

__PACKAGE__->meta->make_immutable;


