import 'dart:ffi';

class RamoAtividade {
  final Short codigo;
  final String descricao;

  RamoAtividade({required this.codigo, required this.descricao});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'codigo': codigo, 'descricao': descricao};
  }

  factory RamoAtividade.fromJson(Map<String, dynamic> map) {
    return RamoAtividade(
      codigo: map['codigo'] as Short,
      descricao: map['descricao'] as String,
    );
  }

  List<Object> get props => [codigo, descricao];
}
