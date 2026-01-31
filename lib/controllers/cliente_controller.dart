import 'package:cadastro_cliente/dto/response/cep_reponse.dart';
import 'package:cadastro_cliente/services/cep_services.dart';
import 'package:flutter/material.dart';

class ClienteController extends ChangeNotifier {
  CepServices cepServices = CepServices();

  Future<CepResponse?> buscarCep(String cep) async {
    try {
      final cepData = await cepServices.obterDadosCep(cep);
      return cepData;
    } catch (e) {
      print('Erro ao buscar CEP: $e');
      return null;
    } finally {
      notifyListeners();
    }
  }
}
