module Verified
  module ActsAsVerified

    extend ActiveSupport::Concern

    included do
    end

    URL_BASE = 'https://api.accuratebackground.com/v3/'
    module ClassMethods
      def acts_as_verified(options={})
        has_many :verifications, as: :verifiable, :class_name => '::Verified::ActsAsVerified::Verification', :dependent => :destroy
        include Verified::ActsAsVerified::LocalInstanceMethods
      end
    end

    module LocalInstanceMethods

      def candidate
        self.verifications.create
        @uri = URI.parse("#{@url_base}candidate")
        @request = Net::HTTP::Post.new(@uri)
        @request.basic_auth(client_id, client_secret)
        @req_options = { use_ssl: @uri.scheme == "https" }
        @request.set_form_data( validatable_attributes )
        make_request
      end


      private
      def validatable_attributes
        {
          "firstName" => self.firstname,
          "lastName" => self.lastname,
          "phone" => self.phone,
          "email" => self.email,
          "dateOfBirth" => self.dateofbirth,
          "ssn" => self.ssn,
          "address" => self.address,
          "city" => self.city,
          "region" => self.region,
          "postalCode" => self.postalcode,
          "country" => self.country
        }
      end

      def make_request
        Net::HTTP.start(@uri.hostname, @uri.port, @req_options) { |http| http.request(@request) }
      end

    end



  end
end
