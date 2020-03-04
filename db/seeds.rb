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


puts "Tags destroyed!"

User.destroy_all

puts "Users destroyed!"



# ---------------------------DESTRUCTION-DONE-------------------

puts "User construction start !"

# #############################USER-CREATION########################



user = {email: "dezanneaucharlotte@gmail.com", password:"charlotte"}
u = User.create!(user)

cat = {label: "null"}
c = Category.create!(cat)

# -----------------------------USER-DONE---------------------------

puts "User created ok"

# ------------------------- OPEN FOOD FACTS ------------------------
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



#---------------------- Shop address Chartrons -----------------------

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


# #------------------------------------------------------------------

# #---------------------- Shop address Talence -----------------------

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

# ---------------------------- Stocks creation ----------------------------

puts "stock in creation"

Shop.all.ids.each do |id|
  Faker::Config.locale = 'fr'
  new_stock = {
    product_id: Product.all.ids.sample,
    shop_id: id,
    quantity: rand(1..20),
    price: Faker::Commerce.price(range: 3..15),
  }

  Stock.create!(new_stock)
end


#shop7 = {
#  name: "Leroy Merlin",
#  user_id: u.id ,
#  address: "3 Rue Dumont d'Urville, 33300 Bordeaux",
#  category: "Bricolage grande surface"
#}

#shop8 = {
#  name: "Bricorelais",
#  user_id: u.id ,
#  address: "115 Cours Victor Hugo, 33000 Bordeaux",
#  category: "Bricolage"
#}

#s1 = Shop.create!(shop1)
#s2 = Shop.create!(shop2)
#s3 = Shop.create!(shop3)
#s4 = Shop.create!(shop4)
#s5 = Shop.create!(shop5)
#s6 = Shop.create!(shop6)
#s7 = Shop.create!(shop7)
#s8 = Shop.create!(shop8)

#  puts "stocks created"


#-----------------------------------------------------------

#----------------------- Tags creation ---------------------
puts "Creation tags"


my_actual_products = Product.all
my_actual_products.each do |product|
  info_product = Openfoodfacts::Product.get(product.product_sku, locale: 'fr')

  info_product.categories.split(',').each do |info|
    tag = Tag.create!(label: info)

    ProductTag.create!(tag_id: tag.id, product_id: product.id)
    puts "Product tag created ok"
  end


end




#product1 = {
#    name: "Pizza Nico",
#   brand: "Nico",
#    description: "La meilleure des Pizzas"



# ------------------------TIME-TABLE-CREATION---------------
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

puts "Time table creation end"

#-------------------------------------------------------------
puts "SEED DONE :D"


#product6 = {
#    name: "Pizza Hut",
#    brand: "Bob",
#    description: "La pire des Pizzas"



#   product7 = {
#     name: "VIS METAUX TETE FRAISEE BOMBEE TFB POZI 6X50 ALUMINIUM",
#     brand: "VIS EXPRESS",
#     description: "Diametre=6, Matiere=Aluminium, Norme=DIN 966"

#   }

#   product8 = {
#     name: "VIS POUR BOIS ET AGGLOMERE TETE RONDE ",
#     brand: "VIS EXPRESS",
#     description: "TR POZI 2 4X80 FILETEE SUR 48 ACIER ZING BLANC"

#   }

#   product9 = {
#     name: "VBA/VIS POUR BOIS ET AGGLOMERE TETE RONDE",
#     brand: "LEGRAND",
#     description: "TR POZI 3 6X35 ACIER ZINGUE NOIR"

#   }


# # ############################SHOP-CREATION#######################


# p7 = Product.create!(product7)
# p8 = Product.create!(product8)
# p9 = Product.create!(product9)


# shop1 = {
#     name: "Pizza Nico",
#     user_id: u.id ,
#     address: "134 Cours Balguerie Stuttenberg, 33300 Bordeaux",
#     category: "Pizzeria"
#   }
# shop2 = {
#     name: "Chez paul",
#     user_id: u.id ,
#     address: "51 cours du medoc, 33300 Bordeaux",
#     category: "Boulangerie"
#   }
# shop3 = {
#     name: "Le baraka",
#     user_id: u.id ,
#     address: "4 Cours Balguerie Stuttenberg, 33300 Bordeaux",
#     category: "Kebab"
#   }
# shop4 = {
#     name: "Makadam Fitness",
#     user_id: u.id ,
#     address: "90 Cours Balguerie Stuttenberg, 33300 Bordeaux",
#     category: "Pour les biscotos"
#   }
# shop5 = {
#     name: "La rotisserie",
#     user_id: u.id ,
#     address: "place saint martial, 33300 Bordeaux",
#     category: "Des gros cochons"
#   }

# shop6 = {
#   name: "Le Kiosque à Pizzas",
#   user_id: u.id ,
#   address: "453bis Cours de la Libération, 33400 Talence",
#   category: "Pizzeria"
# }

# s1 = Shop.create!(shop1)
# s2 = Shop.create!(shop2)
# s3 = Shop.create!(shop3)
# s4 = Shop.create!(shop4)
# s5 = Shop.create!(shop5)

# s6 = Shop.create!(shop6)




# #------------------------SHOP-DONE------------------



#stock9= {
#    product_id: p7.id ,
#    shop_id: s7.id ,
#    quantity: 10,
#    price: 1.2,
#}

#stock10= {
#    product_id: p7.id ,
#    shop_id: s8.id ,
#    quantity: 3,
#    price: 1.8,
#}

#stock11= {
#    product_id: p8.id ,
#    shop_id: s7.id ,
#    quantity: 20,
#    price: 0.7,
#}

#stock12= {
#    product_id: p8.id ,
 #   shop_id: s8.id ,
#    quantity: 5,
#    price: 1.5,
#}

#stock13= {
#    product_id: p9.id ,
#    shop_id: s7.id ,
#    quantity: 30,
 #   price: 0.6,
#}

#stock14= {
 #   product_id: p9.id ,
 #   shop_id: s8.id ,
 #   quantity: 3,
#    price: 1.4,
#}


# puts "Shops created ok"
# puts "Product construction start !"


# ####################PRODUCT-CREATION##################



# product1 = {
#     name: "Pizza",
#     brand: "Nico",
#     description: "La meilleure des Pizzas"

#   }
# product2 = {
#     name: "Sandwich Thon-mayo",
#     brand: "Sodebo",
#     description: "Un bon Sandwich dans du plastique"

#   }
# product3 = {
#     name: "Kebab",
#     brand: "De chez baraka",
#     description: "STO F MK"

#   }
# product4 = {
#     name: "Barre aux protéines",
#     brand: "Grany",
#     description: "C'est du bon pour les muscles"

#   }
# product5 = {
#     name: "Chicken Poulet du marché",
#     brand: "Chez robert",
#     description: "Bien grillé avec des patates"
#   }


#st6 = Stock.create!(stock6)
#st7 = Stock.create!(stock7)
#st8 = Stock.create!(stock8)
#st9 = Stock.create!(stock9)
#st10 = Stock.create!(stock10)
#st11 = Stock.create!(stock11)
#st12 = Stock.create!(stock12)
#st13 = Stock.create!(stock13)
#st14 = Stock.create!(stock14)
#puts "Stocks created ok !"
#puts "Tags creation start !"


# product6 = {
#     name: "Pizza",
#     brand: "Bob",
#     description: "La pire des Pizzas"

#   }


# p1 = Product.create!(product1)
# p2 = Product.create!(product2)
# p3 = Product.create!(product3)
# p4 = Product.create!(product4)
# p5 = Product.create!(product5)

# p6 = Product.create!(product6)




# #-----------------------PRODUCT-DONE------------------

# puts "Product created ok"
# puts "stocks creation start !"

# ########################STOCK-CREATION####################



#tag1 = Tag.create!(label: "fast food")
#tag2 = Tag.create!(label: "sportive")
#tag3 = Tag.create!(label: "healthy")
#tag4 = Tag.create!(label: "amateur")
#tag5 = Tag.create!(label: "expert")

# stock1 = {
#     product_id: p1.id ,
#     shop_id: s1.id ,
#     quantity: 10 ,
#     price: 12,
# }
# stock2 = {
#     product_id: p2.id ,
#     shop_id: s2.id ,
#     quantity: 15 ,
#     price: 8,
# }
# stock3 = {
#     product_id: p3.id ,
#     shop_id: s3.id ,
#     quantity: 30 ,
#     price: 5,
# }
# stock4 = {
#     product_id: p4.id ,
#     shop_id: s4.id ,
#     quantity: 100 ,
#     price: 12,
# }
# stock5 = {
#     product_id: p5.id ,
#     shop_id: s5.id ,
#     quantity: 5 ,
#     price: 8,
# }


# stock6= {
#     product_id: p1.id ,
#     shop_id: s2.id ,
#     quantity: 2 ,
#     price: 18,
# }
# stock7= {
#     product_id: p1.id ,
#     shop_id: s4.id ,
#     quantity: 1 ,
#     price: 36,
# }
# stock8= {
#     product_id: p6.id ,
#     shop_id: s6.id ,
#     quantity: 3,
#     price: 72,
# }




#puts "Tags created ok"
#puts " Produt tags creation start !"

##########################PRODUCT-TAD-CREATION##############
##


#product_tags = [{
#    tag_id: tag1.id ,
#    product_id: p1.id ,
#}, {
#    tag_id: tag1.id ,
#    product_id: p2.id ,
#}, {
#    tag_id: tag1.id ,
#    product_id: p3.id ,
#}, {
#    tag_id: tag2.id ,
#    product_id: p4.id ,
#}, {
#    tag_id: tag3.id ,
#    product_id: p5.id ,
#}, {
#    tag_id: tag5.id ,
#    product_id: p7.id ,
#}, {
#    tag_id: tag5.id ,
#    product_id: p8.id ,
#}, {
 #   tag_id: tag4.id ,
#    product_id: p9.id ,
#}]

#ProductTag.create!(product_tags)



#--------------------------PRODUCT-TAD-END----------------

#puts "Product tag created ok"


#puts "Reviews creation start !"


# st1 = Stock.create!(stock1)
# st2 = Stock.create!(stock2)
# st3 = Stock.create!(stock3)
# st4 = Stock.create!(stock4)
# st5 = Stock.create!(stock5)

# st6 = Stock.create!(stock6)
# st7 = Stock.create!(stock7)
# st8 = Stock.create!(stock8)
# puts "Stocks created ok !"
# puts "Tags creation start !"

# tag1 = Tag.create!(label: "fast")
# tag2 = Tag.create!(label: "sport")
# tag3 = Tag.create!(label: "healthy")




# #--------------------------STOCK-DONE-----------------------

# puts "Stocks created ok !"
# puts "Tags creation start !"

# ############################TAG-CREATION######################



# tags = [label: "pizza", label: "Sandwich", label: "kebab", label: "barre", label: "poulet"]
# tag1 = Tag.create!(tags[0])
# tag2 = Tag.create!(tags[1])
# tag3 = Tag.create!(tags[2])
# tag4 = Tag.create!(tags[3])
# tag5 = Tag.create!(tags[4])



# #--------------------------TAG-DONE---------------------


# puts "Tags created ok"
# puts " Produt tags creation start !"

# ##########################PRODUCT-TAD-CREATION##############



# product_tags = [{
#     tag_id: tag1.id ,
#     product_id: p1.id ,
# }, {
#     tag_id: tag1.id ,
#     product_id: p2.id ,
# }, {
#     tag_id: tag1.id ,
#     product_id: p3.id ,
# }, {
#     tag_id: tag2.id ,
#     product_id: p4.id ,
# }, {
#     tag_id: tag3.id ,
#     product_id: p5.id ,
# }]

# ProductTag.create!(product_tags)



# #--------------------------PRODUCT-TAD-END----------------

# puts "Product tag created ok"


# puts "Reviews creation start !"

# ############################REVIEWS-CREATION##############



# reviews = [{
#     comment: "C'est vraiment très bon !",
#     rating: 0 ,
#     user_id: u.id,
#     stock_id: st1.id
# },{
#     comment: "Même ma mamie est aussi bonne ! gg",
#     rating: 5,
#     user_id: u.id,
#     stock_id: st1.id
# },{
#     comment: "C'était périmé..",
#     rating: 1,
#     user_id: u.id,
#     stock_id: st2.id
# },{
#     comment: "Le vendeur est gentil..",
#     rating: 3,
#     user_id: u.id,
#     stock_id: st3.id
# }]

# Review.create!(reviews)



# #---------------------------REVIEWS-END---------------

# puts "Reviews creation done !"

# puts "Time tables creation start !"

# #############################TIME-TABLE-CREATION#########



# time_table = [{       #day_of_weed : 0 : Dimanche, 1 : Lundi ..... Samedi : 6 #
#     opened_at: 8 ,
#     closed_at: 19 ,
#     day_of_week: 1,  #day_of_week : 1 => lundi
#     shop_id: s1.id
# },{
#     opened_at: 8 ,
#     closed_at: 19,
#     day_of_week: 2,  #day_of_week : 2 => mardi
#     shop_id: s1.id
# },{
#     opened_at: 8 ,
#     closed_at: 19 ,
#     day_of_week: 3 ,  #day_of_week : 3 => mercredi
#     shop_id: s1.id
# },{
#     opened_at: 8 ,
#     closed_at: 19 ,
#     day_of_week: 4 ,  #day_of_week : 4 => jeudi
#     shop_id: s1.id
# },{
#     opened_at: 8 ,
#     closed_at: 19 ,
#     day_of_week: 5 ,  #day_of_week : 5 => vendredi
#     shop_id: s1.id
# },{
#     opened_at: 8 ,
#     closed_at: 19 ,
#     day_of_week: 6 ,  #day_of_week : 6 => samedi
#     shop_id: s1.id
# }]

# file7 = URI.open('https://media.castorama.fr/is/image/Castorama/NPC_HT_1806_choisir_vis_2?wid=720&$jpgp$')

# p7.photo.attach(io: file7, filename: 'poulet.png', content_type: 'image/png')
# puts "Image7 loaded OK"

# file8 = URI.open('https://cdn.quincaillerie.pro/images/c94fdd8bf3df64a84b8d/0/0/P106254.png')

# p8.photo.attach(io: file8, filename: 'poulet.png', content_type: 'image/png')
# puts "Image8 loaded OK"

# file9 = URI.open('https://www.bricodepot.fr/images/page_prod_big/105000/105179.jpg')

# p9.photo.attach(io: file9, filename: 'poulet.png', content_type: 'image/png')
# puts "Image9 loaded OK"


# time_table2 = [{
#     opened_at: 7,
#     closed_at: 18 ,
#     day_of_week: 2 ,
#     shop_id: s2.id ,
# },{
#     opened_at: 8 ,
#     closed_at: 16 ,
#     day_of_week: 3 ,
#     shop_id: s2.id ,
# },{
#     opened_at: 8 ,
#     closed_at: 16 ,
#     day_of_week: 4 ,
#     shop_id: s2.id ,
# },{
#     opened_at: 5 ,
#     closed_at: 16 ,
#     day_of_week: 5 ,
#     shop_id: s2.id ,
# }]

# TimeTable.create(time_table2)
# TimeTable.create!(time_table)



# #---------------------------TIME-TABLE-END--------------


# puts "Load image"


# file1 = URI.open('https://fotomelia.com/wp-content/uploads/2018/01/fotomelia-images-gratuites-38-1560x1041.jpg')

# p1.photo.attach(io: file1, filename: 'pizza.png', content_type: 'image/png')
# puts "Image1 loaded OK"

# file2 = URI.open('https://cdn.pixabay.com/photo/2015/08/16/12/02/sandwich-890822_960_720.jpg')

# p2.photo.attach(io: file2, filename: 'sandwich.png', content_type: 'image/png')
# puts "Image2 loaded OK"

# file3 = URI.open('https://fotomelia.com/wp-content/uploads/2017/03/base-d-images-gratuites-20-1560x1040.jpg')

# p3.photo.attach(io: file3, filename: 'kebab.png', content_type: 'image/png')
# puts "Image3 loaded OK"

# file4 = URI.open('https://s1.thcdn.com/productimg/960/960/10979946-1904620647515953.jpg')

# p4.photo.attach(io: file4, filename: 'barreprot.png', content_type: 'image/png')
# puts "Image4 loaded OK"

# file5 = URI.open('https://fotomelia.com/wp-content/uploads/edd/2015/12/banque-d-images-et-photos-gratuites-libres-de-droits-t%C3%A9l%C3%A9chargement-gratuits20-1560x1170.jpg')

# p5.photo.attach(io: file5, filename: 'poulet.png', content_type: 'image/png')
# puts "Image5 loaded OK"

# file6 = URI.open('https://fotomelia.com/wp-content/uploads/edd/2015/12/banque-d-images-et-photos-gratuites-libres-de-droits-t%C3%A9l%C3%A9chargement-gratuits20-1560x1170.jpg')

# p6.photo.attach(io: file6, filename: 'poulet.png', content_type: 'image/png')
# puts "Image6 loaded OK"

# file = URI.open('https://static.openfoodfacts.org/images/products/762/221/044/9283/front_fr.286.400.jpg')
# article = Product.new(name: 'NES', description: "A great console")
# article.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
# article.save
# puts "its good"

#------------------------Scraping shops (raté) ----------------------------

# url = "https://www.larondedesquartiers.com/annuaire-des-commerces/"

# html_file = open(url).read
# html_doc = Nokogiri::HTML(html_file)
# html_doc.search('.location .clearfix .mapDescription').each do |element|
#   p element.text.strip
#   puts "scrapping done"
# end

#-------------------------------------------------------------------
# Faker::Config.locale = 'fr'
# paul = Faker::Restaurant.type
#  puts paul
