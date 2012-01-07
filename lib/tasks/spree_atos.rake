namespace :spree_atos do
  task :bootstrap do
    Rake::Task['spree_atos:install:migrations'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['spree_atos:install:binaries'].invoke
    Rake::Task['spree_atos:install:config'].invoke
  end
  
  namespace :install do
    task :binaries do
      FileUtils.mkdir_p(Rails.root.join('bin', 'atos'))
    end
    
    task :config do
      FileUtils.mkdir_p(Rails.root.join('config', 'atos'))
    end
  end
end
