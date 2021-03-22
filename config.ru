require './config/environment'



use Rack::MethodOverride
use UsersController
use PlatesController
run ApplicationController
