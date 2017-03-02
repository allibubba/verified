require 'active_record'

module Verified
  mattr_accessor :base_url, :client_id, :client_secret, :package_type

  def self.setup
    yield self
  end
end

require 'verified/acts_as_verified'
require 'models/verified/verification'

::ActiveRecord::Base.send :include, Verified::ActsAsVerified
