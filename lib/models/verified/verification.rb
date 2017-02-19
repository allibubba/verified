module Verified
  module ActsAsVerified
    class Verification < ActiveRecord::Base
      belongs_to :verifiable, polymorphic: true
      scope :orders, -> {where.not(order_id:'')}
      def self.order_status 
        self.orders.each {|order| order.check_order}
      end

      def check_order
      end

    end
  end
end
