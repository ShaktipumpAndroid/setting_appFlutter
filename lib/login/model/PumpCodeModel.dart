// To parse this JSON data, do
//
//     final pumpCodeModel = pumpCodeModelFromJson(jsonString);

import 'dart:convert';

PumpCodeModel pumpCodeModelFromJson(String str) => PumpCodeModel.fromJson(json.decode(str));

String pumpCodeModelToJson(PumpCodeModel data) => json.encode(data.toJson());

class PumpCodeModel {
  PumpCodeModel({
    required this.status,
    required this.message,
    required this.response,
  });

  String status;
  String message;
  Response response;

  factory PumpCodeModel.fromJson(Map<String, dynamic> json) => PumpCodeModel(
    status: json["status"],
    message: json["message"],
    response: Response.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "response": response.toJson(),
  };
}

class Response {
  Response({
    required this.materialNumber,
  });

  String materialNumber;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    materialNumber: json["material number"],
  );

  Map<String, dynamic> toJson() => {
    "material number": materialNumber,
  };
}
