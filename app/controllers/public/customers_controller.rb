class Public::CustomersController < ApplicationController

  def show

  end

  def edit

  end

  def update

  end

  def unsubscribe
    @customer = Customer.find_by(email: params[:email])
  end

  def withdraw
    @customer = Customer.find_by(email: params[:email])
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

end
