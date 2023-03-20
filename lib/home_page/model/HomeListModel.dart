import 'dart:convert';

HomeListModel homeListModelFromJson(String str) => HomeListModel.fromJson(json.decode(str));

String homeListModelToJson(HomeListModel data) => json.encode(data.toJson());

class HomeListModel {
  HomeListModel({
    required this.status,
    required this.message,
    required this.response,
  });

  String status;
  String message;
  List<Response> response;

  factory HomeListModel.fromJson(Map<String, dynamic> json) => HomeListModel(
    status: json["status"],
    message: json["message"],
    response: List<Response>.from(json["response"].map((x) => Response.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "response": List<dynamic>.from(response.map((x) => x.toJson())),
  };
}

class Response {
  Response({
    required this.pmId,
    required this.parametersName,
    required this.modbusaddress,
    required this.mobBtAddress,
    required this.factor,
    required this.pValue,
    required this.materialCode,
    required this.unit,
    required this.offset,
  });

  int pmId;
  String parametersName;
  String modbusaddress;
  String mobBtAddress;
  int factor;
  int pValue;
  String materialCode;
  String unit;
  int offset;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    pmId: json["pmId"],
    parametersName: json["parametersName"],
    modbusaddress: json["modbusaddress"],
    mobBtAddress: json["mobBTAddress"],
    factor: json["factor"],
    pValue: json["pValue"],
    materialCode: json["materialCode"],
    unit: json["unit"],
    offset: json["offset"],
  );

  Map<String, dynamic> toJson() => {
    "pmId": pmId,
    "parametersName": parametersName,
    "modbusaddress": modbusaddress,
    "mobBTAddress": mobBtAddress,
    "factor": factor,
    "pValue": pValue,
    "materialCode": materialCode,
    "unit": unit,
    "offset": offset,
  };
}
