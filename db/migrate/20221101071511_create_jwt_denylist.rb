class CreateJwtDenylist < ActiveRecord::Migration[6.1]
  def change
    add_column :jwt_denylists, :jti, :string
    add_column :jwt_denylists, :exp, :datetime
  
    add_index :jwt_denylists, :jti
  end
end


