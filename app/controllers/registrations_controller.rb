class RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    if resource_name == :seller
      params.require(:seller).permit(:name, :phone, :email, :password, :password_confirmation)
    else
      params.require(:buyer).permit(:name, :address, :email, :password, :password_confirmation)
    end
  end

  def account_update_params
    if resource_name == :seller
      params.require(:seller).permit(:name, :phone, :email, :password, :password_confirmation, :current_password)
    else
      params.require(:buyer).permit(:name, :address, :email, :password, :password_confirmation, :current_password)
    end
  end
end
