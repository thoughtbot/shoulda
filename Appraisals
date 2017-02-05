shared_dependencies = proc do
  gem 'listen'
  gem 'sass-rails'
  gem 'sqlite3'
  gem 'rspec', '~> 3.0'
  gem 'shoulda-context', path: '../shoulda-context'
  gem 'shoulda-matchers', '~> 3.0'
  gem 'rails-controller-testing'
  gem 'jquery-rails'
end

appraise '4.2' do
  instance_eval(&shared_dependencies)
  gem 'rails', git: 'https://github.com/rails/rails.git', branch: '4-2-stable'
end

appraise '5.0' do
  instance_eval(&shared_dependencies)
  gem 'rails', '5.0.1'
end
