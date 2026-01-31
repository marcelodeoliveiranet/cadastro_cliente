import 'dart:ffi';

class TipoTelefoneModel {
  final Short codigo;
  final String descricao;

  TipoTelefoneModel({required this.codigo, required this.descricao});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'codigo': codigo, 'descricao': descricao};
  }

  factory TipoTelefoneModel.fromJson(Map<String, dynamic> map) {
    return TipoTelefoneModel(
      codigo: map['codigo'] as Short,
      descricao: map['descricao'] as String,
    );
  }
}
