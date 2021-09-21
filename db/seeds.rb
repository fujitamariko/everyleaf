# User.create!(
#     name: 'test1',
#     email: 'test1@email.com',
#     password: '12345678',
#     password_confirmation: '12345678'
# )
User.create!(
    name:  '管理者2',
    email: 'xxx@email.com',
    password: '12345678',
    password_confirmation: '12345678',
    admin: true
)