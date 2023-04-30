import 'package:flutter/material.dart';
import 'package:spark/resoursers/auth_methods.dart';
import 'package:spark/screens/signup_screen.dart';
import 'package:spark/utils/colors.dart';
import 'package:spark/utils/dimensions.dart';
import 'package:spark/utils/utils.dart';
import 'package:spark/widgets/text_feild_input.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_leyout.dart';
import '../responsive/web_screen_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
      email: emailController.text,
      password: passwordController.text,
    );
    if (res == 'success' && context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLeyout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout(),
          ),
        ),
      );
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  navigatoSignUp() {
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
        padding: MediaQuery.of(context).size.width > webScreenSize
            ? EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 3)
            : const EdgeInsets.symmetric(
                horizontal: 32,
              ),
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
              const SizedBox(
                height: 50,
              ),
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

              const SizedBox(height: 24),
              //button login
              InkWell(
                onTap: () => loginUser(),
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
                    child: const Text('Dont have an accont'),
                  ),
                  GestureDetector(
                    onTap: () => navigatoSignUp(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        ' SignnUp?',
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
