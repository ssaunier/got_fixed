# == Schema Information
#
# Table name: got_fixed_users
#
#  id         :integer          not null, primary key
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

module GotFixed
  describe User do
    it "should not be able to create 2 users with the same email" do
      User.create! :email => "foo@bar.com"
      expect { User.create! :email => "foo@bar.com" }.to raise_error ActiveRecord::RecordInvalid
    end
  end
end
