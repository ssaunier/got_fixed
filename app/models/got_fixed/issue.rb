module GotFixed
  class Issue < ActiveRecord::Base
    attr_accessible :closed, :title
  end
end
