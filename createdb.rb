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
  String :description, text: true
  String :price
  
end

  
 

DB.create_table! :customer_input do
  primary_key :id
  foreign_key :item_id
  String :customer_name
  String :customer_phone_number
  String :customer_e_mail
  String :desired_pick_up_times, text: true
end
# Insert initial (seed) data
items_table = DB.from(:items)


items_table.insert(item_name: "child gates", 
                    description: "3 sets of gates to hook up in your home to protect your young kids from stairs and keep pets on one level.  Child proof to open and close.",
                    item_type: "child gates",
                    condition: "like new",
                    price: "$30",
                    status_available: 1)
                    

                    items_table.insert(item_name: "Child Crib and bed", 
                    description: "3 in 1 crib, toddler bed, bed with gates.  This will accomodate your child's sleeping needs from infant to adolescent all in this convertible set.",
                    item_type: "furniture",
                    condition: "Used but stil good condition",
                    price: "$85",
                    status_available: 1)

                    items_table.insert(item_name: "kids bike", 
                    description: "Buzz lightyear bike with removable training wheels",
                    item_type: "kids bike",
                    condition: "Used",
                    price: "$10",
                    status_available: 1)

                     items_table.insert(item_name: "kids balance bike", 
                    description: "Balance bike, no pedals.  great for kids helping them to learn to ride.  Push off the ground like a skateboard.",
                    item_type: "kids bike",
                    condition: "Used",
                    price: "$10",
                    status_available: 1)

                     items_table.insert(item_name: "Rogue Women's Barbell", 
                    description: "35 lb olympic rogue barbell",
                    item_type: "exercise equipment",
                    condition: "like new",
                    price: "$150",
                    status_available: 1)

                     items_table.insert(item_name: "kids bike", 
                    description: "Buzz lightyear bike with removable training wheels",
                    item_type: "kids bike",
                    condition: "Used",
                    price: "$10",
                    status_available: 1)

                     items_table.insert(item_name: "Child Crib and bed", 
                    description: "3 in 1 crib, toddler bed, bed with gates.  This will accomodate your child's sleeping needs from infant to adolescent all in this convertible set.",
                    item_type: "furniture",
                    condition: "Used but stil good condition",
                    price: "$85",
                    status_available: 1)

                     items_table.insert(item_name: "Rogue Climbing Rope", 
                    description: "Rogue 15 foot climbing rope.  Great for gymnastics and crossfit.",
                    item_type: "exercise equipment",
                    condition: "Used but stil good condition",
                    price: "$50",
                    status_available: 1)

                     items_table.insert(item_name: "Rogue gymnastics hanging rings", 
                    description: "Rogue wooden gymnastics rings.  Great for gymnastics and crossfit.  Use them for dips, muscle ups, push-ups, etc.",
                    item_type: "exercise equipment",
                    condition: "Used but stil good condition",
                    price: "$50",
                    status_available: 1)

                     items_table.insert(item_name: "Child dresser", 
                    description: "5 drawer dark wood dresser, still in great condition.  Perfect for any kid.",
                    item_type: "furniture",
                    condition: "Used but stil good condition",
                    price: "$50",
                    status_available: 1)
                    
                     items_table.insert(item_name: "Body Solid GHD machine",
                    description: "The best machine on the market for core, ham, butt.  Get chiseled.",
                    item_type: "exercise equipment",
                    condition: "Used but stil good condition",
                    price: "$250",
                    status_available: 1)

                     items_table.insert(item_name: "Original WWF wrestling buddies", 
                    description: "Macho King Randy Savage in all his glory.  Collectors item.  Just like you remember from your youth.",
                    item_type: "toy",
                    condition: "Used but stil great condition",
                    price: "$15",
                    status_available: 1)

                     items_table.insert(item_name: "Original WWF wrestling buddies", 
                    description: "The Ultimate Warrior in all his glory.  Collectors item.  Just like you remember from your youth.",
                    item_type: "toy",
                    condition: "Used but stil great condition",
                    price: "$15",
                    status_available: 1)

                     items_table.insert(item_name: "Original WWF wrestling buddies", 
                    description: "Hulk Hogan in all his glory.  Collectors item.  Just like you remember from your youth.",
                    item_type: "toy",
                    condition: "Used but stil great condition",
                    price: "$15",
                    status_available: 1)

                     items_table.insert(item_name: "Original WWF wrestling buddies", 
                    description: "The Million Dollar Man Ted Dibiase in all his glory.  Everybody's got a price.  Collectors item.  Just like you remember from your youth.",
                    item_type: "toy",
                    condition: "Used but stil great condition",
                    price: "$15",
                    status_available: 1)

                     items_table.insert(item_name: "Thomas the Train", 
                    description: "Enormous collection of Thomas trains, island, toys.  You can come see before purchasing.",
                    item_type: "toy",
                    condition: "Used",
                    price: "$100",
                    status_available: 1)
