import 'package:bsk/home_screen.dart';
import 'package:bsk/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:hive/hive.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AddProductPage(),
    );
  }
}

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  bool Loading = false;
  int mynum = 1;
  bool newbd = false;
  var check = false;
  var checks = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController callNumberController = TextEditingController();

  String catadropdwnmenu = 'নির্বাচন করুন';
  String upojeladropdwnmenu = 'নির্বাচন করুন';
  String condisondropdwnmenu = 'নির্বাচন করুন';

  List<File?> _images = [null, null, null]; // List to store three images

  Future<void> _getImage(int index) async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 20);
    if (image != null) {
      setState(() {
        _images[index] = File(image.path);
      });
    }
  }

  Future<void> _addProduct() async {
    var box = await Hive.openBox('loginbox');
    setState(() {
      Loading = true;
    });
    final uri = Uri.parse(
        'https://codzshop.com/myapp/bsk.php'); // Replace with your API endpoint
    final request = http.MultipartRequest('POST', uri);
    request.fields['username'] = box.get('myname');
    request.fields['user_id'] = box.get('myuser_id');
    request.fields['product_name'] = productNameController.text;
    request.fields['price'] = priceController.text;
    request.fields['details'] = detailsController.text;
    request.fields['adress'] = addressController.text;
    request.fields['callnumber'] = callNumberController.text;
    request.fields['whatsapp'] = box.get('whatsapp');
    request.fields['userphone'] = box.get('myphone').toString();

    request.fields['category'] = catadropdwnmenu;
    request.fields['product_condition'] = condisondropdwnmenu;
    if(upojeladropdwnmenu == "অন্যান্য"){
      request.fields['upozila'] = addressController.text;
    }else{
      request.fields['upozila'] = upojeladropdwnmenu;
    }

    request.fields['bargain'] = checks.toString();

    // Loop through the images list and add up to three images
    for (int i = 0; i < 3; i++) {
      if (_images[i] != null) {
        request.files.add(
          http.MultipartFile(
            'photo$i', // Use unique field names for each image
            _images[i]!.readAsBytes().asStream(),
            _images[i]!.lengthSync(),
            filename: _images[i]!.path.split('/').last,
          ),
        );
      }
    }



    final response = await http.Response.fromStream(await request.send());
    setState(() {
      Loading = false;
    });
    if (response.body.contains("Sucess")) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyProfile(),));
      print(response.body);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("আপনার পোস্টটি পেন্ডিং এ রয়েছে। দয়া করে এপ্রুভের অপেক্ষা করুন।")));
    } else {
      print('Error: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 238, 232, 255),
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Add Product'),
      ),
      body: Loading
          ? Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CupertinoActivityIndicator(),
          Text("দয়া করে অপেক্ষা করুন")
        ],
      ))
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.length < 4 || value.isEmpty) {
                      return "product name is required";
                    }
                  },
                  controller: productNameController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'পণ্যের নাম',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors
                              .black54), // Set the border color to black
                    ),
                    child: Container(
                      margin: EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "পণ্যের ক্যাটাগরি",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              )),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: DropdownButton<String>(
                              icon:
                              Icon(Icons.category, color: Colors.red),
                              value: catadropdwnmenu,
                              items: const [
                                DropdownMenuItem<String>(
                                    value: "নির্বাচন করুন",
                                    child: Text("নির্বাচন করুন")),
                                DropdownMenuItem<String>(
                                    value: "মোবাইল",
                                    child: Row(
                                      children: [
                                        Icon(Icons.phone_android),
                                        Text(" মোবাইল"),
                                      ],
                                    )),
                                DropdownMenuItem<String>(
                                    value: "ইলেকট্রনিকস",
                                    child: Row(
                                      children: [
                                        Icon(Icons.tv_rounded),
                                        Text("  ইলেকট্রনিকস"),
                                      ],
                                    )),
                                DropdownMenuItem<String>(
                                    value: "ক্যামেরা",
                                    child: Row(
                                      children: [
                                        Icon(Icons.camera_alt),
                                        Text("  ক্যামেরা"),
                                      ],
                                    )),
                                DropdownMenuItem<String>(
                                    value: "ল্যাপটপ ও কম্পিউটার",
                                    child: Row(
                                      children: [
                                        Icon(Icons.laptop),
                                        Text(" ল্যাপটপ ও কম্পিউটার"),
                                      ],
                                    )),
                                DropdownMenuItem<String>(
                                    value: "যানবাহন",
                                    child: Row(
                                      children: [
                                        Icon(Icons.motorcycle_sharp),
                                        Text(" যানবাহন"),
                                      ],
                                    )),
                                DropdownMenuItem<String>(
                                    value: "ছেলেদের ফ্যাশন ও সৌন্দর্য",
                                    child: Row(
                                      children: [
                                        Icon(Icons.man),
                                        Text(
                                            "  ছেলেদের ফ্যাশন ও সৌন্দর্য"),
                                      ],
                                    )),
                                DropdownMenuItem<String>(
                                    value: " শিশুদের পোশাক ও অন্যান্য",
                                    child: Row(
                                      children: [
                                        Icon(Icons.child_care),
                                        Text(
                                            "শিশুদের পোশাক ও অন্যান্য"),
                                      ],
                                    )),
                                DropdownMenuItem<String>(
                                    value: "মেয়েদের ফ্যাশন ও সৌন্দর্য",
                                    child: Row(
                                      children: [
                                        Icon(Icons.woman_sharp),
                                        Text(
                                            "  মেয়েদের ফ্যাশন ও সৌন্দর্য"),
                                      ],
                                    )),
                                DropdownMenuItem<String>(
                                    value: "জায়গা-জমি",
                                    child: Row(
                                      children: [
                                        Icon(Icons.home),
                                        Text("  জায়গা-জমি"),
                                      ],
                                    )),
                                DropdownMenuItem<String>(
                                    value: "নিত্য প্রয়োজনীয় সামগ্রী",
                                    child: Row(
                                      children: [
                                        Icon(Icons.shopping_bag_outlined),
                                        Text(" নিত্য প্রয়োজনীয় সামগ্রী"),
                                      ],
                                    )),
                                DropdownMenuItem<String>(
                                    value: "খাবার সামগ্রী",
                                    child: Row(
                                      children: [
                                        Icon(Icons.cake),
                                        Text(" খাবার সামগ্রী"),
                                      ],
                                    )),
                                DropdownMenuItem<String>(
                                    value: "অন্যান্য",
                                    child: Row(
                                      children: [
                                        Icon(Icons.devices_other),
                                        Text(" অন্যান্য"),
                                      ],
                                    )),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  catadropdwnmenu = value!;
                                });
                              },
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors
                              .black54), // Set the border color to black
                    ),
                    child: Container(
                      margin: EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "পণ্যের কন্ডিশন",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              )),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: DropdownButton<String>(
                              icon: Icon(Icons.add_circle,
                                  color: Colors.red),
                              value: condisondropdwnmenu,
                              items: const [
                                DropdownMenuItem<String>(
                                    value: "নির্বাচন করুন",
                                    child: Text("নির্বাচন করুন")),
                                DropdownMenuItem<String>(
                                    value: "নতুন", child: Text("নতুন")),
                                DropdownMenuItem<String>(
                                    value: "ব্যবহৃত",
                                    child: Text("ব্যবহৃত")),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  condisondropdwnmenu = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.length <2 || value.isEmpty) {
                      return "price is required";
                    }
                  },
                  controller: priceController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'পণ্যের মূল্য',
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: checks,
                      onChanged: (value) {
                        setState(() {
                          checks = value!;
                        });
                      },
                    ),
                    Text("আলোচনা সাপেক্ষে")
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.length < 5 || value.isEmpty) {
                      return "Product details is required";
                    }
                  },
                  maxLines: 10,
                  controller: detailsController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'পণ্যের বিবরণ ',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54)),
                    child: Container(
                      margin: EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "উপজেলা",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              )),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: DropdownButton<String>(
                              icon: Icon(Icons.location_pin,
                                  color: Colors.red),
                              value: upojeladropdwnmenu,
                              items:  [
                                DropdownMenuItem<String>(
                                    value: "নির্বাচন করুন",
                                    child: Text("নির্বাচন করুন")),
                                DropdownMenuItem<String>(
                                    value: "খাগড়াছড়ি সদর",
                                    child: Text("খাগড়াছড়ি সদর")),
                                DropdownMenuItem<String>(
                                    value: "মাটিরাঙ্গা",
                                    child: Text("মাটিরাঙ্গা")),
                                DropdownMenuItem<String>(
                                    value: "পানছড়ি",
                                    child: Text("পানছড়ি")),
                                DropdownMenuItem<String>(
                                    value: "মহালছড়ি",
                                    child: Text("মহালছড়ি")),
                                DropdownMenuItem<String>(
                                    value: "রামগড়", child: Text("রামগড়")),
                                DropdownMenuItem<String>(
                                    value: "গুইমারা",
                                    child: Text("গুইমারা")),
                                DropdownMenuItem<String>(
                                    value: "মানিকছড়ি",
                                    child: Text("মানিকছড়ি")),
                                DropdownMenuItem<String>(
                                    value: "লক্ষ্মীছড়ি",
                                    child: Text("লক্ষ্মীছড়ি")),
                                DropdownMenuItem<String>(
                                    value: "দীঘিনালা",
                                    child: Text("দীঘিনালা")),
                                DropdownMenuItem<String>(
                                    value: "অন্যান্য",
                                    child: Text("অন্যান্য")),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  upojeladropdwnmenu = value!;
                                });
                              },
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                upojeladropdwnmenu.toString() == "অন্যান্য"? Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(

                      validator: (value) {
                        if (value!.length < 4 || value.isEmpty || value.length >15  ) {
                          return "Address is required";
                        }
                      },
                      controller: addressController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        labelText: 'উপজেলার নাম লিখুন',
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                  ],


                ):

                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.length < 10 || value.isEmpty) {
                      return "Phone Number is required";
                    }
                  },
                  keyboardType: TextInputType.number,
                  controller: callNumberController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'ফোন নাম্বার',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors
                            .black54), // Set the border color to black
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "ছবি যুক্ত করুন (সর্বোচ্চ ৩ টি)",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                      Container(
                        height: 100,
                        // Set a fixed height for the horizontal list
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            for (int i = 0; i < 3; i++)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        _getImage(i);
                                      },
                                      child: Column(
                                        children: [
                                          Icon(Icons.image),
                                          Text("Add a Photo")
                                        ],
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white),
                                    ),
                                    if (_images[i] != null)
                                      Expanded(
                                          child: Image.file(_images[i]!,
                                              height: 50, width: 50)),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: FittedBox(
                    child: Row(
                      children: [
                        Checkbox(
                          value: check,
                          onChanged: (value) {
                            setState(() {
                              check = true;
                            });
                          },
                        ),
                        Text(
                            "আমি শর্তাবলী এবং নীতিমালা গুলো পড়েছি এবং গ্রহণ করেছি",
                            style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red),
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        _addProduct();
                      }

                    },
                    child: Text('Post Now'),
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
