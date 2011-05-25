source :rubygems

gem 'rails', '3.0.4'

# Core Ext
#gem 'andand', :git => "git://github.com/raganwald/andand.git"

# UI
gem 'haml', '~> 3.0.21'

# DB
gem 'mongoid', :git => "git://github.com/mongoid/mongoid.git"
# Bson and bson_ext have to be the same version
gem 'bson', '~> 1.3.0'
gem 'bson_ext', '~> 1.3.0'

# Model
gem 'state_machine', '~> 0.9.4'
gem 'state_machine-mongoid', '~> 0.1.5'

# Controller
gem 'inherited_resources', '~> 1.1.2'

# Other
gem 'simple_form', '~> 1.3.1'

# Server
gem 'thin', '~> 1.2.7'

# Auth
gem "cancan", '~> 1.6.4'
gem 'devise', '~> 1.1.5'
gem 'hpricot', '~> 0.8.4'
gem 'ruby_parser', '~> 2.0.6'


# Test gems without generators
group :test do
  gem 'rr', '~> 1.0.2'
  gem 'capybara', '~> 0.4.0'
  gem 'launchy', '~> 0.3.7'
  gem 'webrat', '~> 0.7.2', :require => nil
  gem 'azebiki', '~> 0.0.2', :require => nil
  gem 'forgery', '~> 0.3.6'
  gem 'database_cleaner', '~> 0.6.0'
  gem 'remarkable_activemodel', '~> 4.0.0.alpha4', :require => nil
  gem 'remarkable_mongoid', '~> 0.5.0', :require => nil
  gem 'timecop', '~> 0.3.5'
  gem 'test_notifier', '~> 0.3.6'
  gem 'autotest', '~> 4.4.5'
end

# Test gems with generators (available in dev env)
group :development, :test do
  gem 'rspec-core', '~> 2.3.1'
  gem 'rspec-expectations', '~> 2.3.0'
  gem 'rspec-rails', '~> 2.3.1'
  gem 'spork', '>= 0.9.0.rc2'
end

# Special gems that get reloaded by spork on each run ( no auto require ) (Microoptimization)
gem 'fabrication', '~> 0.9.0', :require => nil, :group => :test
gem 'fabrication', '~> 0.9.0', :group => :development