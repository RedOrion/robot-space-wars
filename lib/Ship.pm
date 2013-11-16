package Ship;

use Moose;
use namespace::autoclean;

# This defines the basic characteristics of a ship

# The unique ID of the ship
has 'id' => (
    is          => 'rw',
    isa         => 'Int',
    required    => 1,
);
# The ID of the ships owner
has 'owner_id' => (
    is          => 'rw',
    isa         => 'Int',
    required    => 1,
);
# The name of the ship
has 'name' => (
    is          => 'rw',
    isa         => 'Str',
);
# The type of the ship, e.g. 'battleship'
has 'type' => (
    is          => 'rw',
    isa         => 'Str',
    required    => 1,
);
# The status of the ship, e.g. 'ok' or 'dead'.
has 'status' => (
    is          => 'rw',
    isa         => 'Str',
    default     => 'ok',
);
# The health of the ship (0 to 100)
has 'health' => (
    is          => 'rw',
    isa         => 'Int',
    default     => 100,
);
# Current X co-ordinate
has 'x' => (
    is          => 'rw',
    isa         => 'Int',
    default     => 0,
);
# Current Y co-ordinate
has 'y' => (
    is          => 'rw',
    isa         => 'Int',
    default     => 0,
);
# Current direction of travel (in radians)
has 'direction' => (
    is          => 'rw',
    isa         => 'Num',
    default     => 0,
);
# Speed of ship
has 'speed' => (
    is          => 'rw',
    isa         => 'Num',
    default     => 100,
);
# Rotation rate of ship (radians per second)
has 'rotation' => (
    is          => 'rw',
    isa         => 'Num',
    default     => 1,
);

# Current orientation of travel (in radians)
has 'orientation' => (
    is          => 'rw',
    isa         => 'Num',
    default     => 0,
);
# Max speed of ship
has 'max_speed' => (
    is          => 'rw',
    isa         => 'Num',
    default     => 100,
);
# Max rotational speed (radians per second)
has 'max_rotation' => (
    is          => 'rw',
    isa         => 'Num',
    default     => 2,
);



# Create a hash representation of the object
#
sub to_hash {
    my ($self) = @_;

    return {
        id              => $self->id,
        owner_id        => $self->owner_id,
        x               => $self->x,
        y               => $self->y,
        direction       => $self->direction,
        speed           => $self->speed,
        rotation        => $self->rotation,
        orientation     => $self->orientation,
        max_speed       => $self->max_speed,
        max_rotation    => $self->max_rotation,
        name            => $self->name,
        type            => $self->type,
        status          => $self->status,
        health          => $self->health,
    };
}


# Note we should probably add the following
#  shield_against_projectiles
#  shield_against_explosives
#  shield_against_lasers
#  armour_against_projectiles
#  armour_against_explosives
#  armour_against_lasers
#  weapons



__PACKAGE__->meta->make_immutable;
