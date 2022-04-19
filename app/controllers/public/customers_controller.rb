class Public::CustomersController < ApplicationController

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:notice] = "会員情報の編集に成功しました。"
      redirect_to my_page_path
    else
      render :edit
    end
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
  
  private
  
  def customer_params
    params.require(:customer).permit(:last_name,
                                     :first_name,
                                     :last_name_kana,
                                     :first_name_kana,
                                     :email,
                                     :encrypted_password,
                                     :postal_code,
                                     :address,
                                     :telephone_number,
                                     :is_deleted)
  end

end
