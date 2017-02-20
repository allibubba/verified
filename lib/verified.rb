require 'active_record'

module Verified

    mattr_accessor :base_url, :client_id, :client_secret
    # @@base_url = self.base_url
    #
    #     mattr_accessor :client_id
    #     @@client_id = self.client_id
    #
    #     mattr_accessor :client_secret
    #     @@client_secret = self.client_secret

  def self.setup
    yield self
  end
end

require 'verified/acts_as_verified'
require 'models/verified/verification'

::ActiveRecord::Base.send :include, Verified::ActsAsVerified
