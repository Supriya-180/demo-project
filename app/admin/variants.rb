ActiveAdmin.register Variant do

  permit_params :name, variant_attributes_attributes: [:id, :name, :_destroy]

  member_action :get_variant_attributes, method: :get do 
    render json: {variant_attributes: resource.variant_attributes }
  end

  form do |f|
    f.semantic_errors *f.object.errors.attribute_names
    f.inputs do
      f.input :name
      f.has_many :variant_attributes, heading: 'variant_attributes', new_record: "Add New", allow_destroy: true do |a|
        a.inputs do
          a.input :name
        end
      end
    end
    f.actions
  end




show do
  h1 variant.name
  attributes_table  do
    row :name
    columns do
      column do
        panel 'variant_attributes' do
          attributes_table_for variant&.variant_attributes do 
            row :name
          end
        end
      end
    end
  end
end
  





end
