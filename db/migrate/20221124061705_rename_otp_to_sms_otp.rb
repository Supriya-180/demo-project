class RenameOtpToSmsOtp < ActiveRecord::Migration[6.1]
  def change
    rename_table :otps, :sms_otps
  end
end

