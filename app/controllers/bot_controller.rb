class BotController < ApplicationController
  def index
    response.body = "I am the body of the response"
  end
end
