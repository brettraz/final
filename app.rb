# Set up for the application and database. DO NOT CHANGE. #############################
require "sinatra"                                                                     #
require "sinatra/reloader" if development?                                            #
require "sequel"                                                                      #
require "logger"                                                                      #
require "twilio-ruby"  
require "bcrypt"                                                               #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB ||= Sequel.connect(connection_string)                                              #
DB.loggers << Logger.new($stdout) unless DB.loggers.size > 0                          #
def view(template); erb template.to_sym; end                                          #
use Rack::Session::Cookie, key: 'rack.session', path: '/', secret: 'secret'           #
before { puts; puts "--------------- NEW REQUEST ---------------"; puts }             #
after { puts; }                                                                       #
#######################################################################################
# account_sid = "ACe4e86b17fd74ceb60d19767deea9e698"
# auth_token = "67c89d5b64f0edc75097f57499fdd8c8"
# client = Twilio::REST::Client.new(account_sid, auth_token)
# client.messages.create(
#     from: "+16467985251",
#     to: "16306740319",
#     body: "Thank you for your purchase"
#     )


items_table = DB.from(:items)
customer_input_table = DB.from(:customer_input)
users_table = DB.from(:users)
places_table= DB.from(:places)

before do
    @current_user = users_table.where(id: session["user_id"]).to_a[0]
end

get "/" do

    view "home"
end



get "/items" do
    puts "params: #{params}"

    puts items_table.all
    @items = items_table.all.to_a
    view "items"
end 

get "/places" do
    puts "params: #{params}"

    puts places_table.all
    @places = places_table.all.to_a
    @items = items_table.all.to_a
    view "places"
end

get "/items/:id" do
    @item = items_table.where(id: params[:id]).first
    @users_table = users_table
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
    customer_input_table.insert(items_id: params["id"],
                                customer_name: params["customer_name"],
                                customer_phone_number: params["customer_phone_number"],
                                customer_e_mail: params["customer_e_mail"],
                                desired_pick_up_times: params["desired_pick_up_times"])

    view "create_purchases"
    account_sid = "thanks"
    auth_token = "ben"
    client = Twilio::REST::Client.new(account_sid, auth_token)
    client.messages.create(
    from: "+16467985251",
    to: @current_user[:customer_phone_number],
    body: "Thank you for your purchase"
    )
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
    users_table.insert(customer_name: params["customer_name"], customer_email: params["customer_e_mail"], password: hashed_password)
    view "create_user"
end

get "/logins/new" do
    view "new_login"
end

post "/logins/create" do
    user = users_table.where(customer_email: params["customer_e_mail"]).to_a[0]
    # puts BCrypt::Password::new(user[:password])
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