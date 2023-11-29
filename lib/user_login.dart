import 'package:bsk/Sing_up.dart';
import 'package:bsk/add_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive/hive.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String message = '';
  late String phoneError;
  late String passwordError;
  bool loading = false;

  Future<void> _login() async {
    setState(() {
      loading = true;
    });
    if (_formKey.currentState!.validate()) {
      final phone = phoneController.text;
      final password = passwordController.text;

      final response = await http.post(
        Uri.parse('https://codzshop.com/myapp/mylogin.php'),
        // Replace with your server URL
        body: {
          'phone_number': phone,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          loading = false;
        });
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            message = 'Login successful';
          });
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => AddProductPage(),
          ));
          var box = await Hive.openBox('loginbox');
          box.put('mylogin', data['status']);
          box.put('myuser_id', data['user_id'].toString());
          box.put('myname', data['name']);
          box.put('myphone', data['phone_number']);
          box.put('whatsapp', data['whatsapp']);
        } else {
          setState(() {
            message = data['message'];
            loading = false;
          });
        }
      } else {
        setState(() {
          message = 'Failed to connect to the server.';
        });
      }
    }
  }

  myloginfan() async {
    var box = await Hive.openBox('loginbox');

    if (box.get('mylogin') == "success") {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AddProductPage(),
          ));
    }
  }

  @override
  void initState() {
    myloginfan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Login'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      child: Image.asset("assets/bsk.png", height: 150)),
                  Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        loading
                            ? Container(child: CircularProgressIndicator())
                            : Padding(
                          padding: EdgeInsets.all(16),
                          child:
                          Text(message, style: TextStyle(color: Colors.red)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: TextFormField(
                            controller: phoneController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Phone Number',
                            ),
                            validator: (value) {
                              if (value!.isEmpty || value.length > 13) {
                                setState(() {
                                  loading = false;
                                });
                                return 'Phone number is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder()),
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty || value.length <5) {
                                setState(() {
                                  loading = false;
                                });
                                return 'Password is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              style:
                              ElevatedButton.styleFrom(backgroundColor: Colors.red),
                              onPressed: _login,
                              child: Text('Login'),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("নতুন হলে একাউন্ট খুলুন"),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignupPage(),
                                        ));
                                  },
                                  child: Text("Sign Up"))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
