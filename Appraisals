shared_dependencies = proc do
  gem 'listen'
  gem 'sass-rails'
  gem 'sqlite3'
  gem 'rspec', '~> 3.0'
  gem 'shoulda-context'
  gem 'shoulda-matchers', '~> 3.0'
end

appraise '4.2' do
  instance_eval(&shared_dependencies)
  gem 'rails', '4.2.10'
end

appraise '5.0' do
  instance_eval(&shared_dependencies)
  gem 'rails', '5.0.1'
end
