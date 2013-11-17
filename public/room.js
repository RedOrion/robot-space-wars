(function($){
    $.fn.extend({
        room: function(o) {
            var self    = this;

            self.playerId = null;
            self.players = {};
            var defaults = {};
            var options = $.extend(defaults, o);

            self.displayMessage = function (msg) {
                $(this).html(msg);
            };

            self.addPlayer = function(player) {
                self.players[player.id] = player;
            };

            self.getPlayer = function(id) {
                if (id) {
                    return self.players[id];
                }
                return self.players[self.playerId];
            };

            self.init = function() {
                //console.log('init');
            };

            function Player(options) {
                var player = this;

                player.id = options.id;
            }

            return self.each(function() {
                var o = options;

                self.displayMessage('Connecting...');

                // Connect to WebSocket
                var ws = new WebSocket(o.url);

                ws.onerror = function(e) {
                    self.displayMessage("Error: " + e);
                };

                ws.onopen = function() {
                    self.displayMessage('Connected. Loading...');

                    self.init();

                };

                ws.onmessage = function(e) {
                    var data = $.evalJSON(e.data);
                    var type = data.type;
                    var content = data.content;
                    //console.log('Message received');
//                    $('#debug').html(e.data);

                    if (type == 'new_client') {
                        //console.log('New player connected');
                        var player = new Player({
                            "id" : content.id
                        });
                        self.addPlayer(player);
                    }
                    else if (type == 'old_client') {
                        //console.log('Player disconnected');
                        delete self.players[content.id];
                    }
                    else if (type == 'rooms') {
                        $('#top').html("room content = ["+content[$('#room').val()]+"]");
                    }
                    else if (type == 'room_data') {
                        var c_arena = content.arena;
                        var date = new Date();
                        init_t = date.getTime();

                        var c_ships = c_arena.ships;
                        // first time in.
                        if ('undefined' === typeof arena.ships) {
                            arena.ships = new Array();
                        }
                        var ships = new Array();
                        for (var i=0; i<c_ships.length; i++) {
                            var c_ship = c_ships[i];
                            ships[i] = new Ship({
                                x           : c_ship.x,
                                y           : c_ship.y,
                                direction   : c_ship.direction,
                                speed       : c_ship.speed,
                                rotation    : c_ship.rotation,
                                orientation : c_ship.orientation,
                                status      : c_ship.status,
                                health      : c_ship.health,
                                init_t      : init_t
                            });
                        }
                        arena.ships = ships;
                    }
                };

                ws.onclose = function() {
                    $('#top').html('');
                    self.displayMessage('Disconnected. <a href="/">Reconnect</a>');
                };

                $('#room').keyup(function() {
        //            $('#debug').html('room change');
                    ws.send($.toJSON({"type" : "room", "content" : { "number" : $('#room').val() } } ));
                });

            });
        }
    });
})(jQuery);
