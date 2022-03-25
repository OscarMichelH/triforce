class CartsController < ApplicationController
  before_action :set_cart, only: %i[ show edit update destroy ]

  # GET /carts or /carts.json
  def index
    @carts = Cart.all
  end

  # GET /carts/1 or /carts/1.json
  def show
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

  def add_book
    cart = current_user.cart
    book = Book.find(params[:book_id])
    cart.books << book
    cart.save
    redirect_to cart
  end

  def delete_book
    cart = current_user.cart
    book = Book.find(params[:book_id])
    cart.books.delete(book)
    cart.save
    redirect_to cart, notice: 'Book removed from cart.'
  end

  def pay_cart
    cart = current_user.cart
    total_to_pay = cart.books&.sum(:price)
    redirect_to cart, notice: 'You dont have enough balance.' if total_to_pay > current_user.balance
    current_user.balance = current_user.balance - total_to_pay
    cart.books&.each do |book|
      book.stock = book.stock - 1
      book.save
      book.price = nil
      book.stock = nil
      current_user.books << book.clone
      current_user.save
    end
    redirect_to root_path, notice: 'Payment succesfully, books added to your library'
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
