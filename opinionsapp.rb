require 'sinatra'
require 'sqlite3'

  post '/opinions' do
    insert params[:opinion]
    opinions = retrieve_all
    erb :index, locals: { opinions: opinions }
  end

  get '/' do
    opinions = retrieve_all
    erb :index, locals: { opinions: opinions }
  end

  configure do
    $filename = "#{ENV['RACK_ENV']}.txt"
    `touch #{$filename}`
  end

  private

  def db
    $db
  end

  def retrieve_all
    file = File.open($filename, "r+")
    data = file.readlines("\n")
    file.close
    data
  end
  def insert(params)
    File.open($filename, "a+") do |f|
      f << params.concat("\n")
    end
  end
