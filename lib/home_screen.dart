import 'dart:convert';
import 'dart:io';
import 'package:bsk/faq.dart';
import 'package:bsk/profile.dart';
import 'package:bsk/search.dart';
import 'package:bsk/show_ads.dart';
import 'package:bsk/user_login.dart';
import 'package:bsk/ourinfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:hive/hive.dart';

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  var mydeta;
  var mynumberdata;

  myloginfan() async {
    var box = await Hive.openBox('loginbox');
    setState(() {
      mydeta = box.get('myname');
      mynumberdata = box.get('myphone');
    });
  }

  logout() async {
    var box = await Hive.openBox('loginbox');
    setState(() {
      box.delete('mylogin');
      box.delete('myuser_id');
      box.delete('myname');
      box.delete('myphone');
      box.clear();
      print(box.get('mylogin'));
      myloginfan();
    });
  }

  InternetChecker() async {
    try {
      var result = await InternetAddress.lookup("google.com");
    } on SocketException {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("No Internet"),
            content: Text("দয়া করে আপনার ইন্টারনেট কানেকশন চেক করুন"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    InternetChecker();
                  },
                  child: Text("Try Again")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Loadallproduct();
                  },
                  child: Text("Dismiss"))
            ],
          );
        },
      );
    } catch (e) {}
  }

  bool Loading = true;

  var url = "https://codzshop.com/myapp/allproduct.php";
  var imageurl = "https://codzshop.com/myapp/";

  List myallproduct = [];

  Future<List> Loadallproduct() async {
    var response = await http.get(Uri.parse(url));
    var body = jsonDecode(response.body);
    setState(() {
      myallproduct = body;
      Loading = false;
    });
    print(myallproduct);
    return myallproduct = body as List;
  }

  @override
  void initState() {
    Loadallproduct();
    InternetChecker();
    setState(() {
      myloginfan();
    });
    super.initState();
  }

  var index = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
            "Buy & Sell in Khagrachari \n পরীক্ষামূলক চলমান অ্যাপ ",
            style: TextStyle(fontSize: 15)),
        centerTitle: true,
      ),
      bottomNavigationBar: ConvexAppBar(
          color: Colors.white,
          backgroundColor: Colors.red,
          onTap: (index) {
            if (index == 2) {
              Navigator.push(
                  context,
                  CupertinoModalPopupRoute(
                      builder: (context) => LoginPage() //AddProductPage(),
                      ));
            }

            if (index == 3) {
              Navigator.push(
                  context,
                  CupertinoModalPopupRoute(
                    builder: (context) => MyProfile(),
                  ));
            }

            if (index == 1) {
              Navigator.push(
                  context,
                  CupertinoModalPopupRoute(
                    builder: (context) => Searchbd(),
                  ));
            }
          },
          items: const [
            TabItem(icon: Icons.home, title: 'হোম'),
            TabItem(icon: Icons.search, title: 'সার্চ'),
            TabItem(icon: Icons.add, title: 'বিজ্ঞাপন দিন'),
            TabItem(icon: Icons.people, title: 'প্রোফাইল'),
          ]),
      body: Loading
          ? Center(child: CupertinoActivityIndicator())
          : RefreshIndicator(
              onRefresh: () => Loadallproduct(),
              child: GridView.builder(
                itemCount: myallproduct.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 2.5/3,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0.01,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  var myimg = myallproduct[index]['photo'];
                  final String photoData = myimg;
                  List<String> photoPaths = photoData.split(',');
                  List<Widget> photoWidgets = [];

                  for (String path in photoPaths) {
                    String imageUrl =
                        '$imageurl${path}'; // Update the base URL as needed
                    photoWidgets.add(AspectRatio(
                      aspectRatio: 6 / 5.5,
                      child: Image.network(
                        imageUrl,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ));
                  }

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoModalPopupRoute(
                              builder: (context) => ProductPage(
                                    pname: myallproduct[index]['product_name'],
                                    price: myallproduct[index]['price'],
                                    details: myallproduct[index]['details'],
                                    adress: myallproduct[index]['upozila'],
                                    callnumber: 'tel:+880' +
                                        myallproduct[index]['callnumber']
                                            .toString(),
                                    photo: myallproduct[index]['photo'],
                                    time: myallproduct[index]['datetime'],
                                    bargain: myallproduct[index]['bargain'],
                                    time_ago: myallproduct[index]['time_ago'],
                                    catagoryname: myallproduct[index]
                                        ['category'],
                                    productcon: myallproduct[index]
                                        ['product_condition'],
                                    username: myallproduct[index]['username'],
                                    userId: myallproduct[index]['user_id'],
                                    whatsapp: myallproduct[index]['whatsapp'],
                                  )));
                    },
                    child: Card(
                      child: Column(
                        children: [
                          myallproduct[index]['photo'] == null
                              ? Text("Loading")
                              : Container(child: photoWidgets[0]),
                          SizedBox(
                            height: 3,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 8, right: 4),
                            alignment: Alignment.center,
                            child: Center(
                              child: Text(
                                myallproduct[index]['product_name'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            child: Container(
                              margin: EdgeInsets.only(left: 7, right: 7),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      '৳' +
                                          myallproduct[index]['price']
                                              .toString()
                                              .split('টাকা')[0],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red)),
                                  Text(
                                    myallproduct[index]['upozila'],
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 10),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              padding: EdgeInsets.all(0),
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.red),
                currentAccountPicture: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Image.asset(
                      "assets/bsk.png",
                    )),
                accountName:
                    mydeta != null ? Text(mydeta) : Text("Login First"),
                accountEmail: mynumberdata != null
                    ? Text(mynumberdata)
                    : Text("Please Login"),
              ),
            ),
            ListTile(
              onTap: () {},
              title: Text("হোম"),
              leading: Icon(Icons.home),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyProfile(),
                    ));
              },
              title: Text("প্রোফাইল"),
              leading: Icon(Icons.person),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Ourinfo(),
                    ));
              },
              title: Text("আমাদের সম্পর্কে"),
              leading: Icon(Icons.mail),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoModalPopupRoute(
                      builder: (context) => faq(),
                    ));
              },
              title: Text("এফএকিউ (FAQ)"),
              leading: Icon(Icons.info),
            ),
            ListTile(
              onTap: () {
                logout();
              },
              title: mydeta == null ? Text('') : Text("লগ আউট"),
              leading: Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }
}
