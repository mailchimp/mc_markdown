Sequel.migration do
  up do
    alter_table(:documents) do
      rename_column :document, :content
    end
  end

  down do
    alter_table(:documents) do
      rename_column :content, :document
    end
  end
end