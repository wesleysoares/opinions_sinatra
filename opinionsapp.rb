require 'sinatra'

SEPARATOR = "•••"

post '/opinions' do
  insert params
  opinions = retrieve_all # cada opinion é um hash com opinion e author
  erb :index, locals: { opinions: opinions }
end

get '/' do
  opinions = retrieve_all # cada opinion é um hash com opinion e author
  erb :index, locals: { opinions: opinions }
end

configure do
  $filename = "#{ENV['RACK_ENV'] || "opinions_db"}.txt"
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
  data.map do |line|
    opinion = line.split(SEPARATOR)
    { opinion: opinion[0], author: opinion[1] }
  end
end

def insert(params)
  File.open($filename, "a+") do |f|
    f << params[:opinion] << SEPARATOR << params[:author] << "\n"
  end
end
