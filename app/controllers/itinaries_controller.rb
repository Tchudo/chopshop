class ItinariesController < ApplicationController
  def index
    @baskets = Basket.all
    flex = []
    fix = []
    shop_fix_ids = []
    shop_flex_ids = {}
    @final_stocks = []
    # Séparer les produits fix et les produits flex
    @baskets.each do |basket|
      if basket.search_by_category == true
        fix << basket.stock
      else
        flex << basket.stock
      end
    end

    if fix.present? && flex.present?
      # Récupérer tous les stocks fix
      fix.each do |stock_fix|
      # Récupérer les shops associés à ces stocks fix
        shop_id = stock_fix.shop.id
        shop_fix_ids << shop_id
      end
      # Vérifier pour chaque produit flex s'il est disponible dans un des magasins précédent
        # Récupéré les stocks flex
      flex.each do |stock_flex|

        # Récupéré les produits associés à ces stocks
        product = stock_flex.product

        # Consulter les shops qui vendent ces produits
        shops = product.shops

        # Compare ces shops avec les shops des fix
        # Récupéré l'id de chaque shop
        shops.each do |shop|
          shop_id = shop.id
          # Vérifier pour chaque id s'il est inclut dans shop_fix_ids
          if shop_fix_ids.include?(shop_id)
            # si il est inclut,
            stock = Stock.where(product_id: product.id, shop_id: shop_id)
            @final_stocks << stock
          else
            # si il n'est pas inclut,
            stock = stock_flex
            @final_stocks << stock
          end
        end
      end

    elsif fix.present? && flex.empty?
      fix.each do |stock|
        @final_stocks << stock
      end

    elsif fix.empty? && flex.present?
      # Récupéré pour chaque stock le produit associé
      num = 0
      flex.each do |stock|
        product = stock.product
        #  Récupéré les shops liés à ce produit
        shops = product.shops

        shop_flex_ids["shop#{num+=1}"] = shops.ids
        # {"shop1"=>[932, 853], "shop2"=>[864], "shop3"=>[860, 865, 876], "shop4"=>[876, 883]}
      end
      raise
        # Enregistrer tous les shop dans un tableau
      # Vérifier si ceratins shop sont identiques
    end
  end
end




# if flex.present? && fix.empty?
#       products = []
#       shops = []
#       flex.each do |stock|
#         products << stock.product
#         shops << stock.product.shops
#       end

#       # checker si l'ensemble des stock.product sont présent dans un seul shop
#       shops.each do |shop|
#         other_shops = shops.reject {|shop_now| shop_now == shop }
#         raise

#       end
#       # checker si deux stock.product sont ensemble dans le même shop
#       # sinon renvoyer l'ensemble des stock.shop dans product
#     elsif fix.present? && flex.empty?
#       fix.each do |stock|
#         final << stock.shop
#       end
#     end
