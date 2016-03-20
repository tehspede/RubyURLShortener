require 'sinatra/base'
require_relative '../lib/short'

class ApplicationController < Sinatra::Base
  set :root, File.dirname(__FILE__)+'/../'
  set :port, 9494
  set :bind, '0.0.0.0'

  get '/' do
    erb :index
  end

  post '/' do
    short = Short.new
    short.url = params[:url]

    if short.unique_short?
      'http://' + request.host_with_port + '/' + short.save
    elsif !short.unique_short?
      short.shorten
      while !short.save
        short.shorten
      end
      'http://' + request.host_with_port + '/' + short.short
    end
  end

  get '/:short' do
    short = Short.new
    short.short = params[:short].to_s

    if short.old_url
      redirect short.old_url
    else
      redirect '/'
    end
  end
end