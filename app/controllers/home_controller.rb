# I made it inherit from Actioncontroller instead ofd application controller in order to get react to render. Since its not long purely API mode. Is this ok?
class HomeController < ApplicationController

    def home
    end
end
