module ActiveRecord
  module Missing
    class Railtie < Rails::Railtie
      generators { require "active_record/missing/generators/foreign_keys_generator" }

      rake_tasks { load "active_record/missing/tasks.rake" }
    end
  end
end
