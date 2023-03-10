import 'package:chat_app/componant/textFiled.dart';
import 'package:chat_app/constant/constant.dart';
import 'package:chat_app/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var nameControler = TextEditingController();

  var emailControler = TextEditingController();

  var passwordControler = TextEditingController();
  var phoneControler = TextEditingController();
  var formkey = GlobalKey<FormState>();

  var confirmPasswordControler = TextEditingController();

  bool isPassword = true;
  bool isconfirmPassword = true;
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
                                  controller: nameControler,
                                  onChanged: (value) {},
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'please enter your Name';
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (value) {},
                                  decoration: const InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    hintText: 'Full Name',
                                    prefixIcon: Icon(Icons.person),
                                    hintStyle: TextStyle(color: Colors.white),
                                    label: Text(
                                      'Name',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: TextFormField(
                                  controller: emailControler,
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
                                  decoration: const InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    hintText: 'Emaple@gmail.com',
                                    prefixIcon: Icon(Icons.email),
                                    hintStyle: TextStyle(color: Colors.white),
                                    label: Text(
                                      'Email',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: TextFormField(
                                controller: passwordControler,
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
                                  label: const Text(
                                    'Password',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: TextFormField(
                                controller: confirmPasswordControler,
                                onChanged: (value) {},
                                obscureText: isconfirmPassword,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'you must enter your confirm password';
                                  } else if (!(value ==
                                      passwordControler.text)) {
                                    return 'your confirm password must be like your password';
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
                                  hintText: 'Confirm Password',
                                  prefixIcon:
                                      const Icon(Icons.password_outlined),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isconfirmPassword =
                                              !isconfirmPassword;
                                        });
                                      },
                                      icon: isconfirmPassword
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off)),
                                  hintStyle:
                                      const TextStyle(color: Colors.white),
                                  label: const Text(
                                    'Confirm Password',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: TextFormField(
                                  controller: phoneControler,
                                  onChanged: (value) {},
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'please enter your phone';
                                    } else if (value.length < 11 ||
                                        value.length > 11) {
                                      return "your phone must be 11 numbers";
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (value) {},
                                  decoration: const InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    hintText: 'Phone',
                                    prefixIcon: Icon(Icons.phone),
                                    hintStyle: TextStyle(color: Colors.white),
                                    label: Text(
                                      'Phone',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )),
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
                                        await createuser();
                                        showsnackbar(context, 'success');
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'weak-password') {
                                          showsnackbar(context,
                                              'The password provided is too weak.');
                                        } else if (e.code ==
                                            'email-already-in-use') {
                                          showsnackbar(context,
                                              'The account already exists for that email.');
                                        }
                                      } catch (e) {
                                        showsnackbar(context, e.toString());
                                      }
                                      isprogress = false;
                                      setState(() {});
                                    }
                                  },
                                  child: isprogress
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : Text(
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
                                Text('you have an acount? '),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return login();
                                      }));
                                    },
                                    child: Text(
                                      'Sign in',
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

  Future<void> createuser() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(
        email: emailControler.text, password: passwordControler.text);
  }

  void showsnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
