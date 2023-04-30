import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spark/resoursers/auth_methods.dart';
import 'package:spark/responsive/mobile_screen_layout.dart';
import 'package:spark/responsive/responsive_leyout.dart';
import 'package:spark/responsive/web_screen_layout.dart';
import 'package:spark/utils/colors.dart';
import 'package:spark/utils/utils.dart';
import 'package:spark/widgets/text_feild_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    bioController.dispose();
    usernameController.dispose();
  }

  Future<void> selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  Future<void> signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: emailController.text,
      password: passwordController.text,
      username: usernameController.text,
      bio: bioController.text,
      file: _image!,
    );
    if (res != 'success' && context.mounted) {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLeyout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout(),
          ),
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  navigatoLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //svg image
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                'assets/images/tunder.png',
                width: 300,
                height: 300,
              ),
              Text(
                'SPARK',
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 30),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 65,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 65,
                          backgroundImage: NetworkImage(
                            'https://cdn5.vectorstock.com/i/1000x1000/79/69/thunder-in-head-vector-67969.jpg',
                          ),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: () => selectImage(),
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              //text field input for username

              TextFieldInput(
                textEditingController: usernameController,
                isPass: false,
                hintText: 'Username..',
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 20),

              //text field input for emaijl

              TextFieldInput(
                textEditingController: emailController,
                isPass: false,
                hintText: 'Email..',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              //text field input for password
              TextFieldInput(
                textEditingController: passwordController,
                isPass: true,
                hintText: 'Password..',
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 20),
//text field input for bio

              TextFieldInput(
                textEditingController: bioController,
                isPass: false,
                hintText: 'bio..',
                textInputType: TextInputType.text,
              ),

              const SizedBox(height: 24),
              //button login
              InkWell(
                onTap: () => signUpUser(),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: const ShapeDecoration(
                    color: blueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: primaryColor,
                        )
                      : const Text('Log in'),
                ),
              ),
              const SizedBox(height: 24),
              //transitioning to signing up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text('Already hava an account'),
                  ),
                  GestureDetector(
                    onTap: () => navigatoLogin(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        ' Login?',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
