require "open-uri"

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

shop7 = {
  name: "Leroy Merlin",
  user_id: u.id ,
  address: "3 Rue Dumont d'Urville, 33300 Bordeaux",
  category: "Bricolage grande surface"
}

shop8 = {
  name: "Bricorelais",
  user_id: u.id ,
  address: "115 Cours Victor Hugo, 33000 Bordeaux",
  category: "Bricolage"
}

s1 = Shop.create!(shop1)
s2 = Shop.create!(shop2)
s3 = Shop.create!(shop3)
s4 = Shop.create!(shop4)
s5 = Shop.create!(shop5)
s6 = Shop.create!(shop6)
s7 = Shop.create!(shop7)
s8 = Shop.create!(shop8)




#------------------------SHOP-DONE------------------


puts "Shops created ok"
puts "Product construction start !"

####################PRODUCT-CREATION##################



product1 = {
    name: "Pizza Nico",
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
    name: "Pizza Hut",
    brand: "Bob",
    description: "La pire des Pizzas"

  }

  product7 = {
    name: "VIS METAUX TETE FRAISEE BOMBEE TFB POZI 6X50 ALUMINIUM",
    brand: "VIS EXPRESS",
    description: "Diametre=6, Matiere=Aluminium, Norme=DIN 966"

  }

  product8 = {
    name: "VIS POUR BOIS ET AGGLOMERE TETE RONDE ",
    brand: "VIS EXPRESS",
    description: "TR POZI 2 4X80 FILETEE SUR 48 ACIER ZING BLANC"

  }

  product9 = {
    name: "VBA/VIS POUR BOIS ET AGGLOMERE TETE RONDE",
    brand: "LEGRAND",
    description: "TR POZI 3 6X35 ACIER ZINGUE NOIR"

  }


p1 = Product.create!(product1)
p2 = Product.create!(product2)
p3 = Product.create!(product3)
p4 = Product.create!(product4)
p5 = Product.create!(product5)

p6 = Product.create!(product6)

p7 = Product.create!(product7)
p8 = Product.create!(product8)
p9 = Product.create!(product9)




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

stock9= {
    product_id: p7.id ,
    shop_id: s7.id ,
    quantity: 10,
    price: 1.2,
}

stock10= {
    product_id: p7.id ,
    shop_id: s8.id ,
    quantity: 3,
    price: 1.8,
}

stock11= {
    product_id: p8.id ,
    shop_id: s7.id ,
    quantity: 20,
    price: 0.7,
}

stock12= {
    product_id: p8.id ,
    shop_id: s8.id ,
    quantity: 5,
    price: 1.5,
}

stock13= {
    product_id: p9.id ,
    shop_id: s7.id ,
    quantity: 30,
    price: 0.6,
}

stock14= {
    product_id: p9.id ,
    shop_id: s8.id ,
    quantity: 3,
    price: 1.4,
}



st1 = Stock.create!(stock1)
st2 = Stock.create!(stock2)
st3 = Stock.create!(stock3)
st4 = Stock.create!(stock4)
st5 = Stock.create!(stock5)

st6 = Stock.create!(stock6)
st7 = Stock.create!(stock7)
st8 = Stock.create!(stock8)
st9 = Stock.create!(stock9)
st10 = Stock.create!(stock10)
st11 = Stock.create!(stock11)
st12 = Stock.create!(stock12)
st13 = Stock.create!(stock13)
st14 = Stock.create!(stock14)
puts "Stocks created ok !"
puts "Tags creation start !"



#--------------------------STOCK-DONE-----------------------

puts "Stocks created ok !"
puts "Tags creation start !"

############################TAG-CREATION######################



tag1 = Tag.create!(label: "fast food")
tag2 = Tag.create!(label: "sportive")
tag3 = Tag.create!(label: "healthy")
tag4 = Tag.create!(label: "amateur")
tag5 = Tag.create!(label: "expert")



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
}, {
    tag_id: tag5.id ,
    product_id: p7.id ,
}, {
    tag_id: tag5.id ,
    product_id: p8.id ,
}, {
    tag_id: tag4.id ,
    product_id: p9.id ,
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

file7 = URI.open('https://media.castorama.fr/is/image/Castorama/NPC_HT_1806_choisir_vis_2?wid=720&$jpgp$')

p7.photo.attach(io: file7, filename: 'poulet.png', content_type: 'image/png')
puts "Image7 loaded OK"

file8 = URI.open('https://cdn.quincaillerie.pro/images/c94fdd8bf3df64a84b8d/0/0/P106254.png')

p8.photo.attach(io: file8, filename: 'poulet.png', content_type: 'image/png')
puts "Image8 loaded OK"

file9 = URI.open('https://www.bricodepot.fr/images/page_prod_big/105000/105179.jpg')

p9.photo.attach(io: file9, filename: 'poulet.png', content_type: 'image/png')
puts "Image9 loaded OK"



puts "SEED DONE :D"





