const String tableRamoAtividadeTableName = "RAMOATIVIDADE";

const String ramoAtividadeTable = ''' 
  CREATE TABLE IF NOT EXISTS $tableRamoAtividadeTableName (
    codigo INTEGER PRIMARY KEY,
    descricao TEXT NOT NULL
  );
''';
