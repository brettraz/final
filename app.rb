# Set up for the application and database. DO NOT CHANGE. #############################
require "sinatra"                                                                     #
require "sinatra/reloader" if development?                                            #
require "sequel"                                                                      #
require "logger"                                                                      #
require "twilio-ruby"                                                                 #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB ||= Sequel.connect(connection_string)                                              #
DB.loggers << Logger.new($stdout) unless DB.loggers.size > 0                          #
def view(template); erb template.to_sym; end                                          #
use Rack::Session::Cookie, key: 'rack.session', path: '/', secret: 'secret'           #
before { puts; puts "--------------- NEW REQUEST ---------------"; puts }             #
after { puts; }                                                                       #
#######################################################################################
account_sid = "ACe4e86b17fd74ceb60d19767deea9e698"
auth_token = "67c89d5b64f0edc75097f57499fdd8c8"
client = Twilio::REST::Client.new(account_sid, auth_token)
client.messages.create(
    from: "+16467985251",
    to: "16306740319",
    body: "Hey KIEI 451!"
    )


items_table = DB.from(:items)
customer_input_table = DB.from(:customer_input)
users_table = DB.from(:users)

get "/" do

    view "home"
end



get "/items" do
    puts "params: #{params}"

    puts items_table.all
    @items = items_table.all
    view "items"
end

get "/items/:id" do
    @item = items_table.where(id: params[:id]).first
    view "item"

    # pp items_table.where(id: params[:id]).to_a[0]
    # @item = items_table.where(id: params[:id]).to_a[0]
    # view "item"
end

get "/items/:id/customer_input/new" do
   # puts "params: #{params}"
   @item = items_table.where(id: params[:id]).first

    
    view "customer_input"
end

get "/items/:id/customer_input/create" do
    puts params
    @item = items_table.where(id: params[:id]).to_a[0]
    customer_input_table.insert(item_id: params["id"],
                                customer_name: params["customer_name"],
                                customer_phone_number: params["customer_phone_number"],
                                customer_e_mail: params["customer_e_mail"],
                                desired_pick_up_times: params["desired_pick_up_times"])

    view "create_customer_input"
end

get "/purchases" do
    # @item = items_table.where(id: params[:id]).to_a[0]
    # @customer= customer_input_table.where(item_id: @item[:id])
    @customer= customer_input_table.all
    @items_table = items_table
    
    view "/purchases"
end

get "/users/new" do
    view "new_user"
end

post "/users/create" do
    puts params
    hashed_password = BCrypt::Password.create(params["password"])
    users_table.insert(name: params["name"], email: params["email"], password: hashed_password)
    view "create_user"
end

get "/logins/new" do
    view "new_login"
end

post "/logins/create" do
    user = users_table.where(email: params["email"]).to_a[0]
    puts BCrypt::Password::new(user[:password])
    if user && BCrypt::Password::new(user[:password]) == params["password"]
        session["user_id"] = user[:id]
        @current_user = user
        view "create_login"
    else
        view "create_login_failed"
    end
end

get "/logout" do
    session["user_id"] = nil
    @current_user = nil
    view "logout"
end