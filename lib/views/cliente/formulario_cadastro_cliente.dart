import 'package:cadastro_cliente/controllers/cliente_controller.dart';
import 'package:cadastro_cliente/dependecies/injetor.dart';
import 'package:cadastro_cliente/dto/request/cadastrar_ramo_atividade_request.dart';
import 'package:cadastro_cliente/models/ramo_atividade_model.dart';
import 'package:cadastro_cliente/models/tipo_telefone_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FormularioClienteWidget extends StatefulWidget {
  const FormularioClienteWidget({super.key});

  @override
  State<FormularioClienteWidget> createState() =>
      _FormularioClienteWidgetState();
}

class _FormularioClienteWidgetState extends State<FormularioClienteWidget> {
  ClienteController clienteController = getIt<ClienteController>();
  String? _tipoPessoa = "F";
  RamoAtividadeModel? _ramoAtividadeSelecionado;

  final _razaoSocialFocus = FocusNode();
  final _numeroLogradouroFocus = FocusNode();

  final cepMask = MaskTextInputFormatter(
    mask: "#####-###",
    filter: {"#": RegExp(r'[0-9]')},
  );

  final cpfMask = MaskTextInputFormatter(
    mask: "###.###.###-##",
    filter: {"#": RegExp(r'[0-9]')},
  );

  final cnpjMask = MaskTextInputFormatter(
    mask: "##.###.###/####-##",
    filter: {"#": RegExp(r'[0-9]')},
  );

  final codigoMunicipioIbgeMask = MaskTextInputFormatter(
    mask: "#.###.###",
    filter: {"#": RegExp(r'[0-9]')},
  );

  final telefone1Mask = MaskTextInputFormatter(
    mask: "(##) # ####-####",
    filter: {"#": RegExp(r'[0-9]')},
  );

  final formKey = GlobalKey<FormState>();
  final dropDownKey = GlobalKey<FormFieldState>();
  final formModalKey = GlobalKey<FormState>();

  final razaoSocialController = TextEditingController();
  final nomeFantasiaController = TextEditingController();
  final cnpjCpfController = TextEditingController();
  final inscricaoEstadualController = TextEditingController();
  final inscricaoMunicipalController = TextEditingController();
  final emailController = TextEditingController();
  final homePageController = TextEditingController();
  final cepController = TextEditingController();
  final logradouroCotroller = TextEditingController();
  final numeroController = TextEditingController();
  final complementoController = TextEditingController();
  final bairroController = TextEditingController();
  final municipioController = TextEditingController();
  final codigoIbgeController = TextEditingController();
  final estadoController = TextEditingController();
  final telefone1Controller = TextEditingController();
  final complementoTelefone1Controller = TextEditingController();
  final telefone2Controller = TextEditingController();
  final complementoTelefone2Controller = TextEditingController();

  bool isCpfValido(String cpf) {
    cpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');

    // Deve ter 11 dígitos
    if (cpf.length != 11) return false;

    // Elimina CPFs com todos os dígitos iguais
    if (RegExp(r'^(\d)\1{10}$').hasMatch(cpf)) return false;

    // Validação do primeiro dígito
    int soma = 0;
    for (int i = 0; i < 9; i++) {
      soma += int.parse(cpf[i]) * (10 - i);
    }
    int digito1 = (soma * 10) % 11;
    if (digito1 == 10) digito1 = 0;
    if (digito1 != int.parse(cpf[9])) return false;

    // Validação do segundo dígito
    soma = 0;
    for (int i = 0; i < 10; i++) {
      soma += int.parse(cpf[i]) * (11 - i);
    }
    int digito2 = (soma * 10) % 11;
    if (digito2 == 10) digito2 = 0;
    if (digito2 != int.parse(cpf[10])) return false;

    return true;
  }

  bool isCnpjValido(String cnpj) {
    cnpj = cnpj.replaceAll(RegExp(r'[^0-9]'), '');

    // Deve ter 14 dígitos
    if (cnpj.length != 14) return false;

    // Elimina CNPJs com todos os dígitos iguais
    if (RegExp(r'^(\d)\1{13}$').hasMatch(cnpj)) return false;

    List<int> numeros = cnpj.split('').map((e) => int.parse(e)).toList();

    // Validação do primeiro dígito
    List<int> pesos1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    int soma = 0;

    for (int i = 0; i < pesos1.length; i++) {
      soma += numeros[i] * pesos1[i];
    }

    int resto = soma % 11;
    int digito1 = resto < 2 ? 0 : 11 - resto;

    if (digito1 != numeros[12]) return false;

    // Validação do segundo dígito
    List<int> pesos2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    soma = 0;

    for (int i = 0; i < pesos2.length; i++) {
      soma += numeros[i] * pesos2[i];
    }

    resto = soma % 11;
    int digito2 = resto < 2 ? 0 : 11 - resto;

    if (digito2 != numeros[13]) return false;

    return true;
  }

  void _buscarCep(BuildContext context) async {
    final cep = cepController.text;
    final cepData = await clienteController.buscarCep(cep);

    if (cepData != null) {
      logradouroCotroller.text = cepData.logradouro;
      bairroController.text = cepData.bairro;
      municipioController.text = cepData.localidade;
      estadoController.text = cepData.uf;
      codigoIbgeController.text = cepData.ibge;

      FocusScope.of(context).requestFocus(_numeroLogradouroFocus);
    } else {
      logradouroCotroller.clear();
      bairroController.clear();
      municipioController.clear();
      estadoController.clear();
      codigoIbgeController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "CEP não encontrado",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _limparCamposFormulario() {
    razaoSocialController.clear();
    nomeFantasiaController.clear();
    cnpjCpfController.clear();
    inscricaoEstadualController.clear();
    inscricaoMunicipalController.clear();
    emailController.clear();
    homePageController.clear();
    cepController.clear();
    logradouroCotroller.clear();
    numeroController.clear();
    complementoController.clear();
    bairroController.clear();
    municipioController.clear();
    codigoIbgeController.clear();
    estadoController.clear();
    telefone1Controller.clear();
    complementoTelefone1Controller.clear();
    telefone2Controller.clear();
    complementoTelefone2Controller.clear();
  }

  void _salvar(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Cliente gravado com sucesso",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );

      setState(() {
        _limparCamposFormulario();
      });

      formKey.currentState?.reset();
      FocusScope.of(context).requestFocus(_razaoSocialFocus);
    }
  }

  Future<void> _abrirDialogNovoRamoAtividade(BuildContext context) async {
    final descricaoController = TextEditingController();

    final salvou = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Form(
              key: formModalKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Cadastrar um novo ramo de atividade",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    autofocus: true,
                    controller: descricaoController,
                    decoration: InputDecoration(
                      labelText: "Descrição",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Informe a descrição";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 44),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: const Text("Cancelar"),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            final isVaid =
                                formModalKey.currentState?.validate() ?? false;

                            if (!isVaid) {
                              return;
                            }

                            CadastrarRamoAtividadeRequest
                            cadastrarRamoAtividadeRequest =
                                CadastrarRamoAtividadeRequest(
                                  codigo: null,
                                  descricao: descricaoController.text,
                                );

                            await clienteController.inserirRamoAtividade(
                              cadastrarRamoAtividadeRequest,
                            );

                            final valor = descricaoController.text;
                            debugPrint("Gravado $valor");
                            Navigator.pop(context, true);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text("Gravar"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    if (salvou == true) {
      setState(() {
        clienteController.obterRamosAtividade();
      });
    }
  }

  void _incluirTipoTelefone() {
    final descricaoController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Form(
              key: formModalKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Cadastrar um novo tipo de telefone",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    autofocus: true,
                    controller: descricaoController,
                    decoration: InputDecoration(
                      labelText: "Descrição",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Informe a descrição";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 44),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancelar"),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            final isVaid =
                                formModalKey.currentState?.validate() ?? false;

                            if (!isVaid) {
                              return;
                            }

                            final valor = descricaoController.text;
                            debugPrint("Gravado $valor");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text("Gravar"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<TextInputFormatter> get inputFormatters {
    return _tipoPessoa == 'F' ? [cpfMask] : [cnpjMask];
  }

  void limparTextoMascara() {
    cnpjCpfController.clear();
    cpfMask.clear();
    cnpjMask.clear();
  }

  @override
  void initState() {
    super.initState();
    clienteController.obterRamosAtividade();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1B1F),
      appBar: AppBar(
        title: Text(
          "Cadastro de Cliente",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              spacing: 18,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        title: const Text("Pessoa física"),
                        value: "F",
                        groupValue: _tipoPessoa,
                        onChanged: (value) {
                          setState(() {
                            _tipoPessoa = value;
                            limparTextoMascara();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: const Text("Pessoa juridica"),
                        value: "J",
                        groupValue: _tipoPessoa,
                        onChanged: (value) {
                          setState(() {
                            _tipoPessoa = value;
                            limparTextoMascara();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  controller: razaoSocialController,
                  focusNode: _razaoSocialFocus,
                  keyboardType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    labelText:
                        _tipoPessoa == "F" ? "Nome completo" : "Razão Social",
                  ),
                  validator: (value) {
                    if (value == "" || value == null) {
                      return _tipoPessoa == "F"
                          ? "Informe o nome completo"
                          : "Informe a razão social";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: nomeFantasiaController,
                  keyboardType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    labelText: _tipoPessoa == "F" ? "Apelido" : "Nome Fantasia",
                  ),
                  validator: (value) {
                    if (value == "" || value == null) {
                      return _tipoPessoa == "F"
                          ? "Informe o apelido"
                          : "Informe o nome fantasia";
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListenableBuilder(
                        listenable: clienteController.ramoAtividadeState,
                        builder: (context, child) {
                          return DropdownButtonFormField<RamoAtividadeModel>(
                            key: dropDownKey,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.category),
                              labelText: "Selecione um ramo atividade",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            isExpanded: true,
                            value: _ramoAtividadeSelecionado,
                            items:
                                clienteController.ramosAtividade.map((
                                  ramoAtividade,
                                ) {
                                  return DropdownMenuItem<RamoAtividadeModel>(
                                    value: ramoAtividade,
                                    child: Text(ramoAtividade.descricao),
                                  );
                                }).toList(),
                            validator: (value) {
                              if (value == null) {
                                return "Selecione um ramo de atividade";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {});
                            },
                          );
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _abrirDialogNovoRamoAtividade(context);
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                Divider(),
                TextFormField(
                  controller: cnpjCpfController,
                  keyboardType: TextInputType.number,
                  inputFormatters: inputFormatters,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      _tipoPessoa == "F" ? Icons.article : Icons.business,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    labelText: _tipoPessoa == "F" ? "CPF" : "CNPJ",
                  ),
                  validator: (value) {
                    if (value == "" || value == null) {
                      return _tipoPessoa == "F"
                          ? "Informe o CPF"
                          : "Informe o CNPJ";
                    }

                    if (_tipoPessoa == "F" && !isCpfValido(value)) {
                      return "CPF inválido";
                    }

                    if (_tipoPessoa == "J" && !isCnpjValido(value)) {
                      return "CNPJ inválido";
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: inscricaoMunicipalController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      _tipoPessoa == "F" ? Icons.article : Icons.business,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    labelText: _tipoPessoa == "F" ? "RG" : "Inscricao Estadual",
                  ),
                ),

                TextFormField(
                  controller: inscricaoEstadualController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.business),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    labelText: "Inscricao Municipal",
                  ),
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    labelText: "Email",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Informe o email";
                    }

                    final emailRegex = RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    );

                    if (!emailRegex.hasMatch(value)) {
                      return 'E-mail inválido';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: homePageController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.web),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    labelText: "Home Page",
                  ),
                ),
                Divider(),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: cepController,
                        inputFormatters: [cepMask],
                        keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_on),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          labelText: "Cep",
                        ),
                        validator: (value) {
                          if (value == "" || value == null) {
                            return "Informe o cep";
                          }
                          return null;
                        },
                      ),
                    ),
                    IconButton(
                      tooltip: "Busca o endereço baseado em um cep",
                      onPressed: () => _buscarCep(context),
                      icon: const Icon(Icons.find_in_page),
                    ),
                  ],
                ),

                TextFormField(
                  controller: logradouroCotroller,
                  keyboardType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_on),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    labelText: "Logradouro",
                  ),
                  validator: (value) {
                    if (value == "" || value == null) {
                      return "Informe o logradouro";
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: numeroController,
                        focusNode: _numeroLogradouroFocus,
                        keyboardType: TextInputType.text,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_on),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          labelText: "Número",
                        ),
                        validator: (value) {
                          if (value == "" || value == null) {
                            return "Informe o número";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: complementoController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_on),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          labelText: "Complemento",
                        ),
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  controller: bairroController,
                  keyboardType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_on),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    labelText: "Bairro",
                  ),
                  validator: (value) {
                    if (value == "" || value == null) {
                      return "Informe o bairro";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: municipioController,
                  keyboardType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_on),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    labelText: "Municipio",
                  ),
                  validator: (value) {
                    if (value == "" || value == null) {
                      return "Informe o município";
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: codigoIbgeController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [codigoMunicipioIbgeMask],
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_on),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          labelText: "Código do IBGE",
                        ),
                        validator: (value) {
                          if (value == "" || value == null) {
                            return "Informe o código do IBGE";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: estadoController,
                        keyboardType: TextInputType.text,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_on),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          labelText: "Estado",
                        ),
                        validator: (value) {
                          if (value == "" || value == null) {
                            return "Informe o estado";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<TipoTelefoneModel>(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.category),
                          labelText: "Selecione um tipo telefone",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        isExpanded: true,
                        value: null,
                        items: [],
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: _incluirTipoTelefone,
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                TextFormField(
                  controller: telefone1Controller,
                  keyboardType: TextInputType.number,
                  inputFormatters: [telefone1Mask],
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    hintText: "(99) 9 9999-99",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    labelText: "Telefone",
                  ),
                ),
                TextFormField(
                  controller: complementoTelefone1Controller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    labelText: "Complemento",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: FilledButton.icon(
            icon: const Icon(Icons.save),
            onPressed: () => _salvar(context),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
            ),
            label: const Text(
              "Salvar",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    razaoSocialController.dispose();
    nomeFantasiaController.dispose();
    cnpjCpfController.dispose();
    inscricaoEstadualController.dispose();
    inscricaoMunicipalController.dispose();
    emailController.dispose();
    homePageController.dispose();
    cepController.dispose();
    logradouroCotroller.dispose();
    numeroController.dispose();
    complementoController.dispose();
    bairroController.dispose();
    municipioController.dispose();
    codigoIbgeController.dispose();
    estadoController.dispose();
    telefone1Controller.dispose();
    complementoTelefone1Controller.dispose();
    telefone2Controller.dispose();
    complementoTelefone2Controller.dispose();

    super.dispose();
  }
}
