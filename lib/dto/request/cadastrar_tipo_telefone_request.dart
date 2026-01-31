// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CadastrarTipoTelefoneRequest {
  final int? codigo;
  final String descricao;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'codigo': codigo, 'descricao': descricao};
  }

  factory CadastrarTipoTelefoneRequest.fromMap(Map<String, dynamic> map) {
    return CadastrarTipoTelefoneRequest(
      codigo: map['codigo'] != null ? map['codigo'] as int : null,
      descricao: map['descricao'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CadastrarTipoTelefoneRequest.fromJson(String source) =>
      CadastrarTipoTelefoneRequest.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
  CadastrarTipoTelefoneRequest({this.codigo, required this.descricao});
}
