class Public::AddressesController < ApplicationController

  before_action :authenticate_customer!, only: [:index, :show]

  def index
    @address = Address.new
    @addresses = current_customer.addresses
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @address = Address.new(address_params)
    @addresses = Address.all
    @address.customer = current_customer
    if @address.save
      flash[:notice] = "配送先を新規登録しました。"
      redirect_to addresses_path
    else
      render :index
    end
  end

  def update
    @address = Address.find(params[:id])
    @address.customer = current_customer
    if @address.update(address_params)
      flash[:notice] = "配送先をしました。"
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end

end
