package RSW;
use Mojo::Base 'Mojolicious';





sub startup {
    my ($self) = @_;

    $self->secret('Icydee is a cool dude!');
    
    my $r = $self->routes;

    $r->any('/' => sub {
        my ($self) = @_;

    } => 'index');
}
1;

