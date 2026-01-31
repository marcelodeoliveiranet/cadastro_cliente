import 'dart:ffi';

class RamoAtividadeModel {
  final Short codigo;
  final String descricao;

  RamoAtividadeModel({required this.codigo, required this.descricao});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'codigo': codigo, 'descricao': descricao};
  }

  factory RamoAtividadeModel.fromJson(Map<String, dynamic> map) {
    return RamoAtividadeModel(
      codigo: map['codigo'] as Short,
      descricao: map['descricao'] as String,
    );
  }

  List<Object> get props => [codigo, descricao];
}
