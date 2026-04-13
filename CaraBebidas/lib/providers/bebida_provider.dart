import 'package:flutter/material.dart';
import '../models/bebida.dart';
import '../services/bebida_service.dart';

class BebidaProvider with ChangeNotifier {
  final _service = BebidaService();
  List<Bebida> bebidas = [];
  bool isLoading = false;

  Future<void> fetchBebidas() async {
    isLoading = true;
    notifyListeners();
    try {
      bebidas = await _service.getBebidas();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> removeBebida(int id) async {
    await _service.deleteBebida(id);
    bebidas.removeWhere((b) => b.id == id);
    notifyListeners();
  }

  Future<void> upsertBebida(Bebida bebida) async {
    await _service.saveBebida(bebida);
    await fetchBebidas();
  }
}