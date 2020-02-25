require "open-uri"

puts "Destruction : start"
puts "3"
puts "2"
puts "1"
puts "Boom!"
Stock.destroy_all
Shop.destroy_all
puts "Shops destroyed!"
Product.destroy_all

puts "Products destroyed!"
Tag.destroy_all
ProductTag.destroy_all
puts "Tags destroyed!"
User.destroy_all
puts "Users destroyed!"
puts "User construction start !"
user = {email: "dezanneaucharlotte@gmail.com", password:"charlotte"}
u = User.create!(user)
puts "User created ok"
puts "Shop construction start !"
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
puts "Shops created ok"
puts "Product construction start !"
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
puts "Product created ok"
puts "stocks creation start !"
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
puts "Stocks created ok !"
puts "Tags creation start !"
tags = [label: "pizza", label: "Sandwich", label: "kebab", label: "barre", label: "poulet"]
tag1 = Tag.create!(tags[0])
tag2 = Tag.create!(tags[1])
tag3 = Tag.create!(tags[2])
tag4 = Tag.create!(tags[3])
tag5 = Tag.create!(tags[4])
puts "Tags created ok"
puts " Produt tags creation start !"
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
puts "Product tag created ok"

puts "Load image"

file = URI.open('https://giantbomb1.cbsistatic.com/uploads/original/9/99864/2419866-nes_console_set.png')
puts file
p1.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
puts "Image loaded OK"

puts "SEED DONE :D"





