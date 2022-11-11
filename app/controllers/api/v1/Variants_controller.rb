module Api
  module V1
      class VariantsController < ApiController

          def create
            if current_user.user_type == "merchant"
              # byebug
                @variant = Variant.new(variant_params)
                @variant_attributes = @variant.variant_attributes
                if @variant.save
                  render json: {variant: @variant, variant_attribute: @variant_attributes, meta:{message: 'variant added'}}
                else 
                  render json: {meta:{message: 'variant not added'}}
                end
            else
              render json: {meta: {message: 'not authorised'}}
            end
          end

          private
          def variant_params
            params.require(:variant).permit(:name, variant_attributes_attributes: [:id, :name, :_destroy])
          end

      end
  end
end