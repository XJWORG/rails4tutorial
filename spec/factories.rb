FactoryGirl.define do
    factory :user do
        # name  "michael"
        # email "michael@example.com"

        sequence(:name) {|n| "Person_#{n}" }
        sequence(:email) { |n| "persion_#{n}@example.com" } 

        password "fullcase"
        password_confirmation "fullcase"

        factory :admin do
            admin true
        end

    end
end