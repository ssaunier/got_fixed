module GotFixed
  class Issue < ActiveRecord::Base
    default_scope { order("updated_at DESC") }
    validates_uniqueness_of :vendor_id, :scope => :vendor

    has_and_belongs_to_many :issues

    after_update :send_notifications, :if => :just_closed?

    private

      def just_closed?
        !closed_was && closed
      end

      def send_notifications
        issues.each do |issue|
          issue.send_notification self
        end
      end
  end
end
