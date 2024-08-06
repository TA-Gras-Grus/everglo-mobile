// To parse this JSON data, do
//
//     final listPlantType = listPlantTypeFromJson(jsonString);

import 'dart:convert';

ListPlantType listPlantTypeFromJson(String str) =>
    ListPlantType.fromJson(json.decode(str));

RecapList recapListFromJson(String str) => RecapList.fromJson(json.decode(str));

String listPlantTypeToJson(ListPlantType data) => json.encode(data.toJson());

String recapListToJson(RecapList data) => json.encode(data.toJson());

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

class RecapList {
  final List<Recap>? recap;

  RecapList({
    this.recap,
  });

  factory RecapList.fromJson(Map<String, dynamic> json) => RecapList(
        recap: json["recap"] == null
            ? []
            : List<Recap>.from(json["recap"]!.map((x) => Recap.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "recap": recap == null
            ? []
            : List<dynamic>.from(recap!.map((x) => x.toJson())),
      };
}

class Recap {
  final String? label;
  final int? weight;
  final String? unit;

  Recap({
    this.label,
    this.weight,
    this.unit,
  });

  factory Recap.fromJson(Map<String, dynamic> json) => Recap(
        label: json["label"],
        weight: json["weight"],
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "weight": weight,
        "unit": unit,
      };
}
