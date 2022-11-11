class VariantsController < ApplicationController
	def new 
    	@variant = Variant.new
    end

    def create
    	@variant = Variant.new(variant_params)

    	if @variant.save
    		redirect_to home_index_path(@variant.id)
    	else 
    		render 'new'
    	end
    end

    private
    def variant_params
      params.require(:variant).permit(:name, variant_attributes_attributes: [:id, :name, :_destroy])
    end
end
