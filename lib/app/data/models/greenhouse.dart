// To parse this JSON data, do
//
//     final greenhouse = greenhouseFromJson(jsonString);

import 'dart:convert';

import 'package:everglo_mobile/app/data/models/Response.dart';

Greenhouse greenhouseFromJson(String str) =>
    Greenhouse.fromJson(json.decode(str));

GreenhouseSum greenhouseSumFromJson(String str) =>
    GreenhouseSum.fromJson(json.decode(str));

ListGreenhouse listGreenhouseFromJson(String str) =>
    ListGreenhouse.fromJson(json.decode(str));

List<GreenhouseSum> listGreenhouseSumFromJson(String str) =>
    List<GreenhouseSum>.from(
        json.decode(str).map((x) => GreenhouseSum.fromJson(x)));

String greenhouseToJson(Greenhouse data) => json.encode(data.toJson());

String greenhouseSumToJson(GreenhouseSum data) => json.encode(data.toJson());

String listGreenhouseToJson(ListGreenhouse data) => json.encode(data.toJson());

String listGreenhouseSumToJson(List<GreenhouseSum> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Greenhouse {
  final String? greenhouseId;
  final String? owned;
  final String? name;
  final bool? statusWaterFlow;
  final bool? statusBlower;
  final bool? statusHeater;
  final int? intervalWaterFlow;
  final int? timeWaterFlow;
  final double? ec;
  final double? ph;
  final double? ppm;
  final num? totalPolybag;
  final num? activePolybag;
  final bool? statusWaterTank;
  final int? countWaterFlow;
  final String? apiKey;
  final String? waterTankDevice;
  final String? dripIrrigationDevice;
  final String? heaterBlowerDevice;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  List<GreenhouseData>? greenhouseDatas;

  Greenhouse({
    this.greenhouseId,
    this.owned,
    this.name,
    this.statusWaterFlow,
    this.statusBlower,
    this.statusHeater,
    this.intervalWaterFlow,
    this.timeWaterFlow,
    this.ec,
    this.ph,
    this.ppm,
    this.activePolybag,
    this.totalPolybag,
    this.statusWaterTank,
    this.countWaterFlow,
    this.apiKey,
    this.waterTankDevice,
    this.dripIrrigationDevice,
    this.heaterBlowerDevice,
    this.createdAt,
    this.updatedAt,
    this.greenhouseDatas,
  });

  factory Greenhouse.fromJson(Map<String, dynamic> json) => Greenhouse(
        greenhouseId: json["greenhouseId"],
        owned: json["owned"],
        name: json["name"],
        statusWaterFlow: json["statusWaterFlow"],
        statusBlower: json["statusBlower"],
        statusHeater: json["statusHeater"],
        intervalWaterFlow: json["intervalWaterFlow"],
        timeWaterFlow: json["timeWaterFlow"],
        ec: json["ec"]?.toDouble(),
        ph: json["ph"]?.toDouble(),
        ppm: json["ppm"]?.toDouble(),
        totalPolybag: json["totalPolybag"]?.toDouble(),
        activePolybag: json["activePolybag"]?.toDouble(),
        statusWaterTank: json["statusWaterTank"],
        countWaterFlow: json["countWaterFlow"],
        apiKey: json["apiKey"],
        waterTankDevice: json["waterTankDevice"] ?? "",
        dripIrrigationDevice: json["dripIrrigationDevice"] ?? "",
        heaterBlowerDevice: json["heaterBlowerDevice"] ?? "",
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        greenhouseDatas: json["greenhouseDatas"] == null
            ? []
            : List<GreenhouseData>.from(json["greenhouseDatas"]!
                .map((x) => GreenhouseData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "greenhouseId": greenhouseId,
        "owned": owned,
        "name": name,
        "statusWaterFlow": statusWaterFlow,
        "statusBlower": statusBlower,
        "statusHeater": statusHeater,
        "intervalWaterFlow": intervalWaterFlow,
        "timeWaterFlow": timeWaterFlow,
        "ec": ec,
        "ph": ph,
        "ppm": ppm,
        "activePolybag": activePolybag,
        "totalPolybag": totalPolybag,
        "statusWaterTank": statusWaterTank,
        "countWaterFlow": countWaterFlow,
        "apiKey": apiKey,
        "waterTankDevice": waterTankDevice,
        "dripIrrigationDevice": dripIrrigationDevice,
        "heaterBlowerDevice": heaterBlowerDevice,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "greenhouseDatas": greenhouseDatas == null
            ? []
            : List<dynamic>.from(greenhouseDatas!.map((x) => x.toJson())),
      };
}

class GreenhouseData {
  final String? greenhouseDataId;
  final String? ownedGreenhouse;
  double? airTemperature;
  double? humidity;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  GreenhouseData({
    this.greenhouseDataId,
    this.ownedGreenhouse,
    this.airTemperature,
    this.humidity,
    this.createdAt,
    this.updatedAt,
  });

  factory GreenhouseData.fromJson(Map<String, dynamic> json) => GreenhouseData(
        greenhouseDataId: json["greenhouseDataId"],
        ownedGreenhouse: json["ownedGreenhouse"],
        airTemperature: json["airTemperature"]?.toDouble(),
        humidity: json["humidity"]?.toDouble(),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "greenhouseDataId": greenhouseDataId,
        "ownedGreenhouse": ownedGreenhouse,
        "airTemperature": airTemperature,
        "humidity": humidity,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class GreenhouseSum {
  final String? greenhouseId;
  final String? owned;
  final String? name;

  GreenhouseSum({
    this.greenhouseId,
    this.owned,
    this.name,
  });

  factory GreenhouseSum.fromJson(Map<String, dynamic> json) => GreenhouseSum(
        greenhouseId: json["greenhouseId"],
        owned: json["owned"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "greenhouseId": greenhouseId,
        "owned": owned,
        "name": name,
      };
}

class ListGreenhouse {
  final List<Greenhouse>? greenhouse;
  final Paging? paging;

  ListGreenhouse({
    this.greenhouse,
    this.paging,
  });

  factory ListGreenhouse.fromJson(Map<String, dynamic> json) => ListGreenhouse(
        greenhouse: json["greenhouse"] == null
            ? []
            : List<Greenhouse>.from(
                json["greenhouse"]!.map((x) => Greenhouse.fromJson(x))),
        paging: json["paging"] == null ? null : Paging.fromJson(json["paging"]),
      );

  Map<String, dynamic> toJson() => {
        "greenhouse": greenhouse == null
            ? []
            : List<dynamic>.from(greenhouse!.map((x) => x.toJson())),
        "paging": paging?.toJson(),
      };
}

class ListGreenhouseSum {
  final List<GreenhouseSum>? greenhouse;

  ListGreenhouseSum({
    this.greenhouse,
  });

  factory ListGreenhouseSum.fromJson(Map<String, dynamic> json) =>
      ListGreenhouseSum(
        greenhouse: json["greenhouse"] == null
            ? []
            : List<GreenhouseSum>.from(
                json["greenhouse"]!.map((x) => GreenhouseSum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "greenhouse": greenhouse == null
            ? []
            : List<dynamic>.from(greenhouse!.map((x) => x.toJson())),
      };
}
