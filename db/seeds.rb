require "open-uri"
require 'openfoodfacts'
require 'nokogiri'
require 'faker'

puts "Destruction : start"
puts "3"
puts "2"
puts "1"
puts "Boom!"


##########################DESTRUCTION-START######################
Event.destroy_all

puts "Event destroyed !"


TimeTable.destroy_all


puts "TableTime destroyed!"

Review.destroy_all

puts "Reviews destroyed !"

Stock.destroy_all

puts "Stock destroyed !"

Shop.destroy_all

puts "Shops destroyed!"

ProductTag.destroy_all

Tag.destroy_all


puts "tag and products_tag destroyed!"

Product.destroy_all

puts "Products destroyed!"


puts "Users creation"

User.destroy_all

puts "Users destroyed!"




# # #---------------------------DESTRUCTION-DONE-------------------




# # # #############################USER-CREATION########################

puts "User construction start !"

user = {email: "chopshop@chopshop.me", password:"charlotte"}
u = User.create!(user)

cat = {label: "null"}
c = Category.create!(cat)

puts "User created ok"

# -----------------------------USER-DONE---------------------------


# ------------------------- OPEN FACTS FOOD------------------------
# ----------------------Product creation start ---------------------

puts "Product creation start"

product_names = ["Chocolat", "Biscuit", "Confiture", "Conserve", "Poisson", "Marron", "Châtaigne", "Beurre", "Pain"]

product_names.each do |product_name|
  products = Openfoodfacts::Product.search(product_name, locale: 'fr', page_size: 1)

  products.each do |product|
    my_product = Openfoodfacts::Product.get(product.code, locale: 'fr')
    my_new_product = Product.create!({
      name: my_product.product_name,
      description: my_product.ingredients_text_fr,
      product_sku: my_product.code,
      brand: my_product.brands,
      category_id: c.id
    })
    puts "#{my_new_product.name} has been created"
    file = URI.open(my_product.image_front_url)
    puts "Image loaded"

    my_new_product.photo.attach(io: file, filename: "#{product.code}.jpg", content_type: 'image/jpg')
    puts "Product save !"

  end
end


#---------------------------PRODUCT-END-------------------------------




########################"SHOPS-CREATION-START"########################

#---------------------- SHOP ADDRESS CHARTRONS -----------------------

puts "Chartrons Shop construction start !"

addresses = ["3 Cours Balguerie Stuttenberg, 33300 Bordeaux", "8 Cours Balguerie Stuttenberg, 33300 Bordeaux",
"20 Cours Balguerie Stuttenberg, 33300 Bordeaux", "31 Cours Balguerie Stuttenberg, 33300 Bordeaux",
"36 Cours Balguerie Stuttenberg, 33300 Bordeaux", "46 Cours Balguerie Stuttenberg, 33300 Bordeaux",
"53 Cours Balguerie Stuttenberg, 33300 Bordeaux", "67 Cours Balguerie Stuttenberg, 33300 Bordeaux",
"87 Cours Balguerie Stuttenberg, 33300 Bordeaux", "101 Cours Balguerie Stuttenberg, 33300 Bordeaux",
"110 Cours Balguerie Stuttenberg, 33300 Bordeaux", "131 Cours Balguerie Stuttenberg, 33300 Bordeaux",
"154 Cours Balguerie Stuttenberg, 33300 Bordeaux", "167 Cours Balguerie Stuttenberg, 33300 Bordeaux",
"230 Cours Balguerie Stuttenberg, 33300 Bordeaux", "270 Cours Balguerie Stuttenberg, 33300 Bordeaux",
"3 Cours du Médoc, 33300 Bordeaux", "8 Cours du Médoc, 33300 Bordeaux",
"20 Cours du Médoc, 33300 Bordeaux", "31 Cours du Médoc, 33300 Bordeaux",
"36 Cours du Médoc, 33300 Bordeaux", "46 Cours du Médoc, 33300 Bordeaux",
"53 Cours du Médoc, 33300 Bordeaux", "67 Cours du Médoc, 33300 Bordeaux",
"87 Cours du Médoc, 33300 Bordeaux", "101 Cours du Médoc, 33300 Bordeaux",
"110 Cours du Médoc, 33300 Bordeaux", "131 Cours du Médoc, 33300 Bordeaux",
"154 Cours du Médoc, 33300 Bordeaux", "167 Cours du Médoc, 33300 Bordeaux",
"34 Cours Portal, 33000 Bordeaux", "34 Cours de Verdun, 33000 Bordeaux",
"50 Cours de Verdun, 33000 Bordeaux", "34 Cours de la Marne, 33300 Bordeaux",
"12 Cours de Verdun, 33000 Bordeaux", "34 Rue Lagrange, 33000 Bordeaux",
"11 Rue Lagrange, 33000 Bordeaux", "67 Rue Lagrange, 33000 Bordeaux",
"22 Rue Lagrange, 33000 Bordeaux", "100 Rue Lagrange, 33000 Bordeaux",
"3 Rue Lagrange, 33000 Bordeaux", "66 Rue Lagrange, 33000 Bordeaux",
"37 Rue Lombard, 33300 Bordeaux", "12 Rue Lombard, 33300 Bordeaux",
"22 Rue Dupaty, 33300 Bordeaux", "109 Rue Dupaty, 33300 Bordeaux",
"78 Rue Dupaty, 33300 Bordeaux", "122 Rue Dupaty, 33300 Bordeaux",
"13 Cours Georges Clemenceau, 33000 Bordeaux", "28 Cours Georges Clemenceau, 33000 Bordeaux",
"7 Rue Etienne Huyard, 33300 Bordeaux", "12 Rue Lucien Duffau, 33300 Bordeaux",
"20 Avenue Emile Counord, 33300 Bordeaux", "34 Avenue Emile Counord, 33300 Bordeaux",
"53 Avenue Emile Counord, 33300 Bordeaux", "71 Avenue Emile Counord, 33300 Bordeaux",
"88 Avenue Emile Counord, 33300 Bordeaux", "104 Avenue Emile Counord, 33300 Bordeaux",
"128 Avenue Emile Counord, 33300 Bordeaux", "145 Avenue Emile Counord, 33300 Bordeaux",
"163 Avenue Emile Counord, 33300 Bordeaux", "176 Avenue Emile Counord, 33300 Bordeaux",
"203 Avenue Emile Counord, 33300 Bordeaux", "229 Avenue Emile Counord, 33300 Bordeaux"]

addresses.each do |address|
  Faker::Config.locale = 'fr'
  new_shop = {
     name: Faker::Company.name,
     user_id: u.id ,
     address: address,
     category: Faker::Commerce.department(max: 1)
  }
Shop.create!(new_shop)
end

puts "shops in Chartrons created"


#------------------------------------------------------------------

#----------------------SHOP ADDRESS TALENCE-----------------------

puts "Talence Shop construction start !"

talence_addresses = ["310 Cours de la Libération, 33400 Talence", "540 Cours de la Libération, 33400 Talence",
"350 Cours de la Libération, 33400 Talence", "387 Cours de la Libération, 33400 Talence",
"429 Cours de la Libération, 33400 Talence", "456 Cours de la Libération, 33400 Talence",
"499 Cours de la Libération, 33400 Talence", "510 Cours de la Libération, 33400 Talence",
"540 Cours de la Libération, 33400 Talence",
"156 Rue Lamartine, 33400 Talence", "110 Rue Lamartine, 33400 Talence",
"43 Rue Lamartine, 33400 Talence", "11 Avenue Georges Lasserre, 33400 Talence",
"100 Avenue Roul, 33400 Talence", "22 Avenue Roul, 33400 Talence",
"2 Rue de Tremeuge, 33400 Talence", "16 Rue de Tremeuge, 33400 Talence",
"48 Rue de Tremeuge, 33400 Talence", "23 Rue Frédéric Sévène, 33400 Talence",
"76 Rue Frédéric Sévène, 33400 Talence", "108 Rue Frédéric Sévène, 33400 Talence",
"160 Rue Frédéric Sévène, 33400 Talence", "129 Rue Frédéric Sévène, 33400 Talence",
"112 Rue Camille Pelletan, 33400 Talence", "87 Rue Camille Pelletan, 33400 Talence",
"45 Rue Camille Pelletan, 33400 Talence", "23 Rue Camille Pelletan, 33400 Talence",
"2 Rue Camille Pelletan, 33400 Talence", "67 Rue Camille Pelletan, 33400 Talence",
"12 Rue Roustaing, 33400 Talence", "45 Rue Roustaing, 33400 Talence",
"87 Rue Roustaing, 33400 Talence", "120 Rue Roustaing, 33400 Talence",
 "3 Cours Gambetta, 33400 Talence", "45 Cours Gambetta, 33400 Talence",
"87 Cours Gambetta, 33400 Talence", "108 Cours Gambetta, 33400 Talence",
"126 Cours Gambetta, 33400 Talence", "151 Cours Gambetta, 33400 Talence",
"187 Cours Gambetta, 33400 Talence", "204 Cours Gambetta, 33400 Talence",
"232 Cours Gambetta, 33400 Talence", "249 Cours Gambetta, 33400 Talence" ]

talence_addresses.each do |address|
  Faker::Config.locale = 'fr'
  new_shop = {
     name: Faker::Company.name,
     user_id: u.id ,
     address: address,
     category: Faker::Commerce.department(max: 1)
  }
Shop.create!(new_shop)
end

puts "shops in Talence created"

#---------------------------- SHOPS-CREATION-DONE -------------------------

############################## STOCKS-CREATION-START ############################

puts "stock in creation"

Product.all.ids.each do |id|
  Faker::Config.locale = 'fr'
  new_stock = {
    product_id: id,
    shop_id: Shop.all.ids.sample,
    quantity: rand(1..20),
    price: Faker::Commerce.price(range: 3..7),
  }

  Stock.create!(new_stock)
end

#-------------------- STOCKS-CREATION-DONE -----------------

###################### TAGS-CREATION-START ####################
puts "Creation tags"


my_actual_products = Product.all
my_actual_products.each do |product|
  info_product = Openfoodfacts::Product.get(product.product_sku, locale: 'fr')

  info_product.categories.split(',').each do |info|
    tag = Tag.create!(label: info)

    ProductTag.create!(tag_id: tag.id, product_id: product.id)
    puts "New tag creation ok"
  end
end

#---------------------- TAGS-CREATION-DONE -----------------



# ######################TIME-TABLE-CREATION#################

puts "Time table creation start"

my_shops = Shop.all
my_shops.each do |shop|
  number_of_day = rand(3..5)
  start_day = rand(1..5)
  open_rand = rand(8..12)
  close_rand = rand(13..19)
  star_with = start_day
  number_of_day.times do
    time_table = {                #day_of_week : 0 : Dimanche, 1 : Lundi ..... Samedi : 6 #
        opened_at: open_rand ,
        closed_at: close_rand ,
        day_of_week: star_with,  #day_of_week : 1 => lundi
        shop_id: shop.id
    }
    if star_with < 6
      star_with += 1
    else
      star_with = 0
    end
    TimeTable.create!(time_table)
  end
end

puts "Time table creation done !"

#---------------------------TIME-TABLE-END---------------------

##########################EVENTS-CREATION######################

puts "Start creation Event !"

event1start_date = Date.new(2020,3,21)
event1end_date = Date.new(2020,3,21)

event1 = {
    name: "Bourse philatélique" ,
    category: "Marché" ,
    description: "Le groupe philatélique bordelais organise ce samedi sa bourse aux timbres, cartes postales, fèves, cartes de téléphone, capsules de champagne, vieux papiers…" ,
    address: "Place de l'Europe, 33300 Bordeaux" ,
    start_date: event1start_date,
    end_date: event1end_date,
    time_opening: 14 ,
    time_closing: 16 ,
}


event2start_date = Date.new(2020,4,17)
event2end_date = Date.new(2020,10,31)

event2 = {
    name: "Les Bassins de Lumières" ,
    category: "Exposition" ,
    description: "Les Bassins de Lumières présenteront des expositions numériques immersives monumentales dédiées aux grands artistes de l’Histoire de l’art et à la création contemporaine." ,
    address: "Base Sous Marine - Boulevard Alfred Daney, 33100 Bordeaux" ,
    start_date: event2start_date,
    end_date: event2end_date,
    time_opening: 9 ,
    time_closing: 17 ,
}

event3start_date = Date.new(2020,6,18)
event3end_date =  Date.new(2020,6,21)

event3 = {
    name: "Bordeaux fête le vin" ,
    category: "Fête" ,
    description: "En 2020, Bordeaux Fête le Vin mêlera de nouveau la présence de quelques très grands voiliers patrimoniaux à la dégustation des vins de Bordeaux et de Nouvelle Aquitaine. Rendez-vous du jeudi 18 au dimanche 21 juin 2020." ,
    address: "Place de la Bourse, 33000 Bordeaux" ,
    start_date: event3start_date,
    end_date: event3end_date,
    time_opening: 11 ,
    time_closing: 23 ,
}

event4start_date = Date.new(2020,3,6)
event4end_date = Date.new(2020,3,6)

event4 = {
    name: "Candlelight Bordeaux" ,
    category: "Musique" ,
    description: "Après leur succès à Madrid, Londres, Bruxelles et plus récemment à Paris, les concerts de musique éclairés à la bougie, Candlelight, débarquent à Bordeaux cette année." ,
    address: "Place Saint Martial, 33300 Bordeaux" ,
    start_date: event4start_date,
    end_date: event4end_date,
    time_opening: 18,
    time_closing: 21,
}

event5start_date = Date.new(2020,3,6)
event5end_date = Date.new(2020,3,6)

event5 = {
    name: "Démo Day",
    category: "Education" ,
    description: "Le Démo Day le plus atttendu de l'année se déroule dans les locaux du Wagon Bordeaux. De nombreux projets y seront présentés tels que RandomLife, PronostikR, WikiRace, Spiice, OChild mais aussi ChopShop" ,
    address: "107 Cours Balguerie Stuttenberg, 33300 Bordeaux" ,
    start_date: event4start_date,
    end_date: event4end_date,
    time_opening: 18,
    time_closing: 23,
}

ev1 = Event.create!(event1)
ev2 = Event.create!(event2)
ev3 = Event.create!(event3)
ev4 = Event.create!(event4)
ev5 = Event.create!(event5)

puts "Event cretion done"

puts "Linking images to events start"


bourse_philaléique_img = URI.open('https://i.ebayimg.com/images/g/EGAAAOSwDN1UP2Nv/s-l1600.jpg')
ev1.photo.attach(io: bourse_philaléique_img, filename: 'bourse_philaléique_img.jpg'   , content_type:'image/jpg')
puts "bourse_philaléique_img loaded OK"

bassins_lumieres_img = URI.open('https://www.bassins-lumieres.com/sites/bdl/files/styles/1600x500/public/bdl_klimt_0.jpg')
ev2.photo.attach(io: bassins_lumieres_img, filename: 'bassins_lumieres_img.jpg' , content_type: 'image/jpg')
puts "bassins_lumieres_img loaded OK"

fete_vin_img = URI.open('https://www.pierreoteiza.com/images/products/443x332/147047.png')
ev3.photo.attach(io: fete_vin_img, filename: 'fete_vin_img.png' ,content_type: 'image/png')
puts "fete_vin_img loaded OK"

candlelight_img = URI.open('https://www.bordeauxtendances.fr/wp-content/uploads/2019/12/candle-1024x410.jpg')
ev4.photo.attach(io: candlelight_img, filename: 'candlelight_img.jpg' ,content_type: 'image/jpg')
puts "marche_img loaded OK"

demoday_img = URI.open('https://www.frenchtechbordeaux.com/wp-content/uploads/2020/02/Demo-Day-FT.png')
ev5.photo.attach(io: demoday_img, filename: 'demoday_img.png' ,content_type: 'image/png')
puts "marche_img loaded OK"

puts "All images are linked"

#------------------------EVENTS-CREATION-DONE-------------------


puts "SEED DONE :D"

################################################################################################################################################
################################################################################################################################################
################################################################################################################################################
################################################################################################################################################

puts "CREATION SEED FOR DEMODAY START"

#------------------------Creation-Products-For-DemoDay--------------------------
################################################################################
##########################                      ################################
##########################    CHOCOLAT LINDT    #############################
##########################                      ################################
################################################################################
puts "Creation shop start"
shop1 = {
   name: "Chez Willy Wonka",
   user_id: u.id,
   address: "43 Rue Surson, 33300 Bordeaux",
   category: "Confiseur"
}
s1 = Shop.create!(shop1)
puts "Shop create"

puts "Creation shop start"
shopc2 = {
   name: "Outlet Lindt",
   user_id: u.id,
   address: "66 Quai de Bacalan, 33300 Bordeaux",
   category: "Chocolatier"
}
sc2 = Shop.create!(shopc2)
puts "Shop create"

puts "Creation shop start"
shopc3 = {
   name: "Chocolate lover",
   user_id: u.id,
   address: "132 Rue Binaud, 33300 Bordeaux",
   category: "Chocolatier"
}
sc3 = Shop.create!(shopc3)
puts "Shop create"

puts "Lindt chocolate in creation"
product1 = {
     name: "Tablette de chocolat Lindt creation",
     brand: "Lindt",
     description: "Tablette de chocolat 150g creme brulee",
     category_id: 1,
     product_sku: 3046920042567

}
p1 = Product.create!(product1)
puts "Lindt Chocolate create"


puts "Stock for Lindt in creation"
stock1 = {
     product_id: p1.id ,
     shop_id: s1.id ,
     quantity: 10 ,
     price: 5,
}

stockc2 = {
     product_id: p1.id ,
     shop_id: sc2.id ,
     quantity: 10 ,
     price: 6,
}

stockc3 = {
     product_id: p1.id ,
     shop_id: sc3.id ,
     quantity: 10 ,
     price: 4,
}

puts "Loading image...."

file1 = URI.open('https://www.lindt.fr/shop/media/catalog/product/cache/2/thumbnail/405x400/9df78eab33525d08d6e5fb8d27136e95/c/r/creation-lait-creme-brulee_1.png')
p1.photo.attach(io: file1, filename: 'chocolat_lindt.png', content_type: 'image/png')

puts "Image1 loaded OK"

st1 = Stock.create!(stock1)
stc2 = Stock.create!(stockc2)
stc3 = Stock.create!(stockc3)

puts "Stock created"

puts "Time Table in creation"

time_table = [{       #day_of_weed : 0 : Dimanche, 1 : Lundi ..... Samedi : 6 #
    opened_at: 10 ,
    closed_at: 19 ,
    day_of_week: 1,  #day_of_week : 1 => lundi
    shop_id: s1.id
},{
    opened_at: 9 ,
    closed_at: 18,
    day_of_week: 2,  #day_of_week : 2 => mardi
    shop_id: s1.id
},{
    opened_at: 10 ,
    closed_at: 19 ,
    day_of_week: 3 ,  #day_of_week : 3 => mercredi
    shop_id: s1.id
},{
    opened_at: 9 ,
    closed_at: 18 ,
    day_of_week: 4 ,  #day_of_week : 4 => jeudi
    shop_id: s1.id
},{
    opened_at: 8 ,
    closed_at: 19 ,
    day_of_week: 5 ,  #day_of_week : 5 => vendredi
    shop_id: s1.id
},{
    opened_at: 8 ,
    closed_at: 19 ,
    day_of_week: 6 ,  #day_of_week : 6 => samedi
    shop_id: s1.id
}]

time_tablec2 = [{       #day_of_weed : 0 : Dimanche, 1 : Lundi ..... Samedi : 6 #
    opened_at: 10 ,
    closed_at: 19 ,
    day_of_week: 1,  #day_of_week : 1 => lundi
    shop_id: sc2.id
},{
    opened_at: 9 ,
    closed_at: 18,
    day_of_week: 2,  #day_of_week : 2 => mardi
    shop_id: sc2.id
},{
    opened_at: 10 ,
    closed_at: 19 ,
    day_of_week: 3 ,  #day_of_week : 3 => mercredi
    shop_id: sc2.id
},{
    opened_at: 9 ,
    closed_at: 18 ,
    day_of_week: 4 ,  #day_of_week : 4 => jeudi
    shop_id: sc2.id
},{
    opened_at: 8 ,
    closed_at: 19 ,
    day_of_week: 5 ,  #day_of_week : 5 => vendredi
    shop_id: sc2.id
},{
    opened_at: 8 ,
    closed_at: 19 ,
    day_of_week: 6 ,  #day_of_week : 6 => samedi
    shop_id: sc2.id
}]

time_tablec3 = [{       #day_of_weed : 0 : Dimanche, 1 : Lundi ..... Samedi : 6 #
    opened_at: 10 ,
    closed_at: 19 ,
    day_of_week: 1,  #day_of_week : 1 => lundi
    shop_id: sc3.id
},{
    opened_at: 9 ,
    closed_at: 18,
    day_of_week: 2,  #day_of_week : 2 => mardi
    shop_id: sc3.id
},{
    opened_at: 10 ,
    closed_at: 19 ,
    day_of_week: 3 ,  #day_of_week : 3 => mercredi
    shop_id: sc3.id
},{
    opened_at: 9 ,
    closed_at: 18 ,
    day_of_week: 4 ,  #day_of_week : 4 => jeudi
    shop_id: sc3.id
},{
    opened_at: 8 ,
    closed_at: 19 ,
    day_of_week: 5 ,  #day_of_week : 5 => vendredi
    shop_id: sc3.id
},{
    opened_at: 8 ,
    closed_at: 19 ,
    day_of_week: 6 ,  #day_of_week : 6 => samedi
    shop_id: sc3.id
}]

TimeTable.create!(time_table)
TimeTable.create!(time_tablec2)
TimeTable.create!(time_tablec3)
puts "Time table ok!"

puts "Tag creation start"

tag1 = Tag.create!(label: "chocolat")
tag2 = Tag.create!(label: "confiserie")


puts "Tags created !"

puts "Product tags creation start"

product_tags1 = [{
   tag_id: tag1.id ,
   product_id: p1.id ,
}, {
   tag_id: tag2.id ,
   product_id: p1.id ,
}]

ProductTag.create!(product_tags1)

puts "Product tags creation ok!"

puts "Lindt product operationnel"

#------------------------------------------------------------------------------------------------------------------------


################################################################################
##########################                      ################################
##########################  CARTOUCHE D'ENCRE   ################################
##########################                      ################################
################################################################################

puts "Creation shop start"
shop_cartouche_1 = {
   name: "Papeterie des Chartrons",
   user_id: u.id,
   address: "74 Rue Delord, 33300 Bordeaux",
   category: "Papeterie"
}
sc1 = Shop.create!(shop_cartouche_1)
puts "Shop create"


puts "Cartouche in creation"
cartouche1 = {
     name: "Cartouche d'encre HP 45",
     brand: "HP",
     description: "Cartouche de couleur noir d'une contenance de 42ml. Compatible HP Deskjet 1220",
     category_id: 1,
     product_sku: 4551645
}

cartouche2 = {
     name: "Cartouche d'encre HP 20",
     brand: "HP",
     description: "Cartouche de couleur noir d'une contenance de 40ml. Compatible HP APOLLO P2100",
     category_id: 1,
     product_sku: 206614
}

cartouche3 = {
     name: "Cartouche d'encre HP 49",
     brand: "HP",
     description: "Cartouche de couleur d'une contenance de 42ml. Compatible HP APOLLO P2100",
     category_id: 1,
     product_sku: 4951649
}

cartouche4 = {
     name: "Cartouche d'encre HP 56",
     brand: "HP",
     description: "Cartouche de couleur noir d'une contenance de 19ml. Compatible HP OFFICEJET 4105",
     category_id: 1,
     product_sku: 566656
}

cartouche5 = {
     name: "Cartouche d'encre HP 57",
     brand: "HP",
     description: "Cartouche de couleur d'une contenance de 18ml. Compatible HP OFFICEJET 4105",
     category_id: 1,
     product_sku: 576657
}

cartouche6 = {
     name: "Cartouche d'encre HP 28",
     brand: "HP",
     description: "Cartouche de couleur d'une contenance de 15ml. Compatible HP OFFICEJET 4105",
     category_id: 1,
     product_sku: 288728
}

pc1 = Product.create!(cartouche1)
pc2 = Product.create!(cartouche2)
pc3 = Product.create!(cartouche3)
pc4 = Product.create!(cartouche4)
pc5 = Product.create!(cartouche5)
pc6 = Product.create!(cartouche6)
puts "Cartouche HP create"


puts "Stock for cartouche in creation"
stock1 = {
     product_id: pc1.id ,
     shop_id: sc1.id ,
     quantity: 10 ,
     price: 22,
}
stock2 = {
     product_id: pc2.id ,
     shop_id: sc1.id ,
     quantity: 10 ,
     price: 20,
}
stock3 = {
     product_id: pc3.id ,
     shop_id: sc1.id ,
     quantity: 10 ,
     price: 15,
}
stock4 = {
     product_id: pc4.id ,
     shop_id: sc1.id ,
     quantity: 10 ,
     price: 14,
}
stock5 = {
     product_id: pc5.id ,
     shop_id: sc1.id ,
     quantity: 10 ,
     price: 25,
}
stock6 = {
     product_id: pc6.id ,
     shop_id: sc1.id ,
     quantity: 10 ,
     price: 16,
}

puts "Loading image...."

file2 = URI.open('https://static.fnac-static.com/multimedia/Images/FR/MC/12/d3/b5/11916050/1540-1/tsp20170228094212/HP-45-78-pack-de-2-1-noir-couleur-cyan-magenta-jaune-originale-cartouche-d-encre-C8788BC.jpg')
pc1.photo.attach(io: file2, filename: 'cartouche1.jpg', content_type: 'image/jpg')

puts "Image1 loaded OK"

puts "Loading image...."

file3 = URI.open('https://images-na.ssl-images-amazon.com/images/I/91Uu4m0sUYL._AC_SX425_.jpg')
pc2.photo.attach(io: file3, filename: 'cartouche2.jpg', content_type: 'image/jpg')

puts "Image2 loaded OK"

puts "Loading image...."

file4 = URI.open('https://static.fnac-static.com/multimedia/Images/FR/MC/f8/9b/4f/21994488/1540-1/tsp20170323081328/HP-49-couleur-cyan-magenta-jaune-originale-cartouche-d-encre.jpg')
pc3.photo.attach(io: file4, filename: 'cartouche3.jpg', content_type: 'image/jpg')

puts "Image3 loaded OK"

puts "Loading image...."

file5 = URI.open('https://static.fnac-static.com/multimedia/Images/FR/MC/f5/91/da/14324213/1540-1/tsp20170321084436/HP-56-noir-originale-cartouche-d-encre.jpg')
pc4.photo.attach(io: file5, filename: 'cartouche4.jpg', content_type: 'image/jpg')

puts "Image4 loaded OK"

puts "Loading image...."

file6 = URI.open('https://www.tinkco.com/photos/CAHC057_2.jpg')
pc5.photo.attach(io: file6, filename: 'cartouche5.jpg', content_type: 'image/jpg')

puts "Image5 loaded OK"

puts "Loading image...."

file7 = URI.open('https://www.cdiscount.com/pdt2/8/a/e/1/300x300/c8728ae/rw/hp-pack-de-1-cartouche-d-encre-28-original-trico.jpg')
pc6.photo.attach(io: file7, filename: 'cartouche6.jpg', content_type: 'image/jpg')

puts "Image6 loaded OK"


puts "Creation stocks start"

st1 = Stock.create!(stock1)
st2 = Stock.create!(stock2)
st3 = Stock.create!(stock3)
st4 = Stock.create!(stock4)
st5 = Stock.create!(stock5)
st6 = Stock.create!(stock6)

puts "Stock created"

puts "Time Table in creation"

time_table = [{       #day_of_weed : 0 : Dimanche, 1 : Lundi ..... Samedi : 6 #
    opened_at: 10 ,
    closed_at: 19 ,
    day_of_week: 1,  #day_of_week : 1 => lundi
    shop_id: sc1.id
},{
    opened_at: 9 ,
    closed_at: 18,
    day_of_week: 2,  #day_of_week : 2 => mardi
    shop_id: sc1.id
},{
    opened_at: 10 ,
    closed_at: 19 ,
    day_of_week: 3 ,  #day_of_week : 3 => mercredi
    shop_id: sc1.id
},{
    opened_at: 9 ,
    closed_at: 18 ,
    day_of_week: 4 ,  #day_of_week : 4 => jeudi
    shop_id: sc1.id
},{
    opened_at: 8 ,
    closed_at: 19 ,
    day_of_week: 5 ,  #day_of_week : 5 => vendredi
    shop_id: sc1.id
},{
    opened_at: 8 ,
    closed_at: 19 ,
    day_of_week: 6 ,  #day_of_week : 6 => samedi
    shop_id: sc1.id
}]

TimeTable.create!(time_table)
puts "Time table ok!"

puts "Tag creation start"

tag3 = Tag.create!(label: "encre")
tag4 = Tag.create!(label: "imprimante")


puts "Tags created !"

puts "Product tags creation start"

product_tags2 = [{
   tag_id: tag3.id ,
   product_id: pc1.id ,
}, {
   tag_id: tag4.id ,
   product_id: pc1.id ,
}]
product_tags3 = [{
   tag_id: tag3.id ,
   product_id: pc2.id ,
}, {
   tag_id: tag4.id ,
   product_id: pc2.id ,
}]
product_tags4 = [{
   tag_id: tag3.id ,
   product_id: pc3.id ,
}, {
   tag_id: tag4.id ,
   product_id: pc3.id ,
}]
product_tags5 = [{
   tag_id: tag3.id ,
   product_id: pc4.id ,
}, {
   tag_id: tag4.id ,
   product_id: pc4.id ,
}]
product_tags6 = [{
   tag_id: tag3.id ,
   product_id: pc5.id ,
}, {
   tag_id: tag4.id ,
   product_id: pc5.id ,
}]
product_tags7 = [{
   tag_id: tag3.id ,
   product_id: pc6.id ,
}, {
   tag_id: tag4.id ,
   product_id: pc6.id ,
}]

ProductTag.create!(product_tags2)
ProductTag.create!(product_tags3)
ProductTag.create!(product_tags4)
ProductTag.create!(product_tags5)
ProductTag.create!(product_tags6)
ProductTag.create!(product_tags7)

puts "Product tags creation ok!"

puts "Shop 1 operationnel"

#------------------------------------------------------------------------------------------------------------------------
#                                    || SHOP 2 ||
#------------------------------------------------------------------------------------------------------------------------

puts "Creation shop start"
shop_cartouche_2 = {
   name: "La Petite Machine",
   user_id: u.id,
   address: "47 Rue le Chapelier, 33000 Bordeaux",
   category: "Papeterie"
}
sc2 = Shop.create!(shop_cartouche_2)
puts "Shop create"


puts "Stock for cartouche in creation"

stock1 = {
     product_id: pc1.id ,
     shop_id: sc2.id ,
     quantity: 10 ,
     price: 25,
}
stock2 = {
     product_id: pc2.id ,
     shop_id: sc2.id ,
     quantity: 10 ,
     price: 23,
}
stock3 = {
     product_id: pc3.id ,
     shop_id: sc2.id ,
     quantity: 10 ,
     price: 18,
}
stock4 = {
     product_id: pc4.id ,
     shop_id: sc2.id ,
     quantity: 10 ,
     price: 16,
}
stock5 = {
     product_id: pc5.id ,
     shop_id: sc2.id ,
     quantity: 10 ,
     price: 27,
}
stock6 = {
     product_id: pc6.id ,
     shop_id: sc2.id ,
     quantity: 10 ,
     price: 18,
}

puts "Creation stocks start"

st2 = Stock.create!(stock2)
st3 = Stock.create!(stock3)
st4 = Stock.create!(stock4)
st5 = Stock.create!(stock5)
st6 = Stock.create!(stock6)

puts "Stock created"

puts "Time Table in creation"

time_table = [{       #day_of_weed : 0 : Dimanche, 1 : Lundi ..... Samedi : 6 #
    opened_at: 10 ,
    closed_at: 19 ,
    day_of_week: 1,  #day_of_week : 1 => lundi
    shop_id: sc2.id
},{
    opened_at: 9 ,
    closed_at: 18,
    day_of_week: 2,  #day_of_week : 2 => mardi
    shop_id: sc2.id
},{
    opened_at: 10 ,
    closed_at: 19 ,
    day_of_week: 3 ,  #day_of_week : 3 => mercredi
    shop_id: sc2.id
},{
    opened_at: 9 ,
    closed_at: 18 ,
    day_of_week: 4 ,  #day_of_week : 4 => jeudi
    shop_id: sc2.id
},{
    opened_at: 8 ,
    closed_at: 19 ,
    day_of_week: 5 ,  #day_of_week : 5 => vendredi
    shop_id: sc2.id
},{
    opened_at: 8 ,
    closed_at: 19 ,
    day_of_week: 6 ,  #day_of_week : 6 => samedi
    shop_id: sc2.id
}]

TimeTable.create!(time_table)
puts "Time table ok!"

puts "Shop 2 operationnel"

#------------------------------------------------------------------------------------------------------------------------
#                                   ||| SHOP 3 |||
#------------------------------------------------------------------------------------------------------------------------



puts "Creation shop start"
shop_cartouche_3 = {
   name: "Gropapier",
   user_id: u.id,
   address: "134 Rue du Jardin public, 33300 Bordeaux",
   category: "Papeterie"
}
sc3 = Shop.create!(shop_cartouche_3)
puts "Shop create"


puts "Stock for cartouche in creation"

stock7 = {
     product_id: pc1.id ,
     shop_id: sc3.id ,
     quantity: 10 ,
     price: 23,
}
stock8 = {
     product_id: pc2.id ,
     shop_id: sc3.id ,
     quantity: 10 ,
     price: 21,
}
stock9 = {
     product_id: pc3.id ,
     shop_id: sc3.id ,
     quantity: 10 ,
     price: 20,
}
stock10 = {
     product_id: pc4.id ,
     shop_id: sc3.id ,
     quantity: 10 ,
     price: 18,
}
stock11 = {
     product_id: pc5.id ,
     shop_id: sc3.id ,
     quantity: 10 ,
     price: 25,
}
stock12 = {
     product_id: pc6.id ,
     shop_id: sc3.id ,
     quantity: 10 ,
     price: 20,
}

puts "Creation stocks start"

st7 = Stock.create!(stock7)
st8 = Stock.create!(stock8)
st9 = Stock.create!(stock9)
st10 = Stock.create!(stock10)
st11 = Stock.create!(stock11)
st12 = Stock.create!(stock12)

puts "Stock created"

puts "Time Table in creation"

time_table = [{       #day_of_weed : 0 : Dimanche, 1 : Lundi ..... Samedi : 6 #
    opened_at: 10 ,
    closed_at: 19 ,
    day_of_week: 1,  #day_of_week : 1 => lundi
    shop_id: sc3.id
},{
    opened_at: 9 ,
    closed_at: 18,
    day_of_week: 2,  #day_of_week : 2 => mardi
    shop_id: sc3.id
},{
    opened_at: 10 ,
    closed_at: 19 ,
    day_of_week: 3 ,  #day_of_week : 3 => mercredi
    shop_id: sc3.id
},{
    opened_at: 9 ,
    closed_at: 18 ,
    day_of_week: 4 ,  #day_of_week : 4 => jeudi
    shop_id: sc3.id
},{
    opened_at: 8 ,
    closed_at: 19 ,
    day_of_week: 5 ,  #day_of_week : 5 => vendredi
    shop_id: sc3.id
},{
    opened_at: 8 ,
    closed_at: 19 ,
    day_of_week: 6 ,  #day_of_week : 6 => samedi
    shop_id: sc3.id
}]

TimeTable.create!(time_table)
puts "Time table ok!"

puts "Shop 3 operationnel"

#------------------------------------------------------------------------------------------------------------------------
#                                      | SHOP 4 (TALENCE) |
#------------------------------------------------------------------------------------------------------------------------
puts "Creation shop talence start"
shop_cartouche_t = {
   name: "Papeterie de Talence",
   user_id: u.id,
   address: "234 Cours Gambetta, 33400 Talence",
   category: "Papeterie"
}
sct = Shop.create!(shop_cartouche_t)
puts "Shop create"


puts "Cartouche in creation"
cartouchet1 = {
     name: "Cartouche d'encre Brother 45",
     brand: "Brother",
     description: "Cartouche de couleur noir d'une contenance de 42ml. Compatible Brother",
     category_id: 1,
     product_sku: 9876543
}

cartouchet2 = {
     name: "Cartouche d'encre Brother 20",
     brand: "Brother",
     description: "Cartouche de couleur noir d'une contenance de 40ml. Compatible Brother",
     category_id: 1,
     product_sku: 76543
}


cartouchet3 = {
     name: "Cartouche d'encre Brother 49",
     brand: "Brother",
     description: "Cartouche de couleur d'une contenance de 42ml. Compatible Brother",
     category_id: 1,
     product_sku: 12345
}

cartouchet4 = {
     name: "Cartouche d'encre Brother 56",
     brand: "Brother",
     description: "Cartouche de couleur noir d'une contenance de 19ml. Compatible Brother05",
     category_id: 1,
     product_sku: 987657
}

cartouchet5 = {
     name: "Cartouche d'encre Brother 57",
     brand: "Brother",
     description: "Cartouche de couleur d'une contenance de 18ml. Compatible Brother05",
     category_id: 1,
     product_sku: 345643
}

cartouchet6 = {
     name: "Cartouche d'encre HP 28",
     brand: "HP",
     description: "Cartouche de couleur d'une contenance de 15ml. Compatible HP OFFICEJET 4105",
     category_id: 1,
     product_sku: 235432
}
cartouchet7 = {
     name: "Cartouche d'encre HP 45",
     brand: "HP",
     description: "Cartouche de couleur noir d'une contenance de 42ml. Compatible HP Deskjet 1220",
     category_id: 1,
     product_sku: 675857
}

cartouchet8 = {
     name: "Cartouche d'encre HP 20",
     brand: "HP",
     description: "Cartouche de couleur noir d'une contenance de 40ml. Compatible HP APOLLO P2100",
     category_id: 1,
     product_sku: 57858
}

cartouchet9 = {
     name: "Cartouche d'encre HP 49",
     brand: "HP",
     description: "Cartouche de couleur d'une contenance de 42ml. Compatible HP APOLLO P2100",
     category_id: 1,
     product_sku: 5785875
}

cartouchet10 = {
     name: "Cartouche d'encre HP 56",
     brand: "HP",
     description: "Cartouche de couleur noir d'une contenance de 19ml. Compatible HP OFFICEJET 4105",
     category_id: 1,
     product_sku: 578758
}

cartouchet11 = {
     name: "Cartouche d'encre HP 57",
     brand: "HP",
     description: "Cartouche de couleur d'une contenance de 18ml. Compatible HP OFFICEJET 4105",
     category_id: 1,
     product_sku: 75877578
}

cartouchet12 = {
     name: "Cartouche d'encre HP 28",
     brand: "HP",
     description: "Cartouche de couleur d'une contenance de 15ml. Compatible HP OFFICEJET 4105",
     category_id: 1,
     product_sku: 578757848
}



pc7 = Product.create!(cartouchet1)
pc8 = Product.create!(cartouchet2)
pc9 = Product.create!(cartouchet3)
pc10 = Product.create!(cartouchet4)
pc11 = Product.create!(cartouchet5)
pc12 = Product.create!(cartouchet6)
pc13 = Product.create!(cartouchet7)
pc14 = Product.create!(cartouchet8)
pc15 = Product.create!(cartouchet9)
pc16 = Product.create!(cartouchet10)
pc17 = Product.create!(cartouchet11)
pc18 = Product.create!(cartouchet12)
puts "Cartouche HP create"


puts "Stock for cartouche in creation"
stockt1 = {
     product_id: pc7.id ,
     shop_id: sct.id ,
     quantity: 10 ,
     price: 22,
}
stockt2 = {
     product_id: pc8.id ,
     shop_id: sct.id ,
     quantity: 10 ,
     price: 20,
}
stockt3 = {
     product_id: pc9.id ,
     shop_id: sct.id ,
     quantity: 10 ,
     price: 15,
}
stockt4 = {
     product_id: pc10.id ,
     shop_id: sct.id ,
     quantity: 10 ,
     price: 14,
}
stockt5 = {
     product_id: pc11.id ,
     shop_id: sct.id ,
     quantity: 10 ,
     price: 25,
}
stockt6 = {
     product_id: pc12.id ,
     shop_id: sct.id ,
     quantity: 10 ,
     price: 16,
}
stockt7 = {
     product_id: pc13.id ,
     shop_id: sct.id ,
     quantity: 10 ,
     price: 22,
}
stockt8 = {
     product_id: pc14.id ,
     shop_id: sct.id ,
     quantity: 10 ,
     price: 20,
}
stockt9 = {
     product_id: pc15.id ,
     shop_id: sct.id ,
     quantity: 10 ,
     price: 15,
}
stockt10 = {
     product_id: pc16.id ,
     shop_id: sct.id ,
     quantity: 10 ,
     price: 14,
}
stockt11 = {
     product_id: pc17.id ,
     shop_id: sct.id ,
     quantity: 10 ,
     price: 25,
}
stockt12 = {
     product_id: pc18.id ,
     shop_id: sct.id ,
     quantity: 10 ,
     price: 16,
}

puts "Loading image...."

file8 = URI.open('https://bv-prd-fbi-fr-media.s3.amazonaws.com/pub/media/catalog/product/c/9/c94854c3b0c3908381aa1ecfd25693f7984838a4_9df85423_2810_4116_a4a9_08d3e44117d6.jpg')
pc7.photo.attach(io: file8, filename: 'cartouchet1.jpg', content_type: 'image/jpg')

puts "Image1 loaded OK"

puts "Loading image...."

file9 = URI.open('https://www.tinkco.com/photos/TINBR050B_2.jpg')
pc8.photo.attach(io: file9, filename: 'cartouchet2.jpg', content_type: 'image/jpg')

puts "Image2 loaded OK"

puts "Loading image...."

file10 = URI.open('https://www.tinkco.com/photos/TINBR050B_2.jpg')
pc9.photo.attach(io: file10, filename: 'cartouchet3.jpg', content_type: 'image/jpg')

puts "Image3 loaded OK"

puts "Loading image...."

file11 = URI.open('https://prod.isg.bruneau.media/OMM/Images_Basse_Definition/ZoomHD/65/67/65671.jpg?width=2000&height=2000&mode=Default&quality=85&scale=upscalecanvas')
pc10.photo.attach(io: file11, filename: 'cartouchet4.jpg', content_type: 'image/jpg')

puts "Image4 loaded OK"

puts "Loading image...."

file12 = URI.open('https://www.encreservices.fr/images/produits/zoom/LC123BK_2.jpg')
pc11.photo.attach(io: file12, filename: 'cartouchet5.jpg', content_type: 'image/jpg')

puts "Image5 loaded OK"

puts "Loading image...."

file13 = URI.open('https://prod.isg.bruneau.media/OMM/Images_Basse_Definition/ZoomHD/65/67/65671.jpg?width=2000&height=2000&mode=Default&quality=85&scale=upscalecanvas')
pc12.photo.attach(io: file13, filename: 'cartouchet6.jpg', content_type: 'image/jpg')

puts "Image6 loaded OK"

file14 = URI.open('https://bv-prd-fbi-fr-media.s3.amazonaws.com/pub/media/catalog/product/c/9/c94854c3b0c3908381aa1ecfd25693f7984838a4_9df85423_2810_4116_a4a9_08d3e44117d6.jpg')
pc13.photo.attach(io: file14, filename: 'cartouchet_1.jpg', content_type: 'image/jpg')

puts "Image1 loaded OK"


puts "Loading image...."
file15 = URI.open('https://www.tinkco.com/photos/TINBR050B_2.jpg')
pc14.photo.attach(io: file15, filename: 'cartouchet_2.jpg', content_type: 'image/jpg')

puts "Image2 loaded OK"

puts "Loading image...."

file16 = URI.open('https://www.tinkco.com/photos/TINBR050B_2.jpg')
pc15.photo.attach(io: file16, filename: 'cartouchet_3.jpg', content_type: 'image/jpg')

puts "Image3 loaded OK"

puts "Loading image...."

file17 = URI.open('https://prod.isg.bruneau.media/OMM/Images_Basse_Definition/ZoomHD/65/67/65671.jpg?width=2000&height=2000&mode=Default&quality=85&scale=upscalecanvas')
pc16.photo.attach(io: file17, filename: 'cartouchet_4.jpg', content_type: 'image/jpg')

puts "Image4 loaded OK"

puts "Loading image...."

file18 = URI.open('https://www.encreservices.fr/images/produits/zoom/LC123BK_2.jpg')
pc17.photo.attach(io: file18, filename: 'cartouchet_5.jpg', content_type: 'image/jpg')

puts "Image5 loaded OK"

puts "Loading image...."

file19 = URI.open('https://prod.isg.bruneau.media/OMM/Images_Basse_Definition/ZoomHD/65/67/65671.jpg?width=2000&height=2000&mode=Default&quality=85&scale=upscalecanvas')
pc18.photo.attach(io: file19, filename: 'cartouchet_6.jpg', content_type: 'image/jpg')

puts "Image6 loaded OK"


puts "Creation stocks start"

stt1 = Stock.create!(stockt1)
stt2 = Stock.create!(stockt2)
stt3 = Stock.create!(stockt3)
stt4 = Stock.create!(stockt4)
stt5 = Stock.create!(stockt5)
stt6 = Stock.create!(stockt6)
stt7 = Stock.create!(stockt7)
stt8 = Stock.create!(stockt8)
stt9 = Stock.create!(stockt9)
stt10 = Stock.create!(stockt10)
stt11 = Stock.create!(stockt11)
stt12 = Stock.create!(stockt12)

puts "Stock created"

puts "Time Table in creation"

time_table = [{       #day_of_weed : 0 : Dimanche, 1 : Lundi ..... Samedi : 6 #
    opened_at: 10 ,
    closed_at: 19 ,
    day_of_week: 1,  #day_of_week : 1 => lundi
    shop_id: sct.id
},{
    opened_at: 9 ,
    closed_at: 18,
    day_of_week: 2,  #day_of_week : 2 => mardi
    shop_id: sct.id
},{
    opened_at: 10 ,
    closed_at: 19 ,
    day_of_week: 3 ,  #day_of_week : 3 => mercredi
    shop_id: sct.id
},{
    opened_at: 9 ,
    closed_at: 18 ,
    day_of_week: 4 ,  #day_of_week : 4 => jeudi
    shop_id: sct.id
},{
    opened_at: 8 ,
    closed_at: 19 ,
    day_of_week: 5 ,  #day_of_week : 5 => vendredi
    shop_id: sct.id
},{
    opened_at: 8 ,
    closed_at: 19 ,
    day_of_week: 6 ,  #day_of_week : 6 => samedi
    shop_id: sct.id
}]

TimeTable.create!(time_table)
puts "Time table ok!"

puts "Tag creation start"

tag3 = Tag.create!(label: "encre")
tag4 = Tag.create!(label: "imprimante")


puts "Tags created !"

puts "Product tags creation start"

product_tags_t2 = [{
   tag_id: tag3.id ,
   product_id: pc7.id ,
}, {
   tag_id: tag4.id ,
   product_id: pc8.id ,
}]
product_tags_t3 = [{
   tag_id: tag3.id ,
   product_id: pc9.id ,
}, {
   tag_id: tag4.id ,
   product_id: pc10.id ,
}]
product_tags_t4 = [{
   tag_id: tag3.id ,
   product_id: pc11.id ,
}, {
   tag_id: tag4.id ,
   product_id: pc12.id ,
}]
product_tags_t5 = [{
   tag_id: tag3.id ,
   product_id: pc13.id ,
}, {
   tag_id: tag4.id ,
   product_id: pc14.id ,
}]
product_tags_t6 = [{
   tag_id: tag3.id ,
   product_id: pc15.id ,
}, {
   tag_id: tag4.id ,
   product_id: pc16.id ,
}]
product_tags_t7 = [{
   tag_id: tag3.id ,
   product_id: pc17.id ,
}, {
   tag_id: tag4.id ,
   product_id: pc18.id ,
}]

ProductTag.create!(product_tags_t2)
ProductTag.create!(product_tags_t3)
ProductTag.create!(product_tags_t4)
ProductTag.create!(product_tags_t5)
ProductTag.create!(product_tags_t6)
ProductTag.create!(product_tags_t7)

puts "Product tags creation ok!"

puts "Shop 3 operationnel"

#------------------------------------------------------------------------------------------------------------------------
#----------------------------------FROMAGE-------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------

fromager_1 = {
   name: "L'héritage de Robert",
   user_id: u.id,
   address: "9 Rue Ravez, 33000 Bordeaux",
   category: "Fromager"
}

fr1 = Shop.create!(fromager_1)
puts "Shop1 create"

fromager_2 = {
   name: "Olivier le petit fromager",
   user_id: u.id,
   address: "Place Saint-Martial, 33300 Bordeaux",
   category: "Producteur"
}

fr2 = Shop.create!(fromager_2)
puts "Shop2 create"

time_table_fromage_1 = [{       #day_of_weed : 0 : Dimanche, 1 : Lundi ..... Samedi : 6 #
    opened_at: 10 ,
    closed_at: 19 ,
    day_of_week: 1,  #day_of_week : 1 => lundi
    shop_id: fr1.id
},{
    opened_at: 9 ,
    closed_at: 18,
    day_of_week: 2,  #day_of_week : 2 => mardi
    shop_id: fr1.id
},{
    opened_at: 10 ,
    closed_at: 19 ,
    day_of_week: 3 ,  #day_of_week : 3 => mercredi
    shop_id: fr1.id
},{
    opened_at: 9 ,
    closed_at: 18 ,
    day_of_week: 4 ,  #day_of_week : 4 => jeudi
    shop_id: fr1.id
},{
    opened_at: 8 ,
    closed_at: 19 ,
    day_of_week: 5 ,  #day_of_week : 5 => vendredi
    shop_id: fr1.id
},{
    opened_at: 8 ,
    closed_at: 12 ,
    day_of_week: 6 ,  #day_of_week : 6 => samedi
    shop_id: fr1.id
}]

TimeTable.create!(time_table_fromage_1)
puts "Time table ok!"

time_table_fromage_2 = [{
    opened_at: 9 ,
    closed_at: 15 ,
    day_of_week: 3 ,  #day_of_week : 3 => mercredi
    shop_id: fr2.id
},{
    opened_at: 8 ,
    closed_at: 14 ,
    day_of_week: 0 ,  #day_of_week : 6 => samedi
    shop_id: fr2.id
}]

TimeTable.create!(time_table_fromage_2)
puts "Time table ok!"

puts "Fromage in creation"
fromage1 = {
     name: "Emmentale rapé",
     brand: "Président",
     description: "Fromage de qualité très moyenne",
     category_id: 1,
     product_sku: 636737
}

fromage2 = {
     name: "Gouda au cumin",
     brand: "Président",
     description: "Fromage Gouda de qualité moyenne",
     category_id: 1,
     product_sku: 673756
}

fromage3 = {
     name: "Camembert",
     brand: "Président",
     description: "Fromage frais fumé au bois de hêtre",
     category_id: 1,
     product_sku: 1343143
}

fromage4 = {
     name: "Fromage de chèvre cendré",
     brand: "Olivier le petit fromager",
     description: "Remarquable fromage de chèvre frais",
     category_id: 1,
     product_sku: 8577589
}

fromage5 = {
     name: "Rocamadour",
     brand: "L'héritage de Robert",
     description: "Super fromage frais au lait cru",
     category_id: 1,
     product_sku: 76445676
}

fromage6 = {
     name: "Cabécou",
     brand: "L'héritage de Robert",
     description: "Fromage frais de chèvre coulant",
     category_id: 1,
     product_sku: 1960968
}
fromage7 = {
     name: "Chaussée aux moines",
     brand: "Chaussée aux moines",
     description: "Fromage à pâte pressée non cuite et au lait pasteurisé",
     category_id: 1,
     product_sku: 19689690
}

fromage8 = {
     name: "Bleu d'Auvergne",
     brand: "Olivier le petit fromager",
     description: "Fromage frais AOP de qualité supérieur",
     category_id: 1,
     product_sku: 1906866
}

fromage9 = {
     name: "Saint Nectaire",
     brand: "Olivier le ptit fromager",
     description: "Fromage frais AOP au lait cru. Pâte pressée non cuite",
     category_id: 1,
     product_sku: 6790988
}

fromage10 = {
     name: "Comté",
     brand: "L'héritage de Robert",
     description: "Fromage frais AOP affiné 36 mois",
     category_id: 1,
     product_sku: 8979696
}

fromage11 = {
     name: "Mimolette",
     brand: "L'héritage de Robert",
     description: "Fromage frais à pate dur",
     category_id: 1,
     product_sku: 8769796
}

fromage12 = {
     name: "Éspoisse",
     brand: "Olivier le petit fromager",
     description: "Fromage frais AOP un peu trop coulant",
     category_id: 1,
     product_sku: 1960867
}

f1 = Product.create!(fromage1)
f2 = Product.create!(fromage2)
f3 = Product.create!(fromage3)
f4 = Product.create!(fromage4)
f5 = Product.create!(fromage5)
f6 = Product.create!(fromage6)
f7 = Product.create!(fromage7)
f8 = Product.create!(fromage8)
f9 = Product.create!(fromage9)
f10 = Product.create!(fromage10)
f11 = Product.create!(fromage11)
f12 = Product.create!(fromage12)

stockt_fromage1 = {
     product_id: f1.id ,
     shop_id: s1.id ,
     quantity: 10 ,
     price: 2,
}
stockt_fromage2 = {
     product_id: f2.id ,
     shop_id: s1.id ,
     quantity: 10 ,
     price: 3,
}

stockt_fromage3 = {
     product_id: f3.id ,
     shop_id: s1.id ,
     quantity: 10 ,
     price: 4,
}
stockt_fromage4 = {
     product_id: f4.id ,
     shop_id: fr2.id ,
     quantity: 10 ,
     price: 3,
}
stockt_fromage5 = {
     product_id: f5.id ,
     shop_id: fr1.id ,
     quantity: 10 ,
     price: 3,
}
stockt_fromage6 = {
     product_id: f6.id ,
     shop_id: fr1.id ,
     quantity: 10 ,
     price: 2,
}
stockt_fromage7 = {
     product_id: f7.id ,
     shop_id: s1.id ,
     quantity: 10 ,
     price: 3,
}
stockt_fromage8 = {
     product_id: f8.id ,
     shop_id: fr2.id ,
     quantity: 10 ,
     price: 4,
}
stockt_fromage9 = {
     product_id: f9.id ,
     shop_id: fr2.id ,
     quantity: 10 ,
     price: 4,
}
stockt_fromage10 = {
     product_id: f10.id ,
     shop_id: fr1.id ,
     quantity: 10 ,
     price: 5,
}
stockt_fromage11 = {
     product_id: f11.id ,
     shop_id: fr1.id ,
     quantity: 10 ,
     price: 2,
}
stockt_fromage12 = {
     product_id: f12.id ,
     shop_id: fr2.id ,
     quantity: 10 ,
     price: 3,
}

puts "Loading image...."

file20 = URI.open('https://www.paysanbreton.com/sites/default/files/styles/product_large/public/formats/fromages-rape.png?itok=n5swi7Qj')
f1.photo.attach(io: file20, filename: 'fromage1.jpg', content_type: 'image/jpg')

puts "Image6 loaded OK"

puts "Loading image...."

file21 = URI.open('https://www.fromage-pouillot.fr/142-large_default/gouda-au-cumin.jpg')
f2.photo.attach(io: file21, filename: 'fromage2.jpg', content_type: 'image/jpg')

puts "Image6 loaded OK"

puts "Loading image...."

file22 = URI.open('https://assets.afcdn.com/story/20190219/1333694_w980h638c1cx2304cy1536.jpg')
f3.photo.attach(io: file22, filename: 'fromage3.jpg', content_type: 'image/jpg')

puts "Image6 loaded OK"

puts "Loading image...."

file23 = URI.open('https://static.lecomptoirlocal.fr/img/produits/898654cc4675ecc6b31e3bce05bd263f/large.jpg')
f4.photo.attach(io: file23, filename: 'fromage4.jpg', content_type: 'image/jpg')

puts "Image6 loaded OK"

puts "Loading image...."

file24 = URI.open('https://d3rrv21q7fx9b0.cloudfront.net/m/69e51f397ae7c9f7/LA02_768x400-LA02_37_rocamadour_9.jpg')
f5.photo.attach(io: file24, filename: 'fromage5.jpg', content_type: 'image/jpg')

puts "Image6 loaded OK"

puts "Loading image...."

file25 = URI.open('https://www.grandfrais.com/userfiles/image/produit/gfp-20140528122859.jpg')
f6.photo.attach(io: file25, filename: 'fromage6.jpg', content_type: 'image/jpg')

puts "Image6 loaded OK"

puts "Loading image...."

file26 = URI.open('https://static.openfoodfacts.org/images/products/311/427/040/0334/front_fr.7.full.jpg')
f7.photo.attach(io: file26, filename: 'fromage7.jpg', content_type: 'image/jpg')

puts "Image6 loaded OK"

puts "Loading image...."

file27 = URI.open('https://www.toutunfromage.com/179-large_default/bleu-d-auvergne-fermier.jpg')
f8.photo.attach(io: file27, filename: 'fromage8.jpg', content_type: 'image/jpg')

puts "Image6 loaded OK"

puts "Loading image...."

file28 = URI.open('https://www.fromages-aop-auvergne.com/wp-content/themes/afa/images/fromages/aop-saint-nectaire.png')
f9.photo.attach(io: file28, filename: 'fromage9.jpg', content_type: 'image/jpg')

puts "Image6 loaded OK"

puts "Loading image...."

file29 = URI.open('https://www.coop-de-yenne.fr/230-large_default/comte-extra-aop-.jpg')
f10.photo.attach(io: file29, filename: 'fromage10.jpg', content_type: 'image/jpg')

puts "Image6 loaded OK"

puts "Loading image...."

file30 = URI.open('https://www.lacremerieroyale.fr/pub/produits/mimolette-24-mois.jpg')
f11.photo.attach(io: file30, filename: 'fromage11.jpg', content_type: 'image/jpg')

puts "Image6 loaded OK"

puts "Loading image...."

file31 = URI.open('https://www.murrayscheese.com/site/images/items/00000000094.0.jpg?resizeid=9&resizeh=300&resizew=300')
f12.photo.attach(io: file31, filename: 'fromage12.jpg', content_type: 'image/jpg')

puts "Image6 loaded OK"

stf1 = Stock.create!(stockt_fromage1)
stf2 = Stock.create!(stockt_fromage2)
stf3 = Stock.create!(stockt_fromage3)
stf4 = Stock.create!(stockt_fromage4)
stf5 = Stock.create!(stockt_fromage5)
stf6 = Stock.create!(stockt_fromage6)
stf7 = Stock.create!(stockt_fromage7)
stf8 = Stock.create!(stockt_fromage8)
stf9 = Stock.create!(stockt_fromage9)
stf10 = Stock.create!(stockt_fromage10)
stf11 = Stock.create!(stockt_fromage11)
stf12 = Stock.create!(stockt_fromage12)

tag8 = Tag.create!(label: "frais")
tag9 = Tag.create!(label: "AOP")

product_tags_fromage_t2 = [{
   tag_id: tag8.id ,
   product_id: f3.id ,
}, {
   tag_id: tag9.id ,
   product_id: f4.id ,
}]
product_tags_fromage_t3 = [{
   tag_id: tag8.id ,
   product_id: f4.id ,
}, {
   tag_id: tag9.id ,
   product_id: f8.id ,
}]
product_tags_fromage_t4 = [{
   tag_id: tag8.id ,
   product_id: f5.id ,
}, {
   tag_id: tag9.id ,
   product_id: f9.id ,
}]
product_tags_fromage_t5 = [{
   tag_id: tag8.id ,
   product_id: f6.id ,
}, {
   tag_id: tag9.id ,
   product_id: f10.id ,
}]
product_tags_fromage_t6 = [{
   tag_id: tag8.id ,
   product_id: f8.id ,
}, {
   tag_id: tag9.id ,
   product_id: f12.id ,
}]
product_tags_fromage_t7 = [{
   tag_id: tag8.id ,
   product_id: f9.id ,
}]

product_tags_fromage_t8 = [{
   tag_id: tag8.id ,
   product_id: f10.id ,
}]

product_tags_fromage_t9 = [{
   tag_id: tag8.id ,
   product_id: f11.id ,
}]

product_tags_fromage_t10 = [{
   tag_id: tag8.id ,
   product_id: f12.id ,
}]

ProductTag.create!(product_tags_fromage_t2)
ProductTag.create!(product_tags_fromage_t3)
ProductTag.create!(product_tags_fromage_t4)
ProductTag.create!(product_tags_fromage_t5)
ProductTag.create!(product_tags_fromage_t6)
ProductTag.create!(product_tags_fromage_t7)
ProductTag.create!(product_tags_fromage_t8)
ProductTag.create!(product_tags_fromage_t9)
ProductTag.create!(product_tags_fromage_t10)
