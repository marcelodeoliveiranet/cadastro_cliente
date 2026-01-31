import 'package:cadastro_cliente/controllers/cliente_controller.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupInjector() {
  // Aqui você pode registrar seus serviços, controladores, etc.
  // Exemplo:
  // getIt.registerSingleton<SeuServico>(SeuServicoImpl());
  getIt.registerSingleton<ClienteController>(ClienteController());
}
