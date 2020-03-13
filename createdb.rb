# Set up for the application and database. DO NOT CHANGE. #############################
require "sequel"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB = Sequel.connect(connection_string)                                                #
#######################################################################################

# Database schema - this should reflect your domain model
DB.create_table! :items do
  primary_key :id
  Boolean :status_available
  String :item_type 
  String :item_name 
  String :condition
  foreign_key :places_id
  String :location 
  String :description, text: true
  String :price
  
end

DB.create_table! :places do
primary_key :id
String :location

end

  
 

DB.create_table! :customer_input do
  primary_key :id
  foreign_key :items_id
  foreign_key :customer_name
  foreign_key :customer_phone_number
  foregin_key :customer_e_mail
  String :desired_pick_up_times, text: true
end

DB.create_table! :users do
  primary_key :id
  String :customer_name
  String :customer_email
  String :customer_phone_number
  String :password
end
# Insert initial (seed) data
places_table = DB.from(:places)

places_table.insert(location: "228 N. Geneva Ave.")

places_table.insert(location: "322 S. York Ave.")

places_table.insert(location: "115 N. Geneva Ave.")


items_table = DB.from(:items)

items_table.insert(item_name: "child gates", 
                    description: "3 sets of gates to hook up in your home to protect your young kids from stairs and keep pets on one level.  Child proof to open and close.",
                    item_type: "child gates",
                    condition: "like new",
                    location: "228 N. Geneva Ave.",
                    price: "$30",
                    status_available: 1,
                    places_id: 1)
                    

                    items_table.insert(item_name: "Child Crib and bed", 
                    description: "3 in 1 crib, toddler bed, bed with gates.  This will accomodate your child's sleeping needs from infant to adolescent all in this convertible set.",
                    item_type: "furniture",
                    condition: "Used but stil good condition",
                    location: "228 N. Geneva Ave.",
                    price: "$85",
                    status_available: 1,
                    places_id: 1)

                    items_table.insert(item_name: "kids bike", 
                    description: "Buzz lightyear bike with removable training wheels",
                    item_type: "kids bike",
                    condition: "Used",
                    location: "228 N. Geneva Ave.",
                    price: "$10",
                    status_available: 1,
                    places_id: 1)

                     items_table.insert(item_name: "kids balance bike", 
                    description: "Balance bike, no pedals.  great for kids helping them to learn to ride.  Push off the ground like a skateboard.",
                    item_type: "kids bike",
                    condition: "Used",
                    location: "228 N. Geneva Ave.",
                    price: "$10",
                    status_available: 1,
                    places_id: 1)

                     items_table.insert(item_name: "Rogue Women's Barbell", 
                    description: "35 lb olympic rogue barbell",
                    item_type: "exercise equipment",
                    condition: "like new",
                    location: "322 S. York Ave.",
                    price: "$150",
                    status_available: 1,
                    places_id: 2)

                     items_table.insert(item_name: "kids bike", 
                    description: "Buzz lightyear bike with removable training wheels",
                    item_type: "kids bike",
                    condition: "Used",
                    location: "228 N. Geneva Ave.",
                    price: "$10",
                    status_available: 1,
                    places_id: 1)

                     items_table.insert(item_name: "Child Crib and bed", 
                    description: "3 in 1 crib, toddler bed, bed with gates.  This will accomodate your child's sleeping needs from infant to adolescent all in this convertible set.",
                    item_type: "furniture",
                    condition: "Used but stil good condition",
                    location: "115 N. Geneva Ave.",
                    price: "$85",
                    status_available: 1,
                    places_id: 3)

                     items_table.insert(item_name: "Rogue Climbing Rope", 
                    description: "Rogue 15 foot climbing rope.  Great for gymnastics and crossfit.",
                    item_type: "exercise equipment",
                    condition: "Used but stil good condition",
                    location: "115 N. Geneva Ave.",
                    price: "$50",
                    status_available: 1,
                    places_id: 3)

                     items_table.insert(item_name: "Rogue gymnastics hanging rings", 
                    description: "Rogue wooden gymnastics rings.  Great for gymnastics and crossfit.  Use them for dips, muscle ups, push-ups, etc.",
                    item_type: "exercise equipment",
                    condition: "Used but stil good condition",
                    location: "322 S. York Ave.",
                    price: "$50",
                    status_available: 1,
                    places_id: 2)

                     items_table.insert(item_name: "Child dresser", 
                    description: "5 drawer dark wood dresser, still in great condition.  Perfect for any kid.",
                    item_type: "furniture",
                    condition: "Used but stil good condition",
                    location: "322 S. York Ave.",
                    price: "$50",
                    status_available: 1,
                    places_id: 2)
                    
                     items_table.insert(item_name: "Body Solid GHD machine",
                    description: "The best machine on the market for core, ham, butt.  Get chiseled.",
                    item_type: "exercise equipment",
                    condition: "Used but stil good condition",
                    location: "322 S. York Ave.",
                    price: "$250",
                    status_available: 1,
                    places_id: 2)

                     items_table.insert(item_name: "Original WWF wrestling buddies", 
                    description: "Macho King Randy Savage in all his glory.  Collectors item.  Just like you remember from your youth.",
                    item_type: "toy",
                    condition: "Used but stil great condition",
                    location: "115 N. Geneva Ave.",
                    price: "$15",
                    status_available: 1,
                    places_id: 3)

                     items_table.insert(item_name: "Original WWF wrestling buddies", 
                    description: "The Ultimate Warrior in all his glory.  Collectors item.  Just like you remember from your youth.",
                    item_type: "toy",
                    condition: "Used but stil great condition",
                    location: "115 N. Geneva Ave.",
                    price: "$15",
                    status_available: 1,
                    places_id: 3)
                    

                    items_table.insert(item_name: "Original WWF wrestling buddies", 
                    description: "Hulk Hogan in all his glory.  Collectors item.  Just like you remember from your youth.",
                    item_type: "toy",
                    condition: "Used but stil great condition",
                    location: "115 N. Geneva Ave.",
                    price: "$15",
                    status_available: 1,
                    places_id: 3)

                     items_table.insert(item_name: "Original WWF wrestling buddies", 
                    description: "The Million Dollar Man Ted Dibiase in all his glory.  Everybody's got a price.  Collectors item.  Just like you remember from your youth.",
                    item_type: "toy",
                    condition: "Used but stil great condition",
                    location: "115 N. Geneva Ave.",
                    price: "$15",
                    status_available: 1,
                    places_id: 3)

                     items_table.insert(item_name: "Thomas the Train", 
                    description: "Enormous collection of Thomas trains, island, toys.  You can come see before purchasing.",
                    item_type: "toy",
                    condition: "Used",
                    location: "228 N. Geneva Ave.",
                    price: "$100",
                    status_available: 1,
                    places_id: 1)

