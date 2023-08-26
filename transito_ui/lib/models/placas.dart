// To parse this JSON data, do
//
//     final multasResponse = multasResponseFromJson(jsonString);

import 'dart:convert';

List<MultasResponse> multasResponseFromJson(String str) => List<MultasResponse>.from(json.decode(str).map((x) => MultasResponse.fromJson(x)));

String multasResponseToJson(List<MultasResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MultasResponse {
  final int id;
  final String placa;
  final String motivo;
  final DateTime fechaHoraInfraccion;
  final String correo;

  MultasResponse({
    required this.id,
    required this.placa,
    required this.motivo,
    required this.fechaHoraInfraccion,
    required this.correo,
  });

  factory MultasResponse.fromJson(Map<String, dynamic> json) => MultasResponse(
    id: json["id"],
    placa: json["placa"],
    motivo: json["motivo"],
    fechaHoraInfraccion: DateTime.parse(json["fecha_hora_infraccion"]),
    correo: json["correo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "placa": placa,
    "motivo": motivo,
    "fecha_hora_infraccion": fechaHoraInfraccion.toIso8601String(),
    "correo": correo,
  };
}
