Sequel.migration do
  up do
    alter_table( :documents ) do
      add_column :slug, String
    end
  end

  down do
    alter_table( :documents ) do
      drop_column :slug
    end
  end
end