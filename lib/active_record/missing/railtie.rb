module ActiveRecord
  module Missing
    class Railtie < Rails::Railtie
      rake_tasks  { load "active_record/missing/tasks.rake" }
    end
  end
end
