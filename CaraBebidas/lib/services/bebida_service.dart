import 'package:dio/dio.dart';
import '../models/bebida.dart';

class BebidaService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://bebidas-alcool.free.beeceptor.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  BebidaService() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException e, handler) {
          print('API Error: ${e.message}');
          print('Response: ${e.response?.data}');
          return handler.next(e);
        },
      ),
    );
  }

  Future<List<Bebida>> getBebidas() async {
    try {
      final response = await _dio.get('/api/bebidas');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data is List ? response.data : [];
        return data.map((e) => Bebida.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load bebidas: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching bebidas: $e');
      rethrow;
    }
  }

  Future<void> saveBebida(Bebida bebida) async {
    try {
      final data = bebida.toJson();
      if (bebida.id == null) {
        final response = await _dio.post('/api/bebidas', data: data);
        if (response.statusCode != 200 && response.statusCode != 201) {
          throw Exception('Failed to create bebida: ${response.statusCode}');
        }
      } else {
        final response = await _dio.put(
          '/api/bebidas/${bebida.id}',
          data: data,
        );
        if (response.statusCode != 200) {
          throw Exception('Failed to update bebida: ${response.statusCode}');
        }
      }
    } catch (e) {
      print('Error saving bebida: $e');
      rethrow;
    }
  }

  Future<void> deleteBebida(int id) async {
    try {
      final response = await _dio.delete('/api/bebidas/$id');
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Failed to delete bebida: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting bebida: $e');
      rethrow;
    }
  }
}
