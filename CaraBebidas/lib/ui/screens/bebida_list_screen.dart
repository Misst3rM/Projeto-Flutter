import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../providers/bebida_provider.dart';

class BebidaListScreen extends StatelessWidget {
  const BebidaListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BebidaProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Depósito de Bebidas')),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: provider.bebidas.length,
              itemBuilder: (context, index) {
                final bebida = provider.bebidas[index];
                return ListTile(
                  title: Text(bebida.nome),
                  subtitle: Text('${bebida.categoria} - R\$ ${bebida.preco.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => provider.removeBebida(bebida.id!),
                  ),
                  onTap: () => context.push('/form', extra: bebida),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.push('/form'),
      ),
    );
  }
}