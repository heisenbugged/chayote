Fabricator(:user) do
  email { Forgery::Internet.email_address }
  full_name { Forgery::Name.full_name }
  password { Forgery::Basic.password :allow_special => true }
end
Fabricator(:admin, :from => :user) do
  email { Forgery::Internet.email_address }
  full_name { Forgery::Name.full_name }
  password { Forgery::Basic.password :allow_special => true }
  admin { true }
end
Fabricator(:project) do
  name { Forgery::Name.company_name }
end
Fabricator(:task) do
  name { Forgery::Name.company_name }
end
Fabricator(:time_entry) do
  hours { Forgery::Basic.number :at_least => 1, :at_most => 5 }
end
Fabricator(:rate) do
  amount { Forgery::Basic.number :at_least => 1, :at_most => 100 }
end
Fabricator(:project_rate) do
  amount { Forgery::Basic.number :at_least => 1, :at_most => 100 }
end
Fabricator(:member) do
  project { Fabricate(:project) }
  user { Fabricate(:user) }
end
