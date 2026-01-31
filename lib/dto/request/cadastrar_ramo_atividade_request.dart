// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CadastrarRamoAtividadeRequest {
  final int? codigo;
  final String descricao;

  CadastrarRamoAtividadeRequest({this.codigo, required this.descricao});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'codigo': codigo, 'descricao': descricao};
  }

  factory CadastrarRamoAtividadeRequest.fromMap(Map<String, dynamic> map) {
    return CadastrarRamoAtividadeRequest(
      codigo: map['codigo'] as int,
      descricao: map['descricao'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CadastrarRamoAtividadeRequest.fromJson(String source) =>
      CadastrarRamoAtividadeRequest.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
