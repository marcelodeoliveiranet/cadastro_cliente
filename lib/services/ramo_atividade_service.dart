import 'package:cadastro_cliente/core/database/app_database.dart';
import 'package:cadastro_cliente/core/database/tables/ramo_atividade.dart';
import 'package:cadastro_cliente/dto/request/cadastrar_ramo_atividade_request.dart';
import 'package:cadastro_cliente/models/ramo_atividade_model.dart';
import 'package:sqflite/sqflite.dart';

class RamoAtividadeService {
  Future<List<RamoAtividadeModel>> obtenhaRamosAtividade() async {
    final Database db = await AppDatabase.database;

    final ramosAtividade = await db.query(ramoAtividadeTableName);
    return ramosAtividade.map((e) => RamoAtividadeModel.fromMap(e)).toList();
  }

  Future<void> inserirRamoAtividade(
    CadastrarRamoAtividadeRequest ramoAtividade,
  ) async {
    final Database db = await AppDatabase.database;

    await db.insert(
      ramoAtividadeTableName,
      ramoAtividade.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
