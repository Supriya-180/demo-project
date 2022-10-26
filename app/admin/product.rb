ActiveAdmin.register Product do
    #-->(belongs to) 
    belongs_to :category, optional: true

    #-->(namespace) 
    # ActiveAdmin.register Product, namespace: :today

    # scope_to :name
    # includes :categories

    #-->(menu)
    menu priority: 1
    # menu if: proc{ current_user.can_edit_products? }
    # menu parent: ["Admin", "Blog"]

    #-->(change lable)
    menu label: "My Products"

    #-->(create another record)
    config.create_another = true
  
    permit_params :name, :price, :category_id, :manufacturing_date, :image, 
            product_variants_attributes: [:id, :variant_id, :variant_attribute_id, :_destroy]  
 
    #-->(add filter on name)
    filter :name
    # filter :category, as: :check_boxes,collection: Category.all 

    #-->
    # config.sort_order = 'id_asc'

    #-->
    # config.per_page = [5, 10, 12]

  #-->(index page)
  index do

    selectable_column
    id_column
    column :name
    column :category do |p|
      p&.category&.name 
    end
    column :price
    column :image do |obj|
      image_tag url_for(obj.image) if obj.image.present?
    end
    actions defaults: false do |object|
      link_to "showimport", showimport_admin_product_path(object)
    end
    actions defaults: false do |obj|
      link_to "update", category_u_admin_product_path(obj)
    end

    actions
  end

  #-->(multiple index pages)
  index as: :grid do |product|
    a href: admin_product_path(product) do
        div product.name
        div product.price
    end
  end

 
  #-->(normal form)
  # form do |f|
  #   f.inputs do
  #     f.input :category, prompt: "categories" 
  #     f.input :name
  #     f.input :price
    
  #   end
  #   f.actions
  # end


  # -->(form with extra details)
  form name: 'A custom name' do |f|
    tabs do
      tab 'Basic' do
        inputs 'Details' do
          input :name
          input :price, label: "Price of product"
          input :category, prompt: "categories"
          input :manufacturing_date, as: :datepicker,datepicker_options: { min_date: "2013-10-8", max_date: "+3D" }
          input :image , as: :file
          
          has_many :product_variants, heading: 'product_variants', new_record: "Add New", allow_destroy: true do |a|
            a.inputs do
              a.input :variant, :input_html => { :class => 'variant_select'}
              a.input :variant_attribute, :input_html => {:class => 'variantP'}

              # has_many :variant_attributes, heading: 'variant_attributes', new_record: "Add New", allow_destroy: true do |b|
              #   a.inputs do
              #     b.input :variant_attributes, prompt: "variant_attribute_id"
              #   end
              # end

            end
          end
          
        end
      end
    end
    # panel 'Markup' do
    #   "The following can be used in the content below..."
    # end
    # inputs 'Content', :price
    # para "Press cancel to return to the list without saving."
    actions
  end


  #-->(show page)
  # show do
  #   h3 product.name
  #   # render 'admin/products/form', { product: product }

  #   div do
  #     h1 product.price
  #   end


  # end


  #-->(show page with attributes)
  show do
    attributes_table do
      row :name
      row :price
      row :manufacturing_date
      row :image do |ad|
        image_tag url_for(ad&.image) if ad&.image.present?
      end
      columns do
      column do
        panel 'product_variants' do
          attributes_table_for product&.product_variants do 
            row :variant do |pv|
              Variant.find_by_id(pv.variant_id).name
            end
            row :variant_attribute do |pv|
              VariantAttribute.find_by_id(pv.variant_attribute_id).name
            end

          end
        end
      end
    end
    end
  end


  #  show do
  #   div do
  #     h3 'Some custom charts about this object'
  #     render partial: 'admin/products/form'
  #   end
  #   default_main_content
  #  end
  #  sidebar "Details", only: :show do
  #   attributes_table_for product do
  #     row :name
  #   end
  # end


  #-->
  controller do
    # def scoped_collection
    #   end_of_association_chain.where("price <= ?",1000)
    # end

    def csv_filename
      'Custom name for csv file.csv'
    end

    # def showimport
    #   @product = Product.find(params[:id])
    # end

    def import
      @product = Product.find(params[:id])
      redirect_to showimport_admin_product_path(@product), :notice=>'Imported'
    end

    # def updatte
    #   render "admin/products/updatte"
    # end


  end

  #-->(partial form)
  # form partial: 'admin/products/form'

  # #-->(csv file)
  # csv force_quotes: true, col_sep: ';', column_names: true do
  #   column (:name ){ |product| product.name}
  #   column(:price) { |product| product.price }
  #   column(:manufacturing_date) { |product| product.manufacturing_date }
  #   column(:image) { |product| product.image }
  # end


  # #-->(collection action)
  # collection_action :import_csv, method: :post do
  #   # Do some CSV importing work here...
  #   redirect_to collection_path, notice: "CSV imported successfully!"
  # end


  # -->(member action)
  member_action :showimport, :method=>:get do
    # redirect_to admin_product_path, notice: "here is product!"
    render "admin/products/showimport"
  end
  # member_action :import, :method=>:post do
    
  # end


  # -->(action items)
  # config.remove_action_item :new

  # action_item :new, only: :show do
  #   link_to 'custom newwwwwwww', new_admin_product_path(is_admin: true)
  # end

  # -->(rendering)
  member_action :category_u do
    @category_u = resource.category
  end

 
  

  # batch_action :flag do |ids|
  #   batch_action_collection.find(ids).each do |post|
  #     post.flag! :hot
  #   end
  #   redirect_to collection_path, alert: "The posts have been flagged."
  # end



  # batch_action :destroy do |ids|
  #   redirect_to collection_path, alert: "Didn't really delete these!"
  # end


    # batch_action :destroy, false


# batch_action :delete, form: {
#   type: %w[Offensive Spam Other],
#   reason: :text,
#   notes:  :textarea,
#   hide:   :checkbox,
#   date:   :datepicker
# } do |ids, inputs|
#   # inputs is a hash of all the form fields you requested
#   redirect_to collection_path, notice: [ids, inputs].to_s
# end

batch_action :delete, form: {name: [['ssdf',4], ['Mary',3]]} do |ids, inputs|
  Product.find(inputs[:name])
end

batch_action :publish do |ids|
    Product.where(id: ids).update(price: 100, )
end

# batch_action :update do |ids|
#   redirect_to edit_admin_product_path
#     # Product.where(id: ids).update(name: )
# end

# batch_action_collection.find(ids).each do |user|
#     redirect_to edit_admin_product_path
#     # Product.where(id: ids).update(name: )
# end

batch_action :update do |ids|
  # Product.where(:id ids).each do |user|
    # user.update
  # end
end

end




