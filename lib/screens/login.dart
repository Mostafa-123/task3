import 'package:chat_app/componant/textFiled.dart';
import 'package:chat_app/constant/constant.dart';
import 'package:chat_app/screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class login extends StatefulWidget {
  login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  var emailController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  var passwordController = TextEditingController();

  bool isPassword = true;
  bool isprogress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: screensColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 80),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('assets/images/scholar.png'),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      'Scholar Chat',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'pacifico'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                        key: formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: TextFormField(
                                  controller: emailController,
                                  onChanged: (value) {},
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'please enter email';
                                    } else if (!RegExp(
                                            "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                        .hasMatch(value)) {
                                      return "please enter a valid email";
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (value) {},
                                  decoration: InputDecoration(
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    border: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    hintText: 'Emaple@gmail.com',
                                    prefixIcon: Icon(Icons.email),
                                    hintStyle:
                                        const TextStyle(color: Colors.white),
                                    label: Text(
                                      'Email',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: TextFormField(
                                controller: passwordController,
                                onChanged: (value) {},
                                obscureText: isPassword,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'you must enter your password';
                                  } else if (value.length < 8) {
                                    return 'your password must be at least 8 letters';
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (value) {},
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  border: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  hintText: 'Password',
                                  prefixIcon:
                                      const Icon(Icons.password_outlined),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isPassword = !isPassword;
                                        });
                                      },
                                      icon: isPassword
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off)),
                                  hintStyle:
                                      const TextStyle(color: Colors.white),
                                  label: Text(
                                    'Password',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    minimumSize: Size(double.infinity, 60),
                                  ),
                                  onPressed: () async {
                                    if (formkey.currentState!.validate()) {
                                      isprogress = true;
                                      setState(() {});
                                      try {
                                        await loginUser();
                                        showsnackbar(context, 'success');
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'user-not-found') {
                                          showsnackbar(context,
                                              'No user found for that email.');
                                        } else if (e.code == 'wrong-password') {
                                          showsnackbar(context,
                                              'Wrong password provided for that user.');
                                        }
                                      } catch (e) {
                                        showsnackbar(context, e.toString());
                                      }
                                      isprogress = false;
                                      setState(() {});
                                    }
                                  },
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(
                                        color: screensColor,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('dont have an acount? '),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return Register();
                                      }));
                                    },
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
  }

  void showsnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
