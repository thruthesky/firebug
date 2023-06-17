import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PhoneSigninScreen extends StatefulWidget {
  const PhoneSigninScreen({super.key});

  static const String routeName = '/phone-signin';

  @override
  State<PhoneSigninScreen> createState() => _PhoneSigninScreenState();
}

class _PhoneSigninScreenState extends State<PhoneSigninScreen> {
  final phoneNumber = TextEditingController(text: "+82 10 1234 5678");
  final smsCode = TextEditingController();
  String? verificationId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Phone Signin'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Text('Phone Signin'),
              const SizedBox(height: 16),
              TextField(
                controller: phoneNumber,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: phoneNumber.text,
                    verificationCompleted: (PhoneAuthCredential credential) {
                      // 안드로이드에서만 동작
                      // 자동으로 SMS 코드 인증.
                    },
                    verificationFailed: (FirebaseAuthException e) {},
                    codeSent: (String verificationId, int? resendToken) async {
                      // 전화번호가 인증되고, SMS 코드가 전송되었을 때,
                      // Update the UI - wait for the user to enter the SMS code
                      // ...
                      print('---> sms code sent;');
                      this.verificationId = verificationId;
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {
                      // 안드로이드에서만 동작.
                      // 자동으로 SMS 코드 인증이 실패했을 때, (시간 초과 등 ...)
                    },
                  );
                },
                child: const Text('인증 코드 전송'),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: smsCode,
                decoration: const InputDecoration(
                  labelText: '인증 코드',
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    // Create a PhoneAuthCredential with the code
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(verificationId: verificationId!, smsCode: smsCode.text);

                    // Sign the user in (or link) with the credential
                    await FirebaseAuth.instance.signInWithCredential(credential);
                    context.pop();
                  },
                  child: const Text('인증 코드 확인')),
            ],
          ),
        ));
  }
}
