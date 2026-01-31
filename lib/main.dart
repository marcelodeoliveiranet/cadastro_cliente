import 'package:cadastro_cliente/core/database/app_database.dart';
import 'package:cadastro_cliente/dependecies/injetor.dart';
import 'package:cadastro_cliente/views/cliente/formulario_cadastro_cliente.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

Future<void> exibirEstruturaTabela(Database db, String nomeTabela) async {
  var columns = await db.rawQuery("PRAGMA table_info($nomeTabela)");

  print("");
  print("Colunas da tabela: $nomeTabela");
  print("===============================");

  String pk = "False";

  for (var column in columns) {
    if (column["pk"] == 1) {
      pk = "True ";
    } else {
      pk = "False";
    }

    print("Campo PK: $pk | Coluna: ${column['name']} | Tipo:${column['type']}");
  }

  final fks = await db.rawQuery("PRAGMA foreign_key_list($nomeTabela)");

  if (fks.isNotEmpty) {
    print("");
    print("Foreign Keys");
    print("============");

    for (var row in fks) {
      print(row);
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupInjector();
  final db = await AppDatabase.database;

  await exibirEstruturaTabela(db, "RAMOATIVIDADE");
  await exibirEstruturaTabela(db, "TIPOTELEFONE");

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cadastro de Cliente',

      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),

      themeMode: ThemeMode.dark,
      home: FormularioClienteWidget(),
    );
  }
}
