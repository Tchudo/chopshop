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
puts "Tags created ok"
puts " Produt tags creation start !"
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
puts "Product tag created ok"

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


puts "SEED DONE :D"





