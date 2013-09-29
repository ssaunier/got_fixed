# == Schema Information
#
# Table name: got_fixed_issues
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  closed     :boolean
#  created_at :datetime
#  updated_at :datetime
#  number     :integer
#  vendor_id  :string(255)
#  vendor     :string(255)
#

module GotFixed
  class Issue < ActiveRecord::Base
    default_scope { order("updated_at DESC") }
    validates_uniqueness_of :vendor_id, :scope => :vendor

    has_and_belongs_to_many :users

    after_update :send_notifications, :if => :just_closed?

    private

      def just_closed?
        !closed_was && closed
      end

      def send_notifications
        users.each do |user|
          user.send_notification self
        end
      end
  end
end
