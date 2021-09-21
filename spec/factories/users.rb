FactoryBot.define do
  factory :user do
    name { 'general_user' }
    email { 'general_user@example.com' }
    password { '12345678' }
    password_confirmation { '12345678' }
    admin { 'false' }
  end

  factory :admin_user, class: User do
    name { 'admin_test' }
    email { 'admin_test@example.com' }
    password { '12345678' }
    password_confirmation { '12345678' }
    admin { 'true' }
  end
end
