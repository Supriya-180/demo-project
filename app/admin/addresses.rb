ActiveAdmin.register Address do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :user_id, :pin_Code, :flat_no, :colony, :landmark, :city
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :pin_Code, :flat_no, :colony, :landmark, :city]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  
  menu false
end
