package RSW::Ship;

use Moose;
use namespace::autoclean;

# This defines the basic characteristics of a ship

has 'id' => (
    is          => 'rw',
    isa         => 'Int',
    required    => 1,
);

has 'owner_id' => (
    is          => 'rw',
    isa         => 'Int',
    required    => 1,
);

has 'name' => (
    is          => 'rw',
    isa         => 'Str',
);

has 'type' => (
    is          => 'rw',
    isa         => 'Str',
    required    => 1,
);

has 'status' => (
    is          => 'rw',
    isa         => 'Str',
    default     => 'ok',
);

has 'health' => (
    is          => 'rw',
    isa         => 'Int',
    default     => 100,
);

# Note we should probably add the following
#  shield_against_projectiles
#  shield_against_explosives
#  shield_against_lasers
#  armour_against_projectiles
#  armour_against_explosives
#  armour_against_lasers
#  weapons



__PACKAGE__->meta->make_immutable;
