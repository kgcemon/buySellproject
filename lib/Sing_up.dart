import 'dart:convert';
import 'package:bsk/profile.dart';
import 'package:bsk/user_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fb_linkController = TextEditingController();
  DateTime selectedDate = DateTime.now(); // Initialize with current date

  String message = '';
  late String nameError;
  late String phoneError;
  late String passwordError;

  bool loading = false;

  Future<void> _signup() async {
    setState(() {
      loading = true;
    });
    if (_formKey.currentState!.validate() && selectedDate.year != "2023") {
      final name = nameController.text;
      final phone = phoneController.text;
      final password = passwordController.text;
      final birthday = selectedDate
          .toLocal()
          .toString()
          .split(' ')[0]; // Format the selected date

      final response = await http.post(
        Uri.parse('https://codzshop.com/myapp/sing_up.php'),
        // Replace with your server URL
        body: {
          'name': name,
          'phone_number': phone,
          'password': password,
          'birthday': birthday,
          'fb_link' : fb_linkController.text,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            message = 'Registration successful';
            loading = false;
          });
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                content: Text("Registration Successful"),
                actions: <Widget>[
                  CupertinoDialogAction(
                    isDestructiveAction: false,
                    child: Text("OK"),
                    onPressed: () {
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyProfile(),)); // Close the dialog
                    },
                  ),
                ],
              );
            },
          );
        } else {
          setState(() {
            message = data['message'];
            loading = false;
          });
        }
      } else {
        setState(() {
          message = 'Failed to connect to the server.';
          loading = false;
        });
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.red,
            // Your desired color for the selected date
            primaryTextTheme: TextTheme(
              subtitle1:
              TextStyle(color: Colors.red), // Change the text color here
            ),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            colorScheme: ColorScheme.light(primary: Colors.red)
                .copyWith(secondary: Colors.red),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  var bithay = "Select Bithday";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Sign Up'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset("assets/bsk.png", height: 130),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        loading
                            ? CircularProgressIndicator()
                            : Text(message,
                            style: TextStyle(color: Colors.green)),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: TextFormField(
                            controller: nameController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Name'),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 4) {
                                setState(() {
                                  loading = false;
                                });
                                return 'Name is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: phoneController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Phone Number'),
                            validator: (value) {
                              if (value!.isEmpty ||
                                  value.length < 10 ||
                                  value.length > 13) {
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
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: fb_linkController,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.message,color: Colors.green),
                                border: OutlineInputBorder(),
                                labelText: 'Whatsapp Number (optional)'),

                          ),
                        ),



                        Padding(
                          padding: EdgeInsets.all(14.0),
                          child: InkWell(
                            onTap: () => _selectDate(context),
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(3)),
                                border: Border.all(color: Colors.black26),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.date_range),
                                    Text(
                                      'Birthday: ${selectedDate.toLocal()}'
                                          .split(' ')[0]
                                          .toString(),
                                      style: const TextStyle(
                                          color: Color(0xFA655A5A),
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      width: 20.0,
                                    ),
                                    Text(selectedDate.toString().split(' ')[0]),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: TextFormField(
                            controller: passwordController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'New Password'),
                            //obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 5) {
                                setState(() {
                                  loading = false;
                                });
                                return 'Password is required';
                              }else if(value.length<6){
                                return "Minimum 6 characters required";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 70,
                          width: 200,
                          child: Container(
                            padding: EdgeInsets.only(bottom: 15),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              onPressed: () {
                                _signup();
                              },
                              child: Text('Sign Up'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
