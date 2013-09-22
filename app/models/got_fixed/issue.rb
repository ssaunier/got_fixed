module GotFixed
  class Issue < ActiveRecord::Base
    default_scope { order("updated_at DESC") }
    validates_uniqueness_of :vendor_id, :scope => :vendor
  end
end
