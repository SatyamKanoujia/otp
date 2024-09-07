// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

class OtpLoginResponseModel {
  final String message;
  final String? data;

  OtpLoginResponseModel({
    required this.message,
    this.data,
  });

  factory OtpLoginResponseModel.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      throw const FormatException("Null JSON provided to OtpLoginResponseModel");
    }
    return OtpLoginResponseModel(
      message: json['message'] ?? 'No message provided',
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data,
    };
  }
}

OtpLoginResponseModel otpLoginResponseJSON(String str) =>
    OtpLoginResponseModel.fromJson(json.decode(str));
