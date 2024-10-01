// To parse this JSON data, do
//
//     final responseData = responseDataFromJson(jsonString);

import 'dart:convert';

ResponseSuccess responseDataFromJson(String str) =>
    ResponseSuccess.fromJson(json.decode(str));

String responseDataToJson(ResponseSuccess data) => json.encode(data.toJson());

ResponseError responseErrorFromJson(String str) =>
    ResponseError.fromJson(json.decode(str));

String responseErrorToJson(ResponseError data) => json.encode(data.toJson());

class ResponseSuccess {
  final bool? success;
  final String? message;
  final Map<String, dynamic> data;

  ResponseSuccess({
    this.success,
    this.message,
    required this.data,
  });

  factory ResponseSuccess.fromJson(Map<String, dynamic> json) =>
      ResponseSuccess(
        success: json["success"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data,
      };
}

class ResponseError {
  final bool? success;
  final Errors? errors;
  final DataError? data;

  ResponseError({
    this.success,
    this.errors,
    this.data,
  });

  factory ResponseError.fromJson(Map<String, dynamic> json) => ResponseError(
        success: json["success"],
        errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
        data: json["data"] == null ? null : DataError.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "errors": errors?.toJson(),
        "data": data?.toJson(),
      };
}

class DataError {
  DataError();

  factory DataError.fromJson(Map<String, dynamic> json) => DataError();

  Map<String, dynamic> toJson() => {};
}

class Errors {
  final String? name;
  final String? message;

  Errors({
    this.name,
    this.message,
  });

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        name: json["name"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "message": message,
      };
}

class Paging {
  final int? currentPage;
  final int? totalPage;
  final int? size;

  Paging({
    this.currentPage,
    this.totalPage,
    this.size,
  });

  factory Paging.fromJson(Map<String, dynamic> json) => Paging(
        currentPage: json["current_page"],
        totalPage: json["total_page"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "total_page": totalPage,
        "size": size,
      };
}
