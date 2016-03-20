require_relative 'controllers/application_controller'
require_relative 'migrations/initial'

if !File.exist?('db/links.db')
  InitialMigration.migrate(:up)
end

ApplicationController.run!
