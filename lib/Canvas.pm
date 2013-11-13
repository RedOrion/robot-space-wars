package Canvas;

use Moose;
use namespace::autoclean;

# A canvas has a unique ID
has 'id' => (
    is          => 'rw',
    isa         => 'Str',
    required    => 1,
);
# Each canvas has subscribers
has 'subscribers' => (
    is          => 'rw',
    isa         => 'Maybe[HashRef[Client]]',
    default     => sub { {} },
);

# Update the state of the canvas for a further $duration period
sub update_state {
    my ($self, $duration) = @_;

    die "You have to implement an 'update_state' method";
}

# Unsubscribe a client from this canvas
#
sub un_subscribe_client {
    my ($self, $client) = @_;
   
    if (defined $self->subscribers) {
        delete $self->subscribers->{$client->id};
    }
}

# Subscribe a client to this canvas
#
sub subscribe_client {
    my ($self, $client) = @_;

    $self->subscribers->{$client->id} = $client;
}

# Determine if the canvas has a particular client
#
sub has_client {
    my ($self, $client) = @_;
    
    if (not defined $self->subscribers) {
        return;
    }
    if (not defined $self->subscribers->{$client->id}) {
        return;
    }
    return 1;
}
# Do something for all subscribers
#
sub for_all_subscribers {
    my ($self, $sub) = @_;
   
    foreach my $client_id ( keys %{$self->subscribers} ) {
        my $client = $self->subscribers->{$client_id};
        $sub->($client);
    }
}

# Output the state of the canvas in a hash
#
sub to_hash {
    my ($self) = @_;

    my $hash = {
        canvas    => $self->id,
    };
    return $hash;
}

__PACKAGE__->meta->make_immutable;
