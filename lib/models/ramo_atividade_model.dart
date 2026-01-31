class RamoAtividadeModel {
  final int codigo;
  final String descricao;

  RamoAtividadeModel({required this.codigo, required this.descricao});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'codigo': codigo, 'descricao': descricao};
  }

  factory RamoAtividadeModel.fromMap(Map<String, dynamic> map) {
    return RamoAtividadeModel(
      codigo: map['codigo'] as int,
      descricao: map['descricao'] as String,
    );
  }
}
