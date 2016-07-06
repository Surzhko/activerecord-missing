module ActiveRecord
  module Missing
    class Railtie < Rails::Railtie
      generators do
        require "active_record/missing/generators/install_generator"
        require "active_record/missing/generators/foreign_keys_generator"
      end

      rake_tasks { load "active_record/missing/tasks.rake" }
    end
  end
end
