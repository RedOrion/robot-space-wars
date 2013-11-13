package Canvas::Room;

use Moose;
use namespace::autoclean;

extends 'Canvas';

# Room has a ballpit
has 'ball_pit' => (
    is          => 'rw',
    isa         => 'Ball::Pit',
    required    => 1,
);

# Update the state of the room for a further $duration period
sub update_state {
    my ($self, $duration) = @_;

    $self->ball_pit->update($duration);
}

# Output the state of the room in a hash
#
sub to_hash {
    my ($self) = @_;

    my $hash = {
        room    => $self->id,
        ballpit => $self->ball_pit->to_hash,
    };
    return $hash;
}

__PACKAGE__->meta->make_immutable;
