require 'mercadopago'

class CartsController < ApplicationController
  before_action :set_cart, only: %i[ show edit update destroy ]
  # GET /carts or /carts.json
  def index
    @carts = Cart.all
  end

  # GET /carts/1 or /carts/1.json
  def show
    sdk = Mercadopago::SDK.new(ENV["MERCADOPAGO_KEY"])

    preference_data = {}
    items = []

    @cart.items.each do |item|
      items.push({
                   title: item.title,
                   unit_price: item.price,
                   quantity: 1
                 })
    end

    preference_data["items"] = items
    preference_data["back_urls"] = {
      success: request.protocol + request.host_with_port + pay_cart_path,
      failure: request.protocol + request.host_with_port + cart_path(@cart),
      pending: request.protocol + request.host_with_port + cart_path(@cart)
    }
    preference_data["auto_return"] = "approved"
    preference_response = sdk.preference.create(preference_data)
    preference = preference_response[:response]

    puts 'Response status = ' + preference.to_s

    @preference_id = preference['id']

  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts or /carts.json
  def create
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to cart_url(@cart), notice: "Cart was successfully created." }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carts/1 or /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to cart_url(@cart), notice: "Cart was successfully updated." }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1 or /carts/1.json
  def destroy
    @cart.destroy

    respond_to do |format|
      format.html { redirect_to carts_url, notice: "Cart was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def add_item
    user = current_or_guest_user
    cart = user.cart
    item = Item.find(params[:item_id])
    same_items_already_added = cart.items.where(id: item.id)
    if (item.stock - same_items_already_added.count > 0)
      cart.items << item
      cart.save
      respond_to do |format|
        format.html
        format.js
      end
    else
      redirect_to root_path, notice: 'You have all stock available in your cart'
    end
  end

  def delete_item
    cart = current_user.cart
    item = Item.find(params[:item_id])
    same_items_already_added = cart.items.where(id: item.id).count
    cart.items.delete(item)
    (1..same_items_already_added-1).each { cart.items << item }
    cart.save
    redirect_to cart, notice: 'Item removed from cart.'
  end

  def pay_cart
    cart = current_user.cart
    total_to_pay = cart.items&.sum(:price)
    errors = []
    cart.items&.order("id ASC")&.each do |item|
      if item.stock < 1
        errors << '-Sorry item <b>' + item.title + '</b> was buyed and out of stock. <br>'
      end
    end
    errors << '<b class="text-danger"> Please remove items out of stock to proceed with the buy </b>' if errors.any?
    redirect_to cart, notice: errors.to_sentence(two_words_connector: '') and return if errors.any?

    #Disabled for card payments
    # redirect_to cart, notice: 'You dont have enough balance.' and return if total_to_pay > current_user.balance
    # current_user.balance = current_user.balance - total_to_pay

    # Pass the item information to buyer and save the sale to seller
    last_item = 0
    stock_to_discount = 1
    cart.items&.order("id ASC")&.each do |item|
      if(last_item == item.id)
        stock_to_discount += 1
      else
        stock_to_discount = 1
      end
      if (item.stock - stock_to_discount >= 0)
        item.update(stock: item.stock - stock_to_discount)
        seller = User.find(item.user.id)
        sold_item = item.dup
        sold_item.sold = true
        sold_item.stock = nil
        current_user.items << sold_item
        current_user.save
        sale = Sale.new(user: seller, item: sold_item, app_fee: (sold_item.price * $app_fee))
        if sale.save!
          seller.balance += sold_item.price - (sold_item.price * $app_fee)
          seller.save!
          admin = User.find_by_email('admin@mail.com')
          admin.balance += (sold_item.price * $app_fee)
          admin.save!
          cart.items.delete(item)
          cart.save
        end
      else
      end
      last_item = item.id
    end
    redirect_to root_path, notice: 'Payment succesfully, items added to your library'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cart_params
      params.require(:cart).permit(:user_id)
    end
end
