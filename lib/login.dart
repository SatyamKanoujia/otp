// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:otp/api_service.dart';
import 'package:otp/otp.dart';

class PhoneHome extends StatefulWidget {
  const PhoneHome({super.key});

  @override
  State<PhoneHome> createState() => _PhoneHomeState();
}

class _PhoneHomeState extends State<PhoneHome> {
  TextEditingController phonenumber = TextEditingController();
  bool isAPICallProcess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          Image.asset('images/otp.png'),
          const Center(
            child: Text(
              'Your Phone!',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 6),
            child: Text(
                "We will sent to One Time Password on this mobile number.",textAlign: TextAlign.center,),
          ),
          const SizedBox(
            height: 20,
          ),
          phonetext(),
          const SizedBox(
            height: 50,
          ),
          button(),
        ],
      ),
    );
  }

  Widget button() {
  return Center(
    child: ElevatedButton(
      onPressed: () async {
        if (phonenumber.text.length != 10) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Please enter a valid 10-digit phone number."),
              backgroundColor: Colors.red,
            )
          );
          return;
        }
        try {
          setState(() {
            isAPICallProcess = true;
          });
          var response = await APIService.otpLogin(phonenumber.text);
          setState(() {
            isAPICallProcess = false;
          });
          if (response.data != null) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => OtpPage(otpHash: response.data!, mobileNo: phonenumber.text),
              ),
              (route) => false,
            );
          }
        } catch (error) {
          setState(() {
            isAPICallProcess = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Failed to send OTP: $error"),
              backgroundColor: Colors.red,
            )
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 248, 182, 90),
        padding: const EdgeInsets.all(16.0),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 90),
        child: Text(
          "Receive OTP",
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}

  Widget phonetext() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        controller: phonenumber,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          prefix: Text("+91"),
          prefixIcon: Icon(Icons.phone),
          labelText: "Enter Phone Number",
          hintStyle: TextStyle(color: Colors.black),
          labelStyle: TextStyle(color: Colors.black),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
