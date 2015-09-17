require 'sinatra'
require 'sqlite3'

  post '/opinions' do
    insert params
    opinions = retrieve_all
    erb :index, locals: { opinions: opinions }
  end

  get '/' do
    opinions = retrieve_all
    erb :index, locals: { opinions: opinions }
  end

  configure do
    begin
      db = SQLite3::Database.open "#{ENV['RACK_ENV']}.db"
      db.execute "CREATE TABLE IF NOT EXISTS 
               Opinions(id INTEGER PRIMARY KEY AUTOINCREMENT, opinion TEXT)"
      set :db, db
    rescue SQLite3::Exception => e
      puts "Exception occurred"
      puts e
    end
  end


  private

  def db
    settings.db
  end

  def retrieve_all
    stm = db.prepare 'select id, opinion from Opinions'
    rs = stm.execute
    rs.map do |line|
      line[1]
    end
  end
  def insert(params)
    begin
      db.execute "insert into Opinions (opinion) values ('#{params[:opinion]}')"
    rescue SQLite3::Exception => e
      halt 500, e
    end
  end
