import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:otp/config.dart';
import 'package:otp/otp_login_response_model.dart';

class APIService {
  static var client = http.Client();

  static Future<OtpLoginResponseModel> otpLogin(String mobileNo) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiURL, Config.otpLoginAPI);
    var response = await client.post(url,
        headers: requestHeaders,
        body: jsonEncode({"phone": mobileNo}));

    if (response.statusCode == 200) {
      return otpLoginResponseJSON(response.body);
    } else {
      throw Exception('Failed to login OTP: Status ${response.statusCode}');
    }
  }

  static Future<OtpLoginResponseModel> verifyOTP(
    String mobileNo,
    String otpHash,
    String otpCode,
) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiURL, Config.otpVerifyAPI);
    var requestBody = jsonEncode({
        "phone": mobileNo, "otp": otpHash, "hash": otpCode
    });

    var response = await client.post(url, headers: requestHeaders, body: requestBody);

    if (response.statusCode == 200) {
        return otpLoginResponseJSON(response.body);
    } else {
        throw Exception('Failed to verify OTP: Status ${response.statusCode}, Message: ${response.body}');
    }
}
}
