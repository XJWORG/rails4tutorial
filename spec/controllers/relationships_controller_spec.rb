require "spec_helper"

describe RelationshipsController do
    let(:user) {FactoryGirl.create(:user)}
    let(:other_user){FactoryGirl.create(:user)}

    before { sign_in user , no_capybara: true}

    describe "creating a relationship with Ajax" do

        it "should increment the Relationship count" do
            expect do
                # xhr :post, :create, relationship: { followed_id: other_user.id }
                post :create, params: {relationship: { followed_id: other_user.id }}, xhr: true
            end.to change(Relationship, :count).by(1)
        end

        it "should respond with success" do
            # 这是老版本的ajax方法测试
            # xhr :post, :create, relationship: { followed_id: other_user.id }
            # 需要使用这个版本的ajax测试
            post :create, params: {relationship: { followed_id: other_user.id }}, xhr:true
            expect(response).to be_success
        end

    end

    describe "destroying a relationship with Ajax" do
        before { user.follow!(other_user) }
        let(:relationship) { user.relationships.find_by(followed_id: other_user)}

        it "should decrement the Relationship count" do
            expect do
                # xhr :delete, :destroy, id: relationship.id
                delete :destroy, params: {id: relationship.id}, xhr: true
            end.to change(Relationship, :count).by(-1)
        end

        it "should respond with success" do
            # xhr :delete, :destroy, id: relationship.id
            delete :destroy, params: {id: relationship.id}, xhr: true
            expect(response).to be_success
        end
    end

end