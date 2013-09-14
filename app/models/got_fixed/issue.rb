module GotFixed
  class Issue < ActiveRecord::Base
    validates_uniqueness_of :vendor_id, :scope => :vendor
  end
end
