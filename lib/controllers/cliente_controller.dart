import 'package:cadastro_cliente/dto/request/cadastrar_ramo_atividade_request.dart';
import 'package:cadastro_cliente/dto/request/cadastrar_tipo_telefone_request.dart';
import 'package:cadastro_cliente/dto/response/cep_reponse.dart';
import 'package:cadastro_cliente/models/ramo_atividade_model.dart';
import 'package:cadastro_cliente/models/tipo_telefone_model.dart';
import 'package:cadastro_cliente/services/cep_service.dart';
import 'package:cadastro_cliente/services/ramo_atividade_service.dart';
import 'package:cadastro_cliente/services/tipo_telefone_service.dart';
import 'package:cadastro_cliente/states/base_state.dart';
import 'package:flutter/material.dart';

class ClienteController extends ChangeNotifier {
  CepServices cepServices = CepServices();
  RamoAtividadeService ramoAtividadeService = RamoAtividadeService();
  TipoTelefoneService tipoTelefoneService = TipoTelefoneService();

  List<TipoTelefoneModel> tiposTelefone = [];
  List<RamoAtividadeModel> ramosAtividade = [];

  ValueNotifier<BaseState> ramoAtividadeState = ValueNotifier(IdleState());
  ValueNotifier<BaseState> tipoTelefoneState = ValueNotifier(IdleState());
  ValueNotifier<BaseState> buscarDadosCep = ValueNotifier(IdleState());

  Future<CepResponse?> buscarCep(String cep) async {
    buscarDadosCep.value = LoadingState();

    try {
      final cepData = await cepServices.obterDadosCep(cep);
      buscarDadosCep.value = SuccessState(
        sucesso: "Obter dados do CEP com sucesso",
      );

      return cepData;
    } catch (e) {
      buscarDadosCep.value = ErrorState(erro: e.toString());
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

  Future<void> obterTiposTelefone() async {
    tipoTelefoneState.value = LoadingState();

    try {
      tiposTelefone = await tipoTelefoneService.obtenhaTiposTelefone();
      tipoTelefoneState.value = SuccessState(
        sucesso: "Tipos de telefone carregados",
      );
    } catch (e) {
      tipoTelefoneState.value = ErrorState(
        erro: 'Erro ao carregar tipos de telefone: $e',
      );
    } finally {
      notifyListeners();
    }
  }

  Future<void> inserirTipoTelefone(
    CadastrarTipoTelefoneRequest tipoTelefone,
  ) async {
    tipoTelefoneState.value = LoadingState();

    try {
      await tipoTelefoneService.inserirTipoTelefone(tipoTelefone);
      await obterTiposTelefone();
    } catch (e) {
      print('Erro ao inserir tipo de telefone: $e');
    } finally {
      notifyListeners();
    }
  }
}
