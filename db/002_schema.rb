Sequel.migration do
  change do
    create_table(:documents) do
      primary_key :id
      String :name, :text=>true
      String :content, :text=>true, :null=>false
    end
    
    create_table(:schema_info) do
      Integer :version, :default=>0, :null=>false
    end
  end
end

