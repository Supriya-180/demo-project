ActiveAdmin.register Category do
  # has_many :products
  sidebar "Project Details", only: [:show, :edit] do
    ul do

      li link_to "Products",    admin_category_products_path(resource)
      
    end
  end

  permit_params :name

  # index do
  #   selectable_column
  #   id_column
  #   column :name
  #   actions
  # end

  # filter :name
 

  form do |f|
    f.semantic_errors *f.object.errors.attribute_names
    f.inputs do
      f.input :name
      f.has_many :products, heading: 'Products', new_record: "Add New" do |a|
        a.inputs do
          a.input :name
          a.input :price
          a.input :manufacturing_date
        end
      end
    end
    f.actions
  end






end
