// To parse this JSON data, do
//
//     final polybags = polybagsFromJson(jsonString);

import 'dart:convert';

import 'package:everglo_mobile/app/data/models/Response.dart';

Polybags polybagsFromJson(String str) => Polybags.fromJson(json.decode(str));

AiPrediction aiPredictionFromJson(String str) =>
    AiPrediction.fromJson(json.decode(str));

String polybagsToJson(Polybags data) => json.encode(data.toJson());

String aiPredictionToJson(AiPrediction data) => json.encode(data.toJson());

class Polybags {
  final List<Polybag>? polybag;
  final Paging? paging;

  Polybags({
    this.polybag,
    this.paging,
  });

  factory Polybags.fromJson(Map<String, dynamic> json) => Polybags(
        polybag: json["polybag"] == null
            ? []
            : List<Polybag>.from(
                json["polybag"]!.map((x) => Polybag.fromJson(x))),
        paging: json["paging"] == null ? null : Paging.fromJson(json["paging"]),
      );

  Map<String, dynamic> toJson() => {
        "polybag": polybag == null
            ? []
            : List<dynamic>.from(polybag!.map((x) => x.toJson())),
        "paging": paging?.toJson(),
      };
}

class Polybag {
  final String? polybagId;
  final String? ownedGreenhouse;
  final String? ownedPlantType;
  final String? namePlantType;
  final String? generalSize;
  final String? greenhouseName;
  final String? growthType;
  final bool? isActive;
  final DateTime? dayOfPlanted;
  final dynamic weightOfHarvest;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<PolybagData>? polybagDatas;

  Polybag({
    this.polybagId,
    this.ownedGreenhouse,
    this.ownedPlantType,
    this.namePlantType,
    this.generalSize,
    this.greenhouseName,
    this.growthType,
    this.isActive,
    this.dayOfPlanted,
    this.weightOfHarvest,
    this.createdAt,
    this.updatedAt,
    this.polybagDatas,
  });

  factory Polybag.fromJson(Map<String, dynamic> json) => Polybag(
        polybagId: json["polybagId"],
        ownedGreenhouse: json["ownedGreenhouse"],
        ownedPlantType: json["ownedPlantType"],
        namePlantType: json["namePlantType"],
        generalSize: json["generalSize"],
        greenhouseName: json["greenhouseName"],
        growthType: json["growthType"],
        isActive: json["isActive"],
        dayOfPlanted: json["dayOfPlanted"] == null
            ? null
            : DateTime.parse(json["dayOfPlanted"]),
        weightOfHarvest: json["weightOfHarvest"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        polybagDatas: json["polybagDatas"] == null
            ? []
            : List<PolybagData>.from(
                json["polybagDatas"]!.map((x) => PolybagData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "polybagId": polybagId,
        "ownedGreenhouse": ownedGreenhouse,
        "ownedPlantType": ownedPlantType,
        "namePlantType": namePlantType,
        "generalSize": generalSize,
        "greenhouseName": greenhouseName,
        "growthType": growthType,
        "isActive": isActive,
        "dayOfPlanted": dayOfPlanted?.toIso8601String(),
        "weightOfHarvest": weightOfHarvest,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "polybagDatas": polybagDatas == null
            ? []
            : List<dynamic>.from(polybagDatas!.map((x) => x.toJson())),
      };
}

class PolybagData {
  final String? polybagDataId;
  final String? ownedPolybag;
  final int? dayAfterPlanted;
  final double? ec;
  final double? n;
  final double? p;
  final double? k;
  final double? ph;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PolybagData({
    this.polybagDataId,
    this.ownedPolybag,
    this.dayAfterPlanted,
    this.ec,
    this.n,
    this.p,
    this.k,
    this.ph,
    this.createdAt,
    this.updatedAt,
  });

  factory PolybagData.fromJson(Map<String, dynamic> json) => PolybagData(
        polybagDataId: json["polybagDataId"],
        ownedPolybag: json["ownedPolybag"],
        dayAfterPlanted: json["dayAfterPlanted"],
        ec: json["ec"]?.toDouble(),
        n: json["n"]?.toDouble(),
        p: json["p"]?.toDouble(),
        k: json["k"]?.toDouble(),
        ph: json["ph"]?.toDouble(),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "polybagDataId": polybagDataId,
        "ownedPolybag": ownedPolybag,
        "dayAfterPlanted": dayAfterPlanted,
        "ec": ec,
        "n": n,
        "p": p,
        "k": k,
        "ph": ph,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class AiPrediction {
  final List<AiPredictionElement>? aiPrediction;

  AiPrediction({
    this.aiPrediction,
  });

  factory AiPrediction.fromJson(Map<String, dynamic> json) => AiPrediction(
        aiPrediction: json["aiPrediction"] == null
            ? []
            : List<AiPredictionElement>.from(json["aiPrediction"]!
                .map((x) => AiPredictionElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "aiPrediction": aiPrediction == null
            ? []
            : List<dynamic>.from(aiPrediction!.map((x) => x.toJson())),
      };
}

class AiPredictionElement {
  final String? aiPredictionId;
  final String? owned;
  final int? dayAfterPlanted;
  final double? ec;
  final int? n;
  final int? p;
  final int? k;
  final int? ph;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AiPredictionElement({
    this.aiPredictionId,
    this.owned,
    this.dayAfterPlanted,
    this.ec,
    this.n,
    this.p,
    this.k,
    this.ph,
    this.createdAt,
    this.updatedAt,
  });

  factory AiPredictionElement.fromJson(Map<String, dynamic> json) =>
      AiPredictionElement(
        aiPredictionId: json["aiPredictionId"],
        owned: json["owned"],
        dayAfterPlanted: json["dayAfterPlanted"],
        ec: json["ec"]?.toDouble(),
        n: json["n"],
        p: json["p"],
        k: json["k"],
        ph: json["ph"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "aiPredictionId": aiPredictionId,
        "owned": owned,
        "dayAfterPlanted": dayAfterPlanted,
        "ec": ec,
        "n": n,
        "p": p,
        "k": k,
        "ph": ph,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
