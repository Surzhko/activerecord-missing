namespace :db do
  desc "Run all `activerecord-missing` rake tasks"
  task "missing" => ["missing:foreign_keys"]

  namespace :missing do
    desc "Print missing foreign keys"
    task foreign_keys: :environment do
      m_fks = ActiveRecord::Missing::ForeignKeys.call
      keys = 0
      m_fks.each do |table, columns|
        puts "=== (#{columns.count}) #{table.camelize} ".ljust(100, "=")
        columns.each { |column| puts "   - #{column}" }
        keys += columns.count
      end
      puts "(#{keys}) missing keys"
    end
  end
end
