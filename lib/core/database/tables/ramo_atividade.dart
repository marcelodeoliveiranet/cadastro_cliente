const String ramoAtividadeTableName = "RAMOATIVIDADE";

const String ramoAtividadeTable = ''' 
  CREATE TABLE IF NOT EXISTS $ramoAtividadeTableName (
    codigo INTEGER PRIMARY KEY,
    descricao TEXT NOT NULL
  );
''';
