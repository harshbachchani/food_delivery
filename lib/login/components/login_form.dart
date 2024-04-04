// ignore_for_file: unused_local_variable, use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/assets/fonts/app_font.dart';
import 'package:food_delivery/components/already_have_an_account.dart';
import 'package:food_delivery/components/session.dart';
import 'package:food_delivery/constanst.dart';
import 'package:food_delivery/homepage/controller/location_controller.dart';
import 'package:food_delivery/homepage/controller/user_details.dart';
import 'package:food_delivery/homepage/screens/home/homepage.dart';
import 'package:food_delivery/signup/signup_screen.dart';
import 'package:get/get.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  UserDetails userDetails = Get.find();
  DatabaseReference databaseuser = FirebaseDatabase.instance.ref('Users');

  void _signInWithEmailAndPassword() async {
    setState(() {
      _isLoading = true;
    });
    try {
      UserCredential usercredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text)
          .then((user) async {
        SessionManager.setLoggedIn(true, user.user!.uid);
        SessionManager.getLocation().then((val) async {
          userDetails.updatemail(user.user!.email!);
          userDetails.updateuid(user.user!.uid);
          DataSnapshot snapshot =
              await databaseuser.child(user.user!.uid).get();
          if (snapshot.value == null) {
            databaseuser.child(user.user!.uid).set({
              "name": "User",
              "phone_number": "9087182991",
              "address": val["address"],
              "city": val["city"],
              "email": _emailController.text
            });
          }
        }).onError((error, stackTrace) {
          debugPrint(error.toString());
        });

        databaseuser.child(user.user!.uid).get().then((value) async {
          Map<dynamic, dynamic>? data = value.value as Map<dynamic, dynamic>;
          userDetails.updatename(data["name"]!);
          LocationController controller = Get.find();
          controller.updateaddress(data['address'], data['city']);
          userDetails.updatenumber(data["phone_number"]);
        }).onError((error, stackTrace) {
          debugPrint(error.toString());
        });
        return user;
      });

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        getsnackbar("User Not found", "Please SignUp using email and password");
      } else if (e.code == 'invalid-credential') {
        getsnackbar("Wrong Details", "Enter the correct email or password");
      }
    } catch (e) {
      debugPrint("Hello there the error is${e.toString()}");
    } finally {
      debugPrint("Hello World");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: ListView(
        shrinkWrap: true,
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kprimaryColor,
            onSaved: (email) {},
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter Your Email";
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: "Your Email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(kdefaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kdefaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              controller: _passwordController,
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please Enter Your Password";
                }
                return null;
              },
              cursorColor: kprimaryColor,
              decoration: const InputDecoration(
                  hintText: "Your Password",
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
                  tag: "login_btn",
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        _signInWithEmailAndPassword();
                      }
                    },
                    child: Text(
                      "Login".toUpperCase(),
                      style: AppFont.headText(),
                    ),
                  ),
                ),
          const SizedBox(height: kdefaultPadding * 2),
          AlreadyHaveAnAccountCheck(press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SignUpScreen(),
              ),
            );
          })
        ],
      ),
    );
  }
}
