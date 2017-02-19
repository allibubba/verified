require 'test_helper'

class ActsAsVerifiedTest < ActiveSupport::TestCase
  def test_can_create_verification_through_model
      user = User.create
      new_verification = user.verifications.create
      assert new_verification.valid?
  end
  def test_instance_candidate_should_create_verified_instance
      user = User.new
      new_candidate = user.candidate()
      assert new_candidate.valid?
  end
end
