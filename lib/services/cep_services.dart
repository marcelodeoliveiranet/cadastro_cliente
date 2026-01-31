import 'package:cadastro_cliente/dto/response/cep_reponse.dart';
import 'package:dio/dio.dart';

class CepServices {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://viacep.com.br/ws/",
      headers: {"Content-Type": "application/json"},
    ),
  );

  Future<CepResponse> obterDadosCep(String cep) async {
    try {
      final response = await _dio.get('/$cep/json/');

      if (response.statusCode == 200) {
        return CepResponse.fromJson(response.data);
      } else {
        throw Exception('Erro ao obter dados do CEP: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao conectar ao serviço de CEP: $e');
    }
  }
}
