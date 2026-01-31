const String tipoTelefoneTableName = "TIPOTELEFONE";

const String tipoTelefoneTable = ''' 
  CREATE TABLE IF NOT EXISTS $tipoTelefoneTableName (
    codigo INTEGER PRIMARY KEY,
    descricao TEXT NOT NULL
  );
''';
