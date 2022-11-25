class AddColumnInToSmsOtp < ActiveRecord::Migration[6.1]
  def change
    add_column :sms_otps, :valid_until, :datetime
  end
end
