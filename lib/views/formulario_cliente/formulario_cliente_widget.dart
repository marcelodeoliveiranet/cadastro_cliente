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
                    decoration: const InputDecoration(
                      labelText: "Descrição",
                      border: OutlineInputBorder(),
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

  void _incluirNovoPais(BuildContext context) {
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
                    "Cadastrar um novo país",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    autofocus: true,
                    controller: descricaoController,
                    decoration: const InputDecoration(
                      labelText: "Nome do país",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Informe o nome do país";
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Cliente"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
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
                  border: OutlineInputBorder(),
                  label: const Text("Razão Social"),
                ),
                validator: (value) {
                  if (value == "" || value == null) {
                    return "Informe a razão social";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: nomeFantasiaController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: const Text("Nome Fantasia"),
                ),
                validator: (value) {
                  if (value == "" || value == null) {
                    return "Informe o nome fantasia";
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<RamoAtividade>(
                      decoration: const InputDecoration(
                        labelText: "Selecione um ramo atividade",
                        border: OutlineInputBorder(),
                      ),
                      isExpanded: true,
                      value: null,
                      items: [],
                      validator: (value) {
                        if (value == null) {
                          return "Selecione um ramo de atividade";
                        }
                        return null;
                      },
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
              TextFormField(
                controller: cnpjCpfController,
                keyboardType: TextInputType.text,
                inputFormatters: inputFormatters,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: _tipoPessoa == "F" ? "CPF" : "CNPJ",
                ),
                validator: (value) {
                  if (value == "" || value == null) {
                    return "Informe o CNPJ";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: inscricaoEstadualController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Inscricao Municipal"),
                ),
              ),
              TextFormField(
                controller: inscricaoMunicipalController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Inscricao Estadual"),
                ),
              ),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Email"),
                ),
              ),
              TextFormField(
                controller: homePageController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Home Page"),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<RamoAtividade>(
                      decoration: const InputDecoration(
                        labelText: "Selecione um país",
                        border: OutlineInputBorder(),
                      ),
                      isExpanded: true,
                      value: null,
                      items: [],
                      validator: (value) {
                        if (value == null) {
                          return "Selecione um país";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _incluirNovoPais(context);
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: cepController,
                      inputFormatters: [cepMask],
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Cep"),
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
                    onPressed: () {},
                    icon: const Icon(Icons.find_in_page),
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<RamoAtividade>(
                      decoration: const InputDecoration(
                        labelText: "Selecione o tipo do logradouro",
                        border: OutlineInputBorder(),
                      ),
                      isExpanded: true,
                      value: null,
                      items: [],
                      validator: (value) {
                        if (value == null) {
                          return "Selecione um tipo de logradouro";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                ],
              ),

              TextFormField(
                controller: logradouroCotroller,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Logradouro"),
                ),
                validator: (value) {
                  if (value == "" || value == null) {
                    return "Informe o logradouro";
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: numeroController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Número"),
                ),
                validator: (value) {
                  if (value == "" || value == null) {
                    return "Informe o número";
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: complementoController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Complemento"),
                ),
              ),

              TextFormField(
                controller: bairroController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Bairro"),
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Municipio"),
                ),
                validator: (value) {
                  if (value == "" || value == null) {
                    return "Informe o município";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: municipioController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Municipio"),
                ),
                validator: (value) {
                  if (value == "" || value == null) {
                    return "Informe o município";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: municipioController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Código do IBGE"),
                ),
                validator: (value) {
                  if (value == "" || value == null) {
                    return "Informe o código do IBGE";
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<RamoAtividade>(
                      decoration: const InputDecoration(
                        labelText: "Selecione um estado",
                        border: OutlineInputBorder(),
                      ),
                      isExpanded: true,
                      value: null,
                      items: [],
                      validator: (value) {
                        if (value == null) {
                          return "Selecione um estado";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final validation = formKey.currentState?.validate();

                        if (validation == true) {}
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        minimumSize: Size(200, 50),
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

    super.dispose();
  }
}
