require 'active_record'



module Verified
  def self.setup
    yield self
  end
end


require 'verified/core_ext'
require 'verified/acts_as_verified'

::ActiveRecord::Base.send :include, Verified::ActsAsVerified
