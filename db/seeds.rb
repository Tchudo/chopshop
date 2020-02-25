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
    address: "134 cours balguerie stuttenberg",
    category: "Pizzeria"
  }
shop2 = {
    name: "Chez paul",
    user_id: u.id ,
    address: "51 cours du medoc",
    category: "Boulangerie"
  }
shop3 = {
    name: "Le baraka",
    user_id: u.id ,
    address: "4 cours balguerie stuttenberg",
    category: "Kebab"
  }
shop4 = {
    name: "Makadam Fitness",
    user_id: u.id ,
    address: "113 cours balguerie stuttenberg",
    category: "Pour les biscotos"
  }
shop5 = {
    name: "La rotisserie",
    user_id: u.id ,
    address: "place saint martial",
    category: "Des gros cochons"
  }

s1 = Shop.create!(shop1)
s2 = Shop.create!(shop2)
s3 = Shop.create!(shop3)
s4 = Shop.create!(shop4)
s5 = Shop.create!(shop5)



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
    name: "Poulet du marché",
    brand: "Chez robert",
    description: "Bien grillé avec des patates"
  }

p1 = Product.create!(product1)
p2 = Product.create!(product2)
p3 = Product.create!(product3)
p4 = Product.create!(product4)
p5 = Product.create!(product5)



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

st1 = Stock.create!(stock1)
st2 = Stock.create!(stock2)
st3 = Stock.create!(stock3)
st4 = Stock.create!(stock4)
st5 = Stock.create!(stock5)



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
    tag_id: tag2.id ,
    product_id: p2.id ,
}, {
    tag_id: tag3.id ,
    product_id: p3.id ,
}, {
    tag_id: tag4.id ,
    product_id: p4.id ,
}, {
    tag_id: tag5.id ,
    product_id: p5.id ,
}]

ProductTag.create!(product_tags)



#--------------------------PRODUCT-TAD-END----------------

puts "Product tag created ok"

puts "Reviews creation start !"

############################REVIEWS-CREATION##############



reviews = [{
    comment: "C'est vraiment très bon !",
    rating: 4,
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



time_table = {
    opened_at: 8 ,
    closed_at: 19 ,
    day_of_week: 6 ,
    shop_id: s1.id
}

TimeTable.create!(time_table)



#---------------------------TIME-TABLE-END--------------

puts "SEED DONE :D"





