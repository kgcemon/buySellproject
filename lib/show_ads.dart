import 'dart:convert';

import 'package:bsk/fullsliderimgeshow.dart';
import 'package:bsk/public_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ProductPage extends StatefulWidget {
  final dynamic pname;
  final dynamic username;
  final dynamic price;
  final dynamic details;
  final dynamic adress;
  final dynamic callnumber;
  final dynamic photo;
  final dynamic time;
  final dynamic bargain;
  final dynamic time_ago;
  dynamic catagoryname;
  final dynamic productcon;
  final dynamic userId;
  final dynamic whatsapp;

  ProductPage(
      {required this.pname,
      required this.price,
      required this.details,
      required this.adress,
      required this.callnumber,
      required this.photo,
      required this.time,
      required this.bargain,
      this.time_ago,
      required this.catagoryname,
      required this.productcon,
      required this.username,
      required this.userId,
      required this.whatsapp});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Future<void> _launchUrl(Uri call) async {
    if (!await launchUrl(call)) {
      throw Exception('Could not launch $call');
    }
  }

  List mysuggestlist = [];

  bool loading = true;

  int testcount = 0;

  Future mysuggestroduct() async {
    testcount++;
    var url =
        await "https://codzshop.com/myapp/suggestbycatagory.php?category=" +
            widget.catagoryname;
    var response = await http.get(Uri.parse(url));
    setState(() {
      var body = jsonDecode(response.body);
      mysuggestlist = body;
      loading = false;
    });
  }

  @override
  void initState() {
    mysuggestroduct();
    super.initState();
    print(widget.whatsapp);
  }

  @override
  Widget build(BuildContext context) {
    var imageurl = "https://codzshop.com/myapp/";
    final String photoData = widget.photo;
    List<String> photoPaths = photoData.split(',');
    List<Widget> photoWidgets = [];

    for (String path in photoPaths) {
      String imageUrl = '$imageurl$path'; // Update the base URL as needed
      photoWidgets.add(Image.network(imageUrl));
    }

    var style = ElevatedButton.styleFrom(backgroundColor: Colors.green);

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red, title: Text("BSK")),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      if (widget.whatsapp.toString().isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              content: Text(
                                  "এই বিক্রেতার হোয়াটসঅ্যাপ নাম্বার নেই। দয়া করে 'কল করুন'"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel")),
                                TextButton(
                                    onPressed: () {
                                      final Uri callnum =
                                          Uri.parse(widget.callnumber);
                                      _launchUrl(callnum);
                                    },
                                    child: Text("Call Now")),
                              ],
                            );
                          },
                        );
                      } else {
                        final Uri callnum = Uri.parse(
                            "https://api.whatsapp.com/send/?phone=+88${widget.whatsapp}&text=আমি বিএসকে'তে আপনার "
                            "${widget.pname} এর বিজ্ঞাপন দেখে নক করলাম। বিস্তারিত কথা বলতে চাই।&type=phone_number&app_absent=0");
                        _launchUrl(callnum);
                      }
                    },
                    child: Container(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset("assets/whatsapp.png"),
                          Text(" চ্যাট করুন"),
                        ],
                      ),
                    )),
                SizedBox(
                  width: 50,
                ),
                Container(
                  decoration: const BoxDecoration(),
                  height: 40,
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                        style: style,
                        onPressed: () {},
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: Text("সতর্ক বার্তা"),
                                  content: Column(
                                    children: [
                                      Text(
                                          "১। নিজে সময় নিয়ে দেখেশুনে পণ্য কিনুন\n২। অগ্রিম টাকা প্রদান করবেন না \n৩। পণ্য কেনার সময় সাথে নিজের কাউকে রাখুন।",
                                          textAlign: TextAlign.justify),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          final Uri callnum =
                                              Uri.parse(widget.callnumber);
                                          _launchUrl(callnum);
                                        },
                                        child: Text("ঠিক আছে"))
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.call),
                                Text(
                                  "কল করুন",
                                )
                              ],
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: double.infinity,
            child: Container(
                height: 270,
                child: Container(
                    width: double.infinity,
                    color: Colors.black26,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  FullImageSlider(photo: widget.photo),
                            ));
                      },
                      child: CarouselSlider(
                          items: photoWidgets,
                          options: CarouselOptions(
                              height: double.infinity,
                              autoPlay: true,
                              enlargeCenterPage: true)),
                    ))),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.all(15),
            child: Column(
              children: [
                Divider(
                  height: 1,
                  color: Colors.black26,
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.pname,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          widget.productcon == "নির্বাচন করুন"
                              ? Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Text("নতুন",
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.red)))
                              : Row(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          widget.productcon,
                                          style: TextStyle(
                                              fontSize: 10, color: Colors.red),
                                        )),
                                  ],
                                ),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 5,
                ),
                Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("শ্রেণী: " + widget.catagoryname),
                            Text(widget.time.toString().split(' ')[1]),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("ঠিকানা: " + widget.adress),
                                widget.time_ago == "0 days ago"
                                    ? Container(
                                        child: Text(
                                        "আজকের",
                                        style: TextStyle(color: Colors.black54),
                                      ))
                                    : Container(
                                        alignment: Alignment.center,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        margin: EdgeInsets.only(left: 100),
                                        child: Text("${widget.time_ago}",
                                            style: TextStyle(
                                                color: Colors.black54))),
                              ],
                            )),
                      ],
                    )),
                const SizedBox(
                  height: 0,
                ),
                Divider(color: Colors.red),
                Row(
                  children: [
                    Text(
                      "৳" + widget.price,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.red),
                    ),
                    widget.bargain == "true"
                        ? Container(
                            child: Text(
                            " (আলোচনা সাপেক্ষে)",
                            style: TextStyle(fontSize: 10),
                          ))
                        : Text(""),
                  ],
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("বিক্রেতা: "),
                            InkWell(
                              //profile Click
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => publicProfile(
                                          userid: widget.userId.toString()),
                                    ));
                              },
                              child: Text(
                                widget.username,
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.remove_red_eye_outlined),
                            Text(testcount.toString()),
                          ],
                        ),
                      ],
                    )),
                const Divider(
                  height: 1,
                  color: Colors.red,
                ),
                SizedBox(
                  height: 15,
                ),
                Text("বর্ণনা\n", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(widget.details.toString(), textAlign: TextAlign.justify),
                Divider(
                  height: 1,
                  color: Colors.black26,
                ),
                Container(
                    margin: EdgeInsets.only(top: 15),
                    alignment: Alignment.centerLeft,
                    child: Text("অনুরূপ বিজ্ঞাপন",
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Container(
                  height: 300,
                  child: loading
                      ? CupertinoActivityIndicator()
                      : AnimationLimiter(
                          child: ListView.builder(
                            itemCount: mysuggestlist.length,
                            itemBuilder: (context, index) {
                              var imageurl = "https://codzshop.com/myapp/";
                              final String photoDatabd =
                                  mysuggestlist[index]['photo'];
                              List<String> photoPaths = photoDatabd.split(',');
                              List<Widget> photoWidgetsbd = [];

                              for (String path in photoPaths) {
                                String imageUrl =
                                    '$imageurl$path'; // Update the base URL as needed
                                photoWidgetsbd.add(Image.network(
                                  imageUrl,
                                  height: double.infinity,
                                  width: 80,
                                  fit: BoxFit.fill,
                                ));
                              }

                              return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 375),
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: Column(
                                        children: [
                                          Divider(),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pushReplacement(
                                                  context,
                                                  CupertinoModalPopupRoute(
                                                    builder: (context) =>
                                                        ProductPage(
                                                      pname:
                                                          mysuggestlist[index]
                                                              ['product_name'],
                                                      price:
                                                          mysuggestlist[index]
                                                                  ['price']
                                                              .toString(),
                                                      details:
                                                          mysuggestlist[index]
                                                              ['details'],
                                                      adress:
                                                          mysuggestlist[index]
                                                              ['upozila'],
                                                      callnumber: 'tel:+880' +
                                                          mysuggestlist[index]
                                                                  ['callnumber']
                                                              .toString(),
                                                      photo:
                                                          mysuggestlist[index]
                                                              ['photo'],
                                                      time: mysuggestlist[index]
                                                          ['datetime'],
                                                      bargain:
                                                          mysuggestlist[index]
                                                              ['bargain'],
                                                      time_ago:
                                                          mysuggestlist[index]
                                                              ['0 দিন আগে'],
                                                      catagoryname:
                                                          mysuggestlist[index]
                                                              ['category'],
                                                      productcon: mysuggestlist[
                                                              index]
                                                          ['product_condition'],
                                                      username:
                                                          mysuggestlist[index]
                                                              ['username'],
                                                      userId:
                                                          mysuggestlist[index]
                                                              ['user_id'],
                                                      whatsapp:
                                                          mysuggestlist[index]
                                                              ['whatsapp'],
                                                    ),
                                                  ));
                                            },
                                            child: Card(
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: 90,
                                                child: ListTile(
                                                  trailing: Text(
                                                      mysuggestlist[index]
                                                          ['upozila']),
                                                  leading: photoWidgetsbd[0],
                                                  title: Text(
                                                      mysuggestlist[index]
                                                          ['product_name'],
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  subtitle: Text("৳" +
                                                      mysuggestlist[index]
                                                              ['price']
                                                          .toString()),
                                                ),
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ));
                            },
                          ),
                        ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
