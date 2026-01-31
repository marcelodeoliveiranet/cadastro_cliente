import 'package:cadastro_cliente/core/database/app_database.dart';
import 'package:cadastro_cliente/core/database/tables/tipo_telefone.dart';
import 'package:cadastro_cliente/dto/request/cadastrar_tipo_telefone_request.dart';
import 'package:cadastro_cliente/models/tipo_telefone_model.dart';
import 'package:sqflite/sqflite.dart';

class TipoTelefoneService {
  Future<List<TipoTelefoneModel>> obtenhaTiposTelefone() async {
    final Database db = await AppDatabase.database;
    final tiposTelefone = db.query(tipoTelefoneTableName);
    return tiposTelefone.then(
      (value) => value.map((e) => TipoTelefoneModel.fromMap(e)).toList(),
    );
  }

  Future<void> inserirTipoTelefone(
    CadastrarTipoTelefoneRequest tipoTelefone,
  ) async {
    final Database db = await AppDatabase.database;
    await db.insert(
      tipoTelefoneTableName,
      tipoTelefone.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
