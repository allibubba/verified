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



      def order
        # puts "==============================="
        # puts self.verifications
        # puts self.verifications.order(:created_at).last.try(:candidate_id)
        # puts "==============================="
        # return false
        create_candidate()
        @uri = URI.parse("#{Verified.base_url}order")
        @request = Net::HTTP::Post.new(@uri)
        @request.basic_auth(Verified.client_id, Verified.client_secret)
        @req_options = { use_ssl: @uri.scheme == "https" }
        @request.set_form_data(
          "packageType" => Verified.package_type,
          "candidateId" => self.verifications.order(:created_at).last.try(:candidate_id),
          "workflow" => "EXPRESS",
          "jobLocation.city" => "Portland",
          "jobLocation.region" => "OR",
          "jobLocation.country" => "US"
        )
        make_request
      end



      private

      def create_candidate
        # self.verifications.create
        @uri = URI.parse("#{Verified.base_url}candidate")
        @request = Net::HTTP::Post.new(@uri)
        @request.basic_auth(Verified.client_id, Verified.client_secret)
        @req_options = { use_ssl: @uri.scheme == "https" }
        @request.set_form_data( validatable_attributes )
        puts "attributes ++++++++++++++++++++++++++++++++++"
        puts validatable_attributes
        puts "+++++++++++++++++++++++++++++++++++++++++++++"
        make_request
      end


      def validatable_attributes
        {"firstName" => "bugs" ,
         "lastName" => "bunny",
         "phone" => "2063339999",
         "email" => "bugs@bunny.com",
         "dateOfBirth" => "1940-06-06",
         "ssn" => "123-55-6666",
         "address" => "4000 Warner Boulevard",
         "city" => "Burbank",
         "region" => "CA",
         "country" => "US"}
      end
      # def validatable_attributes
      #   {
      #     "firstName" => self.firstname,
      #     "lastName" => self.lastname,
      #     "phone" => self.phone,
      #     "email" => self.email,
      #     "dateOfBirth" => self.dateofbirth,
      #     "ssn" => self.ssn,
      #     "address" => self.address,
      #     "city" => self.city,
      #     "region" => self.region,
      #     "postalCode" => self.postalcode,
      #     "country" => self.country
      #   }
      # end

      def make_request
        puts "request params: -------------"
        puts self
        puts @uri
        puts @req_options
        puts @request
        puts "request params: -------------"

        n = Net::HTTP.start(@uri.hostname, @uri.port, @req_options) { |http| http.request(@request) }
        puts "Net::HTTP ====================="
        puts n.inspect
        puts "==============================="
        return n
      end

    end



  end
end
