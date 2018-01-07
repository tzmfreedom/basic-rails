admin_users = [
  {
    id: 1,
    email: 'admin@example.com',
    password: 'password'
  }
]

AdminUser.seed(:id, *admin_users)
