// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:v1_micro_finance/configs/routes/routes_name.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  File? uploadedImage;

  // Function to pick an image
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1000,
      maxHeight: 1000,
      imageQuality: 85,
    );
    if (pickedFile != null &&
        (await File(pickedFile.path).length() <= 10 * 1024 * 1024)) {
      setState(() {
        uploadedImage = File(pickedFile.path);
      });
    } else {
      setState(() {
        uploadedImage = null;
      });
    }
  }

  // API Call
  Future<void> registerUser(BuildContext context) async {
    const String apiUrl = "http://3000.com/api/signup";

    try {
      final request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.fields['name'] = fullNameController.text;
      request.fields['email'] = emailController.text;
      request.fields['password'] = passwordController.text;
      request.fields['confirmPassword'] = confirmPasswordController.text;

      if (uploadedImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'profileImage',
          uploadedImage!.path,
          contentType: MediaType('image', 'jpeg'),
        ));
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final data = jsonDecode(responseData);

        if (data['status'] == 'success') {
          Navigator.pushNamed(context, RoutesName.verificationScreen);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'])),
          );
        }
      } else {
        throw Exception("Failed to register user.");
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $error")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Signup')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildTextField(fullNameController, 'Full Name'),
              buildTextField(emailController, 'Email',
                  keyboardType: TextInputType.emailAddress),
              buildTextField(passwordController, 'Password', obscureText: true),
              buildTextField(confirmPasswordController, 'Confirm Password',
                  obscureText: true),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: pickImage,
                child: Text("Upload Image (PNG/JPG, max 10MB)"),
              ),
              if (uploadedImage != null) ...[
                SizedBox(height: 10),
                Image.file(uploadedImage!, height: 100),
              ],
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    registerUser(context);
                  }
                },
                child: Text('Signup', style: TextStyle(fontSize: 18)),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, RoutesName.signInScreen),
                child: Text('Already? Sign in', style: TextStyle(fontSize: 14)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String labelText,
      {bool obscureText = false,
      TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $labelText';
          }
          return null;
        },
      ),
    );
  }
}
