// ignore_for_file: unused_local_variable, use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/Welcome/welcome_screen.dart';
import 'package:food_delivery/assets/fonts/app_font.dart';
import 'package:food_delivery/components/already_have_an_account.dart';
import 'package:food_delivery/components/session.dart';
import 'package:food_delivery/constanst.dart';
import 'package:food_delivery/homepage/controller/user_details.dart';
import 'package:food_delivery/homepage/screens/home/homepage.dart';
import 'package:food_delivery/login/login_screen.dart';
import 'package:get/get.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _passwordController = TextEditingController();
  UserDetails userDetails = Get.find();
  bool _isLoading = false;
  DatabaseReference userdata = WelcomeScreen.databaseuser;
  void signUpWithEmailAndPassword() async {
    setState(() {
      _isLoading = true;
    });
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      )
          .then((val) {
        SessionManager.getLocation().then((value) {
          userdata.child(val.user!.uid).set({
            'name': _nameController.text,
            'phone_number': _numberController.text,
            'address': value['address'],
            'city': value['city'],
            'email': _emailController.text,
          }).then((a) {
            userDetails.updatemail(_emailController.text);
            userDetails.updatename(_nameController.text);
            userDetails.updatenumber(_numberController.text);
            userDetails.updateuid(val.user!.uid);
            SessionManager.setLoggedIn(true, val.user!.uid);
            Get.snackbar("User Added Successfully", "");
          }).onError((error, stackTrace) {
            debugPrint(error.toString());
            debugPrint(stackTrace.toString());
            Get.snackbar("Error in saving details", error.toString());
          });
        });
        return val;
      });

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        getsnackbar("Error Password Weak",
            "Please use a strong password with a combination of numbers and letters");
      } else if (e.code == 'email-already-in-use') {
        getsnackbar("Already used email",
            "The email input is already in use try with a different account");
      } else if (e.code == 'invalid-email') {
        getsnackbar("Wrong Email",
            "The email input is wrong try giving a valid maid id");
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: ListView(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kprimaryColor,
            controller: _nameController,
            validator: (value) {
              if (value!.isEmpty) {
                return "Name field can't be empty";
              }
              return null;
            },
            onSaved: (name) {},
            decoration: const InputDecoration(
              hintText: "Enter Name",
              prefixIcon: Padding(
                padding: EdgeInsets.all(kdefaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: kdefaultPadding - 4),
            child: TextFormField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              cursorColor: kprimaryColor,
              controller: _numberController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Phone field can't be empty";
                } else if (value.length != 10) {
                  return "Please enter a valid Phone number";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: "Enter Phone Number",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(kdefaultPadding),
                  child: Icon(Icons.phone),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: kdefaultPadding - 4),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kprimaryColor,
              controller: _emailController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Email field can't be empty";
                }
                return null;
              },
              onSaved: (email) {},
              decoration: const InputDecoration(
                hintText: "Enter Email",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(kdefaultPadding),
                  child: Icon(Icons.email),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kdefaultPadding - 4),
            child: TextFormField(
              controller: _passwordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Password Field can't be empty";
                }
                return null;
              },
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kprimaryColor,
              decoration: const InputDecoration(
                  hintText: "Enter Password",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(kdefaultPadding),
                    child: Icon(Icons.lock),
                  )),
            ),
          ),
          const SizedBox(height: kdefaultPadding),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Hero(
                  tag: "signup_btn",
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        signUpWithEmailAndPassword();
                      }
                    },
                    child: Text(
                      "SignUp".toUpperCase(),
                      style: AppFont.headText(),
                    ),
                  ),
                ),
          const SizedBox(height: kdefaultPadding * 2),
          AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              })
        ],
      ),
    );
  }
}
