import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:transito_ui/models/placas.dart';

class MultasProvider extends ChangeNotifier {
  List<MultasResponse> _multas = [];

  List<MultasResponse> get multas => _multas;

  Future<void> fetchMultas() async {
    try {
      final response = await Dio().get('http://localhost:3000/multas/multas');
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data;
        final List<MultasResponse> multasResponseList = jsonList.map((json) => MultasResponse.fromJson(json)).toList();
        _multas = multasResponseList;
        notifyListeners();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load data: ${e.toString()}');
    }
  }
}
