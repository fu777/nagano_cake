class Admin::CustomersController < ApplicationController
  
  def index
    @customers = Customer.all
    
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
    redirect_to edit_admin_customer_path
  end
  
  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to admin_customer_path
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
