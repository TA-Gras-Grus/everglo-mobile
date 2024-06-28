// To parse this JSON data, do
//
//     final listPlantType = listPlantTypeFromJson(jsonString);

import 'dart:convert';

ListPlantType listPlantTypeFromJson(String str) =>
    ListPlantType.fromJson(json.decode(str));

String listPlantTypeToJson(ListPlantType data) => json.encode(data.toJson());

class ListPlantType {
  final List<PlantType>? plantType;

  ListPlantType({
    this.plantType,
  });

  factory ListPlantType.fromJson(Map<String, dynamic> json) => ListPlantType(
        plantType: json["plantType"] == null
            ? []
            : List<PlantType>.from(
                json["plantType"]!.map((x) => PlantType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "plantType": plantType == null
            ? []
            : List<dynamic>.from(plantType!.map((x) => x.toJson())),
      };
}

class PlantType {
  final String? plantTypeId;
  final String? name;
  final int? totalPolybag;
  final String? polybagSize;

  PlantType({
    this.plantTypeId,
    this.name,
    this.totalPolybag,
    this.polybagSize,
  });

  factory PlantType.fromJson(Map<String, dynamic> json) => PlantType(
        plantTypeId: json["plantTypeId"],
        name: json["name"],
        totalPolybag: json["totalPolybag"],
        polybagSize: json["polybagSize"],
      );

  Map<String, dynamic> toJson() => {
        "plantTypeId": plantTypeId,
        "name": name,
        "totalPolybag": totalPolybag,
        "polybagSize": polybagSize,
      };
}
