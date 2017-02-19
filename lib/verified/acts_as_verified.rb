module Verified
  module ActsAsVerified

    extend ActiveSupport::Concern

    included do
    end

    class Verification < ActiveRecord::Base
      belongs_to :verifiable, polymorphic: true
      scope :orders, -> {where.not(order_id:'')}
      def self.order_status 
        self.orders.each {|order| order.check_order}
      end

      def check_order
      end

    end

    module ClassMethods
      def acts_as_verified(options={})
        has_many :verifications, as: :verifiable, :class_name => '::Verified::ActsAsVerified::Verification', :dependent => :destroy
        include Verified::ActsAsVerified::LocalInstanceMethods
      end
    end

    module LocalInstanceMethods
      def candidate
        self.verifications.create
      end
    end

  end
end
