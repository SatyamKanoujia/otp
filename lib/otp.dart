// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:otp/home.dart';
import 'package:pinput/pinput.dart';
import 'package:otp/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpPage extends StatefulWidget {
  final String? otpHash;
  final String? mobileNo;

  const OtpPage({super.key, required this.otpHash, required this.mobileNo});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String _otpCode = '';
  final int _otpCodeLength = 4;
  bool isAPICallProcess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('images/otp.png', height: 330, width: 330),
            const Center(
              child: Text("OTP Verification", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 6),
              child: Text("Enter OTP sent to your Mobile Number", textAlign: TextAlign.center),
            ),
            const SizedBox(height: 20),
            _buildPinput(),
            const SizedBox(height: 80),
            _buildVerifyButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPinput() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Pinput(
          length: _otpCodeLength,
          onChanged: (value) => setState(() => _otpCode = value),
        ),
      ),
    );
  }

  Widget _buildVerifyButton() {
    return Center(
      child: ElevatedButton(
        onPressed: isAPICallProcess ? null : () async {
          setState(() => isAPICallProcess = true);
          try {
            var response = await APIService.verifyOTP(widget.mobileNo!, _otpCode, widget.otpHash!);
            if (response.data != null) {
              await _storePhoneNumber(widget.mobileNo!);  
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false,
              );
            } else {
              throw Exception('OTP verification failed: ${response.message}');
            }
          } catch (error) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Failed to verify OTP: $error"),
              backgroundColor: Colors.red,
            ));
          } finally {
            setState(() => isAPICallProcess = false);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 248, 182, 90),
          padding: const EdgeInsets.all(16.0),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 80),
          child: Text("Verify & Proceed", style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Future<void> _storePhoneNumber(String phoneNumber) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('phoneNumber', phoneNumber);
  }
}
