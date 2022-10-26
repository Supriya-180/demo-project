ActiveAdmin.register Order do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :user_id, :total_price, :total_quantity, :address_id, :razorpay_order_id, :razorpay_payment_id, :status
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :total_price, :total_quantity, :address_id, :razorpay_order_id, :razorpay_payment_id, :status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
 
    actions :all, :except => [:destroy, :new]


  permit_params :user_id, :total_price, :total_quantity, :razorpay_order_id, :razorpay_payment_id, :status, address:[:id,:_destroy]

  show do
    attributes_table do
      row :total_price
      row :total_quantity
      row :address_id
      row :razorpay_order_id
      row :razorpay_payment_id
      row :status

      # row :image do |ad|
      #   image_tag url_for(ad&.order_items.product.image) if ad&.order_items.product.image.present?
      # end
    end
  end

  form do |f|
    f.inputs do
      
      f.input :status
      
    end
    f.actions
  end
  

end