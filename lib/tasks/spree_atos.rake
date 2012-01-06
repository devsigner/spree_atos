namespace :spree_atos do
  task :bootstrap do
    Rake::Task['spree_atos:install:binaries'].invoke
    Rake::Task['spree_atos:install:config'].invoke
    Rake::Task['spree_atos:install:migrations'].invoke
    Rake::Task['spree_atos:db:migrate'].invoke
  end
  
  namespace :install do
    task :binaries do
      FileUtils.mkdir_p(Rails.root.join('bin', 'atos'))
      puts 'Please copy Atos vendor binary files ("request", "response") inside '
      puts 'the "bin/atos" directory.'
    end
    
    task :config do
      FileUtils.mkdir_p(Rails.root.join('config', 'atos'))
      puts 'Please copy Atos vendor config files ("parmcom.*", "pathfile") and '
      puts 'certificates inside the "config/atos" directory.'
      puts
      puts 'Make the following changes to the "pathfile" file:'
      puts '  D_LOGO!/assets/atos/!'
      puts '  F_CERTIFICATE!config/atos/certif!'
      puts '  F_PARAM!config/atos/parmcom!'
      puts '  F_DEFAULT!config/atos/parmcom.VENDOR!'
      puts '(where VENDOR is "sogenactif", "e-transactions", ...)'
    end
  end
end
