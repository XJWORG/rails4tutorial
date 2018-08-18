require 'spec_helper'

RSpec.describe Micropost, type: :model do
#  pending "add some examples to (or delete) #{__FILE__}"
end

describe Micropost do
  let(:user) {FactoryGirl.create(:user)}
  before do
    @micropost = Micropost.new(content: "Lorem ipsum" , user_id: user.id )

  end

  subject { @micropost }
  it { should respond_to(:content)}
  it { should respond_to(:user_id)}
end