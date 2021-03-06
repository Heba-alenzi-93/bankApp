import 'dart:io';
import 'package:bank_app/Pages/home_page.dart';
import 'package:bank_app/models/user.dart';
import 'package:bank_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

import '../widgets/add_form.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var _image;
  final _picker = ImagePicker();
  final _username = TextEditingController();
  String text = "test";
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Center(
          child: Form(
            child: Column(
              // mainAxisSize: MainAxisSize.min,

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign Up ",
                  style: TextStyle(fontSize: 50),
                ),
                SizedBox(
                  height: 20,
                ),

// ****************** Image Picker **************************
                GestureDetector(
                  onTap: () async {
                    final XFile? image =
                        await _picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      _image = File(image!.path);
                    });
                  },
                  child: Container(
                    width: 200,
                    height: 200,
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFDDDDDD),
                    ),
                    child: _image != null
                        ? CircleAvatar(
                            backgroundImage: new FileImage(_image),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFDDDDDD)),
                            width: 200,
                            height: 200,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.grey[800],
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                textField(
                  controller: _username,
                  text: "Enter your username",
                  icon: Icon(Icons.person),
                  hiddenText: false,
                ),
                SizedBox(
                  height: 10,
                ),
                textField(
                  controller: _password,
                  text: "Enter your password",
                  icon: Icon(Icons.password_rounded),
                  hiddenText: true,
                ),
                 SizedBox(
                  height: 25,
                ),
                Container(
                    width: 250,
                    height: 55,
                    child: ElevatedButton(
                        onPressed: () {
                          context.read<AuthProvider>().signup(
                                user: User(
                                    username: _username.text,
                                    password: _password.text),
                              );

                          context.go('/home-page');
                        },
                        child: Text(
                          "Sign up",
                        ),
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))))),
              ],
            ),
          ),
        )));
  }
}

class textField extends StatelessWidget {
  const textField({
    Key? key,
    required this.controller,
    required this.text,
    required this.icon,
    required this.hiddenText,

  }) : super(key: key);

  final TextEditingController controller;
  final String text;
  final Icon icon;
  final bool hiddenText; 

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: TextField(
        obscureText: hiddenText,
        controller: controller,
        decoration: InputDecoration(
            hintText: text,
            prefixIcon: icon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            )),
      ),
    );
  }
}

// class textFieldpassword extends StatelessWidget {
//   const textFieldpassword({
//     Key? key,
//     required this.controller,
//     required this.text,
//   }) : super(key: key);

//   final TextEditingController controller;
//   final String text;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 250,
//       child: TextField(
//         controller: controller,
//         obscureText: true,
//         decoration: InputDecoration(
//             hintText: text,
//             prefixIcon: Icon(Icons.password_sharp),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//             )),
//       ),
//     );
//   }
// }
