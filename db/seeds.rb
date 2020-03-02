require "open-uri"
require 'openfoodfacts'

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



#---------------------------DESTRUCTION-DONE-------------------

puts "User construction start !"

#############################USER-CREATION########################



user = {email: "dezanneaucharlotte@gmail.com", password:"charlotte"}
u = User.create!(user)



#-----------------------------USER-DONE---------------------------

puts "User created ok"
puts "Shop construction start !"

############################SHOP-CREATION#######################



shop1 = {
    name: "Pizza Nico",
    user_id: u.id ,
    address: "134 Cours Balguerie Stuttenberg, 33300 Bordeaux",
    category: "Pizzeria"
  }
shop2 = {
    name: "Chez paul",
    user_id: u.id ,
    address: "51 cours du medoc, 33300 Bordeaux",
    category: "Boulangerie"
  }
shop3 = {
    name: "Le baraka",
    user_id: u.id ,
    address: "4 Cours Balguerie Stuttenberg, 33300 Bordeaux",
    category: "Kebab"
  }
shop4 = {
    name: "Makadam Fitness",
    user_id: u.id ,
    address: "90 Cours Balguerie Stuttenberg, 33300 Bordeaux",
    category: "Pour les biscotos"
  }
shop5 = {
    name: "La rotisserie",
    user_id: u.id ,
    address: "place saint martial, 33300 Bordeaux",
    category: "Des gros cochons"
  }

shop6 = {
  name: "Le Kiosque à Pizzas",
  user_id: u.id ,
  address: "453bis Cours de la Libération, 33400 Talence",
  category: "Pizzeria"
}

s1 = Shop.create!(shop1)
s2 = Shop.create!(shop2)
s3 = Shop.create!(shop3)
s4 = Shop.create!(shop4)
s5 = Shop.create!(shop5)

s6 = Shop.create!(shop6)




#------------------------SHOP-DONE------------------


puts "Shops created ok"
puts "Product construction start !"

####################PRODUCT-CREATION##################



product1 = {
    name: "Pizza",
    brand: "Nico",
    description: "La meilleure des Pizzas"

  }
product2 = {
    name: "Sandwich Thon-mayo",
    brand: "Sodebo",
    description: "Un bon Sandwich dans du plastique"

  }
product3 = {
    name: "Kebab",
    brand: "De chez baraka",
    description: "STO F MK"

  }
product4 = {
    name: "Barre aux protéines",
    brand: "Grany",
    description: "C'est du bon pour les muscles"

  }
product5 = {
    name: "Chicken Poulet du marché",
    brand: "Chez robert",
    description: "Bien grillé avec des patates"
  }


product6 = {
    name: "Pizza",
    brand: "Bob",
    description: "La pire des Pizzas"

  }


p1 = Product.create!(product1)
p2 = Product.create!(product2)
p3 = Product.create!(product3)
p4 = Product.create!(product4)
p5 = Product.create!(product5)

p6 = Product.create!(product6)




#-----------------------PRODUCT-DONE------------------

puts "Product created ok"
puts "stocks creation start !"

########################STOCK-CREATION####################



stock1 = {
    product_id: p1.id ,
    shop_id: s1.id ,
    quantity: 10 ,
    price: 12,
}
stock2 = {
    product_id: p2.id ,
    shop_id: s2.id ,
    quantity: 15 ,
    price: 8,
}
stock3 = {
    product_id: p3.id ,
    shop_id: s3.id ,
    quantity: 30 ,
    price: 5,
}
stock4 = {
    product_id: p4.id ,
    shop_id: s4.id ,
    quantity: 100 ,
    price: 12,
}
stock5 = {
    product_id: p5.id ,
    shop_id: s5.id ,
    quantity: 5 ,
    price: 8,
}

stock6= {
    product_id: p1.id ,
    shop_id: s2.id ,
    quantity: 2 ,
    price: 18,
}
stock7= {
    product_id: p1.id ,
    shop_id: s4.id ,
    quantity: 1 ,
    price: 36,
}
stock8= {
    product_id: p6.id ,
    shop_id: s6.id ,
    quantity: 3,
    price: 72,
}



st1 = Stock.create!(stock1)
st2 = Stock.create!(stock2)
st3 = Stock.create!(stock3)
st4 = Stock.create!(stock4)
st5 = Stock.create!(stock5)

st6 = Stock.create!(stock6)
st7 = Stock.create!(stock7)
st8 = Stock.create!(stock8)
puts "Stocks created ok !"
puts "Tags creation start !"

tag1 = Tag.create!(label: "fast")
tag2 = Tag.create!(label: "sport")
tag3 = Tag.create!(label: "healthy")




#--------------------------STOCK-DONE-----------------------

puts "Stocks created ok !"
puts "Tags creation start !"

############################TAG-CREATION######################



tags = [label: "pizza", label: "Sandwich", label: "kebab", label: "barre", label: "poulet"]
tag1 = Tag.create!(tags[0])
tag2 = Tag.create!(tags[1])
tag3 = Tag.create!(tags[2])
tag4 = Tag.create!(tags[3])
tag5 = Tag.create!(tags[4])



#--------------------------TAG-DONE---------------------


puts "Tags created ok"
puts " Produt tags creation start !"

##########################PRODUCT-TAD-CREATION##############



product_tags = [{
    tag_id: tag1.id ,
    product_id: p1.id ,
}, {
    tag_id: tag1.id ,
    product_id: p2.id ,
}, {
    tag_id: tag1.id ,
    product_id: p3.id ,
}, {
    tag_id: tag2.id ,
    product_id: p4.id ,
}, {
    tag_id: tag3.id ,
    product_id: p5.id ,
}]

ProductTag.create!(product_tags)



#--------------------------PRODUCT-TAD-END----------------

puts "Product tag created ok"


puts "Reviews creation start !"

############################REVIEWS-CREATION##############



reviews = [{
    comment: "C'est vraiment très bon !",
    rating: 0 ,
    user_id: u.id,
    stock_id: st1.id
},{
    comment: "Même ma mamie est aussi bonne ! gg",
    rating: 5,
    user_id: u.id,
    stock_id: st1.id
},{
    comment: "C'était périmé..",
    rating: 1,
    user_id: u.id,
    stock_id: st2.id
},{
    comment: "Le vendeur est gentil..",
    rating: 3,
    user_id: u.id,
    stock_id: st3.id
}]

Review.create!(reviews)



#---------------------------REVIEWS-END---------------

puts "Reviews creation done !"

puts "Time tables creation start !"

#############################TIME-TABLE-CREATION#########



time_table = [{       #day_of_weed : 0 : Dimanche, 1 : Lundi ..... Samedi : 6 #
    opened_at: 8 ,
    closed_at: 19 ,
    day_of_week: 1,  #day_of_week : 1 => lundi
    shop_id: s1.id
},{
    opened_at: 8 ,
    closed_at: 19,
    day_of_week: 2,  #day_of_week : 2 => mardi
    shop_id: s1.id
},{
    opened_at: 8 ,
    closed_at: 19 ,
    day_of_week: 3 ,  #day_of_week : 3 => mercredi
    shop_id: s1.id
},{
    opened_at: 8 ,
    closed_at: 19 ,
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


time_table2 = [{
    opened_at: 7,
    closed_at: 18 ,
    day_of_week: 2 ,
    shop_id: s2.id ,
},{
    opened_at: 8 ,
    closed_at: 16 ,
    day_of_week: 3 ,
    shop_id: s2.id ,
},{
    opened_at: 8 ,
    closed_at: 16 ,
    day_of_week: 4 ,
    shop_id: s2.id ,
},{
    opened_at: 5 ,
    closed_at: 16 ,
    day_of_week: 5 ,
    shop_id: s2.id ,
}]

TimeTable.create(time_table2)
TimeTable.create!(time_table)



#---------------------------TIME-TABLE-END--------------


puts "Load image"


file1 = URI.open('https://fotomelia.com/wp-content/uploads/2018/01/fotomelia-images-gratuites-38-1560x1041.jpg')

p1.photo.attach(io: file1, filename: 'pizza.png', content_type: 'image/png')
puts "Image1 loaded OK"

file2 = URI.open('https://cdn.pixabay.com/photo/2015/08/16/12/02/sandwich-890822_960_720.jpg')

p2.photo.attach(io: file2, filename: 'sandwich.png', content_type: 'image/png')
puts "Image2 loaded OK"

file3 = URI.open('https://fotomelia.com/wp-content/uploads/2017/03/base-d-images-gratuites-20-1560x1040.jpg')

p3.photo.attach(io: file3, filename: 'kebab.png', content_type: 'image/png')
puts "Image3 loaded OK"

file4 = URI.open('https://s1.thcdn.com/productimg/960/960/10979946-1904620647515953.jpg')

p4.photo.attach(io: file4, filename: 'barreprot.png', content_type: 'image/png')
puts "Image4 loaded OK"

file5 = URI.open('https://fotomelia.com/wp-content/uploads/edd/2015/12/banque-d-images-et-photos-gratuites-libres-de-droits-t%C3%A9l%C3%A9chargement-gratuits20-1560x1170.jpg')

p5.photo.attach(io: file5, filename: 'poulet.png', content_type: 'image/png')
puts "Image5 loaded OK"

file6 = URI.open('https://fotomelia.com/wp-content/uploads/edd/2015/12/banque-d-images-et-photos-gratuites-libres-de-droits-t%C3%A9l%C3%A9chargement-gratuits20-1560x1170.jpg')

p6.photo.attach(io: file6, filename: 'poulet.png', content_type: 'image/png')
puts "Image6 loaded OK"

file = URI.open('https://static.openfoodfacts.org/images/products/762/221/044/9283/front_fr.286.400.jpg')
article = Product.new(name: 'NES', description: "A great console")
article.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
article.save
puts "its good"


# ---------------------- OPEN FOOD FACTS --------------------

product_names = ["Chocolat", "Biscuit", "Confiture"]

product_names.each do |product_name|
  products = Openfoodfacts::Product.search(product_name, locale: 'fr', page_size: 5)

  products.each do |product|
    my_product = Openfoodfacts::Product.get(product.code, locale: 'fr')
    my_new_product = Product.create!({
      name: my_product.product_name,
      description: my_product.ingredients_text_fr,
      product_sku: my_product.code,
      brand: my_product.brands
    })
    puts "#{my_new_product.name} has been created"
    file = URI.open(my_product.image_front_url)
  puts "Image loaded"

    my_new_product.photo.attach(io: file, filename: "#{product.code}.jpg", content_type: 'image/jpg')
    puts "Product save !"

  end
end











# my_product = products.first

# #p my_product

# the_product = Openfoodfacts::Product.get(my_product.code, locale: 'fr')

# puts "the product done"

# product7 = {
#     name: the_product.product_name,
#     description: the_product.ingredients_text_fr,
#     product_sku: the_product.code,
#     brand: the_product.brands
#   }

# p7 = Product.create!(product7)

puts "API good !"





#------------------------------------------------------------

puts "SEED DONE :D"





