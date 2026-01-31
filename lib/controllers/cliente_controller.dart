import 'package:cadastro_cliente/dto/request/cadastrar_ramo_atividade_request.dart';
import 'package:cadastro_cliente/dto/response/cep_reponse.dart';
import 'package:cadastro_cliente/models/ramo_atividade_model.dart';
import 'package:cadastro_cliente/services/cep_service.dart';
import 'package:cadastro_cliente/services/ramo_atividade_service.dart';
import 'package:cadastro_cliente/states/base_state.dart';
import 'package:flutter/material.dart';

class ClienteController extends ChangeNotifier {
  CepServices cepServices = CepServices();
  RamoAtividadeService ramoAtividadeService = RamoAtividadeService();
  List<RamoAtividadeModel> ramosAtividade = [];
  ValueNotifier<BaseState> ramoAtividadeState = ValueNotifier(IdleState());

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

  Future<void> obterRamosAtividade() async {
    ramoAtividadeState.value = LoadingState();

    try {
      ramosAtividade = await ramoAtividadeService.obtenhaRamosAtividade();
      ramoAtividadeState.value = SuccessState(
        sucesso: "Ramo Atividade carregados",
      );
    } catch (e) {
      ramoAtividadeState.value = ErrorState(
        erro: 'Erro ao carregar ramos de atividade: $e',
      );
    } finally {
      notifyListeners();
    }
  }

  Future<void> inserirRamoAtividade(
    CadastrarRamoAtividadeRequest ramoAtividade,
  ) async {
    try {
      await ramoAtividadeService.inserirRamoAtividade(ramoAtividade);
      await obterRamosAtividade();
    } catch (e) {
      print('Erro ao inserir ramo de atividade: $e');
    } finally {
      notifyListeners();
    }
  }
}
