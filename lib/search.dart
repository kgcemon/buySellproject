import 'package:bsk/search_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Searchbd extends StatefulWidget {
  @override
  State<Searchbd> createState() => _SearchState();
}

List mylist = [
  {"icon": Icons.mobile_screen_share, "cata": "মোবাইল"},
  {"icon": Icons.tv, "cata": "ইলেকট্রনিকস"},
  {"icon": Icons.laptop, "cata": "ল্যাপটপ ও কম্পিউটার"},
  {"icon": Icons.camera_alt, "cata": "ক্যামেরা"},
  {"icon": Icons.motorcycle, "cata": "যানবাহন"},
  {"icon": Icons.person, "cata": "ছেলেদের ফ্যাশন ও সৌন্দর্য"},
  {"icon": Icons.woman_sharp, "cata": "মেয়েদের ফ্যাশন ও সৌন্দর্য"},
  {"icon": Icons.child_care, "cata": "শিশুদের পোশাক ও অন্যান্য"},
  {"icon": Icons.landscape, "cata": "জায়গা-জমি"},
  {"icon": Icons.card_travel, "cata": "নিত্য প্রয়োজনীয় সামগ্রী"},
  {"icon": Icons.emoji_food_beverage, "cata": "খাবার সামগ্রী"},
  {"icon": Icons.devices_other_sharp, "cata": "অন্যান্য"},
];

TextEditingController seachcontrolar = TextEditingController();

class _SearchState extends State<Searchbd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              height: 80,
              color: Colors.deepOrange,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 5 / 1,
                    child: Container(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        child: TextField(

                          controller: seachcontrolar,
                          decoration: InputDecoration(
                            hintText: "Search",
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 45,
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    searchResult(catagory: "/keywordsearch.php?keyword="+seachcontrolar.text),
                              ));
                        },
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: mylist.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoModalPopupRoute(
                              builder: (context) => searchResult(
                                    catagory: "suggestbycatagory.php?category="+mylist[index]['cata'],
                                  )));
                    },
                    child: Card(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(color: Colors.white),
                        margin: EdgeInsets.only(top: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(mylist[index]['icon'],
                                color: Colors.deepOrange),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FittedBox(
                                  child: Text(
                                mylist[index]['cata'],
                                style: TextStyle(fontSize: 11),
                              )),
                            )
                          ],
                        ),
                      ),
                    ),
                  )   ;
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
