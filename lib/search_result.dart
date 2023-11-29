import 'dart:convert';
import 'package:bsk/show_ads.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class searchResult extends StatefulWidget {
  final dynamic catagory;

  searchResult({required this.catagory});

  @override
  State<searchResult> createState() => _searchResultState();
}

class _searchResultState extends State<searchResult> {
  bool loading = true;

  List Mylist = [];

  Future loadData() async {
    print(widget.catagory);
    var response = await http
        .get(Uri.parse("https://codzshop.com/myapp/" + widget.catagory));
    setState(() {
      var body = jsonDecode(response.body);
      Mylist = body;
      loading = false;
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Search Result")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: loading
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoActivityIndicator(),
                    Text("সার্চ হচ্ছে দয়া করে অপেক্ষা করুন")
                  ],
                ))
              : Mylist.isEmpty
                  ? Center(
                      child: Image.asset(
                      "assets/search-bar.gif",
                      fit: BoxFit.fitWidth,
                    ))
                  : AnimationLimiter(
                      child: GridView.builder(
                        itemCount: Mylist.length,
                        itemBuilder: (BuildContext context, int index) {
                          var imageurl = "https://codzshop.com/myapp/";
                          final String photoData = Mylist[index]['photo'];
                          List<String> photoPaths = photoData.split(',');
                          List<Widget> photoWidgets = [];

                          for (String path in photoPaths) {
                            String imageUrl =
                                '$imageurl$path'; // Update the base URL as needed
                            photoWidgets.add(Image.network(
                              imageUrl,
                              height: 100,
                              fit: BoxFit.fitHeight,
                            ));
                          }
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 500),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoModalPopupRoute(
                                            builder: (context) => ProductPage(
                                                  pname: Mylist[index]
                                                      ['product_name'],
                                                  price: Mylist[index]['price'],
                                                  details: Mylist[index]
                                                      ['details'],
                                                  adress: Mylist[index]
                                                      ['upozila'],
                                                  callnumber: 'tel:+880' +
                                                      Mylist[index]
                                                              ['callnumber']
                                                          .toString(),
                                                  photo: Mylist[index]['photo'],
                                                  time: Mylist[index]
                                                      ['datetime'],
                                                  bargain: Mylist[index]
                                                      ['bargain'],
                                                  time_ago: Mylist[index]
                                                      ['time_ago'],
                                                  catagoryname: Mylist[index]
                                                      ['category'],
                                                  productcon: Mylist[index]
                                                      ['product_condition'],
                                                  username: Mylist[index]
                                                      ['username'],
                                                  userId: Mylist[index]
                                                      ['user_id'], whatsapp: Mylist[index]['whatsapp'],
                                                )));
                                  },
                                  child: Card(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          photoWidgets[0],
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 4, right: 4),
                                            child: FittedBox(
                                              child: Text(
                                                  Mylist[index]['product_name'],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 7, right: 4),
                                                  child: Text(
                                                      '৳' +
                                                          Mylist[index]
                                                              ['price'],
                                                      style: TextStyle(
                                                          color: Colors
                                                              .deepOrange)),
                                                ),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 4, right: 4),
                                                    child: Text(
                                                      Mylist[index]['upozila'],
                                                      style: TextStyle(
                                                          color: Colors.black45,
                                                          fontSize: 10),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ]),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                      ),
                    ),
        ));
  }
}
