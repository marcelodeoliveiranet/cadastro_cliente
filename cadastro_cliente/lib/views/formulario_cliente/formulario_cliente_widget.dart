import 'package:cadastro_cliente/model/ramo_atividade.dart';
import 'package:flutter/material.dart';

class FormularioClienteWidget extends StatefulWidget {
  const FormularioClienteWidget({super.key});

  @override
  State<FormularioClienteWidget> createState() =>
      _FormularioClienteWidgetState();
}

class _FormularioClienteWidgetState extends State<FormularioClienteWidget> {
  final formKey = GlobalKey<FormState>();
  //String? _tipoPessoa;
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
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: cnpjCpfController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("CNPJ"),
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
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: cepController,
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
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
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
                      onChanged: (value) {
                        setState(() {});
                      },
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
}
