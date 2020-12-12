# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Trade.Repo.insert!(%Trade.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


Trade.Repo.insert!(%Trade.PrimitiveShop.House{name: "45 Drivewood Circle" , address: "Norwood MA, 02062" , number_shares: 7000 , ordered_shares: 0})
Trade.Repo.insert!(%Trade.PrimitiveShop.House{name: "18 Jefferson Lane" , address: "Woburn MA, 01801" , number_shares: 2000 , ordered_shares: 0})
Trade.Repo.insert!(%Trade.PrimitiveShop.House{name: "187 Woodrow Street" , address: "Salem MA, 01915" , number_shares: 1000 , ordered_shares: 0})
Trade.Repo.insert!(%Trade.PrimitiveShop.House{name: "28 Gifford Street" , address: "Bedford NH, 03103" , number_shares: 3000 , ordered_shares: 0})
Trade.Repo.insert!(%Trade.PrimitiveShop.House{name: "12 United Road" , address: "South Hampton NH, 03827" , number_shares: 5000 , ordered_shares: 0})



Trade.UserAccount.createuser(%{	"email" => "joe@gmail.com","password" => "123","user" => %{"fname" => "Joe","lname" => "Smith"}})
Trade.UserAccount.createuser(%{	"email" => "Rolf@gmail.com","password" => "456","user" => %{"fname" => "Rolf","lname" => "Anderson"}})

###### Primitive ORDERS ################

h = Trade.Repo.get_by!(Trade.PrimitiveShop.House,name: "45 Drivewood Circle")
user = Trade.Repo.get_by!(Trade.UserAccount.Credential , email: "joe@gmail.com")
Trade.PrimitiveShop.create_primitive_order(%{"number_share" => 500 , "type_order" => "Buy" , "house_id" => h.id } , user)
Trade.PrimitiveShop.update_house_info_after_order(%{"number_share" => 500 , "type_order" => "Buy" , "house_id" => h.id })


h = Trade.Repo.get_by!(Trade.PrimitiveShop.House,name: "12 United Road")
user = Trade.Repo.get_by!(Trade.UserAccount.Credential , email: "Rolf@gmail.com")
Trade.PrimitiveShop.create_primitive_order(%{"number_share" => 1000 , "type_order" => "Buy" , "house_id" => h.id } , user)
Trade.PrimitiveShop.update_house_info_after_order(%{"number_share" => 1000 , "type_order" => "Buy" , "house_id" => h.id })


###### Secoundary ORDERS ################

h = Trade.Repo.get_by!(Trade.PrimitiveShop.House,name: "45 Drivewood Circle")
user = Trade.Repo.get_by!(Trade.UserAccount.Credential , email: "joe@gmail.com")
Trade.SecondaryShop.create_secondary_order(%{"number_share" => 850 , "type_order" => "Buy" , "house_id" => h.id } , user)

h = Trade.Repo.get_by!(Trade.PrimitiveShop.House,name: "18 Jefferson Lane")
user = Trade.Repo.get_by!(Trade.UserAccount.Credential , email: "Rolf@gmail.com")
Trade.SecondaryShop.create_secondary_order(%{"number_share" => 1500 , "type_order" => "Sell" , "house_id" => h.id } , user)


h = Trade.Repo.get_by!(Trade.PrimitiveShop.House,name: "12 United Road")
user = Trade.Repo.get_by!(Trade.UserAccount.Credential , email: "joe@gmail.com")
Trade.SecondaryShop.create_secondary_order(%{"number_share" => 700 , "type_order" => "Sell" , "house_id" => h.id } , user)
