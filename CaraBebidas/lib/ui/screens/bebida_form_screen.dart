import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../models/bebida.dart';
import '../../providers/bebida_provider.dart';

class BebidaFormScreen extends StatefulWidget {
  final Bebida? bebidaParaEdicao;
  const BebidaFormScreen({super.key, this.bebidaParaEdicao});

  @override
  State<BebidaFormScreen> createState() => _BebidaFormScreenState();
}

class _BebidaFormScreenState extends State<BebidaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeCtrl = TextEditingController();
  final _catCtrl = TextEditingController();
  final _precoCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.bebidaParaEdicao != null) {
      _nomeCtrl.text = widget.bebidaParaEdicao!.nome;
      _catCtrl.text = widget.bebidaParaEdicao!.categoria;
      _precoCtrl.text = widget.bebidaParaEdicao!.preco.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Bebida')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: _nomeCtrl, decoration: const InputDecoration(labelText: 'Nome')),
              TextFormField(controller: _catCtrl, decoration: const InputDecoration(labelText: 'Categoria')),
              TextFormField(controller: _precoCtrl, decoration: const InputDecoration(labelText: 'Preço'), keyboardType: TextInputType.number),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final novaBebida = Bebida(
                      id: widget.bebidaParaEdicao?.id,
                      nome: _nomeCtrl.text,
                      categoria: _catCtrl.text,
                      preco: double.parse(_precoCtrl.text),
                    );
                    await context.read<BebidaProvider>().upsertBebida(novaBebida);
                    if (mounted) context.pop();
                  }
                },
                child: const Text('Salvar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}