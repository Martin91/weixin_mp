$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "weixin_mp/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "weixin_mp"
  s.version     = WeixinMp::VERSION
  s.authors     = ["Martin"]
  s.email       = ["hongzeqin@gmail.com"]
  s.homepage    = "http://www.martin-blog.com"
  s.summary     = "A framework for integrating Wechat public platform API use Rails."
  s.description = "A framework for integrating Wechat public platform API use Rails."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.14"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
