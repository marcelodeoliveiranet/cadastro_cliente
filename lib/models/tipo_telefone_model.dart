class TipoTelefoneModel {
  final int codigo;
  final String descricao;

  TipoTelefoneModel({required this.codigo, required this.descricao});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'codigo': codigo, 'descricao': descricao};
  }

  factory TipoTelefoneModel.fromMap(Map<String, dynamic> map) {
    return TipoTelefoneModel(
      codigo: map['codigo'] as int,
      descricao: map['descricao'] as String,
    );
  }
}
