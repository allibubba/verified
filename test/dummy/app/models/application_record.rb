class ApplicationRecord < ActiveRecord::Base
  include Verified::ActsAsVerified
  self.abstract_class = true
end


