import 'package:cadastro_cliente/model/ramo_atividade.dart';
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
  String? _tipoPessoa = "F";

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
  final telefone1Controller = TextEditingController();
  final complementoTelefone1Controller = TextEditingController();
  final telefone2Controller = TextEditingController();
  final complementoTelefone2Controller = TextEditingController();

  void _salvar() {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Cliente gravado com sucesso",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  void _incluirNovoRamoAtividade(BuildContext context) {
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

  void _incluirTipoLogradouro() {
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
                    "Cadastrar um novo tipo de logradouro",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    autofocus: true,
                    controller: descricaoController,
                    decoration: InputDecoration(
                      labelText: "Nome do tipo do logradouro",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Informe o nome do tipo de logradouro";
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
                            final isValid =
                                formModalKey.currentState?.validate() ?? false;

                            if (!isValid) {
                              return;
                            }

                            final valor = descricaoController.text;
                            debugPrint("Gravado $valor");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text(
                            "Gravar",
                            style: TextStyle(fontSize: 14),
                          ),
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
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
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
                  decoration: InputDecoration(
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
                      child: DropdownButtonFormField<RamoAtividade>(
                        decoration: InputDecoration(
                          labelText: "Selecione um ramo atividade",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        isExpanded: true,
                        value: null,
                        items: [],
                        // validator: (value) {
                        //   if (value == null) {
                        //     return "Selecione um ramo de atividade";
                        //   }
                        //   return null;
                        // },
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _incluirNovoRamoAtividade(context);
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                Divider(),
                TextFormField(
                  controller: cnpjCpfController,
                  keyboardType: TextInputType.text,
                  inputFormatters: inputFormatters,
                  decoration: InputDecoration(
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
                    return null;
                  },
                ),
                TextFormField(
                  controller: inscricaoMunicipalController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
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
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    labelText: "Inscricao Municipal",
                  ),
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    labelText: "Email",
                  ),
                ),
                TextFormField(
                  controller: homePageController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
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
                        decoration: InputDecoration(
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
                      onPressed: () {},
                      icon: const Icon(Icons.find_in_page),
                    ),
                    Expanded(
                      child: DropdownButtonFormField<RamoAtividade>(
                        decoration: InputDecoration(
                          labelText: "Tipo do logradouro",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        isExpanded: true,
                        value: null,
                        items: [],
                        // validator: (value) {
                        //   if (value == null) {
                        //     return "Selecione um tipo de logradouro";
                        //   }
                        //   return null;
                        // },
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _incluirTipoLogradouro();
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                Row(children: [
                ],
              ),

                TextFormField(
                  controller: logradouroCotroller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
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
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
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
                  decoration: InputDecoration(
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
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: municipioController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
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
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: codigoIbgeController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [codigoMunicipioIbgeMask],
                        decoration: InputDecoration(
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
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<RamoAtividade>(
                        decoration: InputDecoration(
                          labelText: "Selecione um estado",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        isExpanded: true,
                        value: null,
                        items: [],
                        // validator: (value) {
                        //   if (value == null) {
                        //     return "Selecione um estado";
                        //   }
                        //   return null;
                        // },
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                Divider(),
                Column(
                  spacing: 18,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<RamoAtividade>(
                            decoration: InputDecoration(
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
                          tooltip: "Busca o endereço baseado em um cep",
                          onPressed: _incluirTipoTelefone,
                          icon: const Icon(Icons.add),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: telefone1Controller,
                            keyboardType: TextInputType.number,
                            inputFormatters: [telefone1Mask],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              labelText: "Telefone",
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: complementoTelefone1Controller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        labelText: "Complemento",
                      ),
                    ),
                  ],
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
            onPressed: _salvar,
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
    telefone1Controller.dispose();
    complementoTelefone1Controller.dispose();
    telefone2Controller.dispose();
    complementoTelefone2Controller.dispose();

    super.dispose();
  }
}
