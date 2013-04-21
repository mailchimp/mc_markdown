
task :server do
  system 'foreman start'
end

namespace :db do

  task :load_schema do
    system "sequel -E -m db postgres://localhost/mc_markdown"
  end

  task :migrate do
    if system "sequel -E -m db/migrations -M #{newest_migration} postgres://localhost/mc_markdown"
      puts "\nmigration complete"
      puts "\nupdating schema file"
      update_schema_file
    end
  end

  def newest_migration
    out = `ls db/migrations`
    out.split.map { |m| m[0..2] }.last
  end

  def update_schema_file
    require 'sequel'
    require 'sequel/extensions/schema_dumper'

    schema_file = "db/#{newest_migration}_schema.rb"
    `touch #{schema_file} && ECHO '#{Sequel.connect('postgres://localhost/mc_markdown').dump_schema_migration}' > #{schema_file}`
  end
end