import 'dart:convert';
import 'package:bsk/show_ads.dart';
import 'package:bsk/view-Full_Image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class publicProfile extends StatefulWidget {
  dynamic userid;

  publicProfile({required this.userid});

  @override
  State<publicProfile> createState() => _publicProfileState();
}

class _publicProfileState extends State<publicProfile> {
  bool Loading = true;
  List myalldata = [];
  Map profilePic = {};
  var myname;

  Future<void> LoadAll() async {
    var url = "https://codzshop.com/myapp/userofile_product.php?user_id=" +
        widget.userid;
    ;
    var response = await http.get(Uri.parse(url));
    var body = jsonDecode(response.body);
    setState(() {
      myalldata = body;
      myname = myalldata[0]['username'];
      Loading = false;
    });

    var mypic = await http.get(Uri.parse(
        "https://codzshop.com/myapp/users_search.php?phone_number=" +
            myalldata[0]['userphone']));
    var picbody = jsonDecode(mypic.body);
    setState(() {
      profilePic = picbody;
      print(profilePic);
      Loading = false;
    });
  }

  @override
  void initState() {
    LoadAll();
    super.initState();
  }

  Future<void> _launchUrl(Uri call) async {
    if (!await launchUrl(call)) {
      throw Exception('Could not launch $call');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Loading
              ? Text("Profile")
              : Text(myalldata[0]['username'].toString())),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 0,
            child: Container(
              height: 170,
              margin: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      if(profilePic["photo"] != null){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullImage(
                                url: "https://codzshop.com/myapp/profile_photo/" +
                                    profilePic["photo"],
                              ),
                            ));

                      }

                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      child: Column(
                        children: [
                          Container(
                            color: Colors.white,
                            alignment: Alignment.center,
                            height: 90,
                            width: 90,
                            child: profilePic["photo"] == null
                                ? Image.asset("assets/bsk.png")
                                : Image.network(
                                    "https://codzshop.com/myapp/profile_photo/" +
                                        profilePic["photo"]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  myname == null
                      ? Text(".")
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Text(myalldata[0]['username'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 9),
                                child: Text(myalldata[0]['upozila'],
                                    style: TextStyle(
                                        fontSize: 8, color: Colors.blue))),
                          ],
                        ),
                  Divider(),
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        "",
                        style: TextStyle(fontSize: 9),
                        textAlign: TextAlign.center,
                      ))
                ],
              ),
            ),
          ),
          Container(
            child: Column(
              children: [
                Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          onPressed: () {
                            var number = Uri.parse(
                                "tel:+880" + myalldata[0]['callnumber']);
                            _launchUrl(number);
                          },
                          child: Row(
                            children: [
                              Icon(Icons.call),
                              Text("Call Now"),
                            ],
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          onPressed: () {
                            final message = Uri.parse(
                                "https://api.whatsapp.com/send/?phone=+88${myalldata[0]['whatsapp']}&text=Hello&type=phone_number&app_absent=0");
                            _launchUrl(message);
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/whatsapp.png",
                                height: 30,
                                width: 30,
                              ),
                              Text(" Message"),
                            ],
                          )),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 5, right: 5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      " বিজ্ঞাপনসমূহ " +myalldata.length.toString()+" টি",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: Loading
                  ? CupertinoActivityIndicator()
                  : ListView.builder(
                      itemCount: myalldata.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 2),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductPage(
                                        pname: myalldata[index]['product_name'],
                                        price: myalldata[index]['price'],
                                        details: myalldata[index]['details'],
                                        adress: myalldata[index]['upozila'],
                                        callnumber: myalldata[index]
                                            ['callnumber'],
                                        photo: myalldata[index]['photo'],
                                        time: myalldata[index]['datetime'],
                                        bargain: myalldata[index]['bargain'],
                                        catagoryname: myalldata[index]
                                            ['category'],
                                        productcon: myalldata[index]
                                            ['product_condition'],
                                        username: myalldata[index]['username'],
                                        userId: myalldata[index]['user_id'],
                                        whatsapp: myalldata[index]['whatsapp']),
                                  ));
                            },
                            child: Card(
                              child: ListTile(
                                leading: Container(
                                  width: 70,
                                  child: Image.network(
                                    "https://codzshop.com/myapp/" +
                                        myalldata[index]['photo']
                                            .toString()
                                            .split(',')[0],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                title: Text(myalldata[index]['product_name']),
                                subtitle: Text("৳" + myalldata[index]['price']),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
