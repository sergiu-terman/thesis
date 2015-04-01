require 'rake'
require_relative 'env'
require_relative 'app'

use Faye::RackAdapter, :mount => '/faye', :timeout => 25
Faye::WebSocket.load_adapter('thin')
run MyApp