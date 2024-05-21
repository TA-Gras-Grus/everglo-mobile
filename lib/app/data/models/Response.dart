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

  ResponseError({
    this.success,
    this.errors,
  });

  factory ResponseError.fromJson(Map<String, dynamic> json) => ResponseError(
        success: json["success"],
        errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "errors": errors?.toJson(),
      };
}

class Errors {
  final String? name;
  final String? message;
  final Map<String, dynamic>? data;

  Errors({
    this.name,
    this.message,
    this.data,
  });

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        name: json["name"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "message": message,
        "data": data,
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
