module Verified
  module ActsAsVerified

    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      def acts_as_verified(options={})
        include Verified::ActsAsVerified::LocalInstanceMethods
      end
    end

    module LocalInstanceMethods
      def candidate
      end
    end

  end
end
