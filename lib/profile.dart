import 'dart:convert';
import 'dart:io';
import 'package:bsk/user_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String myname = "";
  String myid = "2014";
  List myallinfo = [];
  bool loading = true;
  Map profilePic = {};
  var myphone = "";
  var userID;
  var wp;

  Future<void> loadUserData() async {
    var box = await Hive.openBox('loginbox');
    setState(() {
      myname = box.get('myname').toString();
      myid = box.get('myuser_id').toString();
    });
    if (box.get('myname').toString() == null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
      return; // Ensure you return after navigating to a new page.
    }
    if (box.get('myuser_id').toString() != null) {
      try {
        var response = await http.get(Uri.parse(
            "https://codzshop.com/myapp/userofile_product.php?user_id=" +
                myid));
        if (mounted) {
          var body = jsonDecode(response.body);
          setState(() {
            myallinfo = body;
            loading = false;
          });
        }
      } catch (e) {
        print("Error: $e");
      }
    }

    setState(() {
      myphone = box.get('myphone').toString();
      userID = box.get('myuser_id').toString();
    });

    var mypic = await http.get(Uri.parse(
        "https://codzshop.com/myapp/users_search.php?phone_number=" + myphone));
    var body = jsonDecode(mypic.body);
    setState(() {
      profilePic = body;
      print(profilePic);
    });
  }

  Future<void> checkUserId() async {
    var box = await Hive.openBox('loginbox');
    if (box.get('myuser_id') == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  deletedata(String id) async {
    var response = await http.get(
        Uri.parse("https://codzshop.com/myapp/userdeleteproduct.php?id=" + id));

    if (response.body.toString().contains("successfully")) {
      myallinfo.clear();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("পোস্টটি সফলভাবে ডিলিট হয়েছে")));
      setState(() {
        loadUserData();
        Navigator.pop(context);
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("দুঃখিত। আবার চেষ্টা করুন।")));
    }
  }

  @override
  void initState() {
    super.initState();
    checkUserId();
    loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpadatePic(userid: userID,),
                  ));
            },
            child: Text("Edit Profile Picrure")),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.redAccent, Colors.pinkAccent],
                ),
              ),
              child: Container(
                width: double.infinity,
                height: 350.0,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          profilePic["photo"] == null? "https://codzshop.com/myapp/profile_photo/bsklogo.jpg":
                          "https://codzshop.com/myapp/profile_photo/" +
                              profilePic["photo"],
                        ),
                        radius: 50.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        myname,
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 5.0,
                        ),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        elevation: 5.0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 22.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "মোট পোস্ট সংখ্যা",
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      myallinfo.length.toString(),
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.pinkAccent,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "ইউজার আইডি",
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "2014" + myid,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.pinkAccent,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text("আমার বিজ্ঞাপনসমূহ"),
            ),
            AspectRatio(
              aspectRatio: 8 / 8,
              child: Container(
                height: double.maxFinite,
                child: loading
                    ? Center(child: Text("আপনার কোনো বিজ্ঞাপন পাওয়া যায়নি"))
                    : ListView.builder(
                        itemCount: myallinfo.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Divider(),
                              Card(
                                child: ListTile(
                                  title: Text(myallinfo[index]['product_name']),
                                  subtitle:
                                      Text("৳" + myallinfo[index]['price']),
                                  leading: Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: myallinfo[index]['approved']
                                            .toString()
                                            .isEmpty
                                        ? Text(
                                            "Pending",
                                            style: TextStyle(color: Colors.red),
                                          )
                                        : FittedBox(
                                            child: Row(
                                              children: [
                                                Icon(Icons.done,
                                                    color: Colors.green),
                                                Text("Approved",
                                                    style: TextStyle(
                                                        color: Colors.green)),
                                              ],
                                            ),
                                          ),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return CupertinoAlertDialog(
                                            title: Text("সতর্কতা"),
                                            content: Text(
                                                "আপনি কি নিশ্চিতভাবে ডিলিট করতে চান?"),
                                            actions: [
                                              CupertinoButton(
                                                child: Text("হ্যাঁ"),
                                                onPressed: () => deletedata(
                                                    myallinfo[index]['id']),
                                              ),
                                              CupertinoButton(
                                                child: Text("না"),
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                              ),
                                            ],
                                          );
                                        },
                                      );

                                      setState(() {
                                        loadUserData();
                                      });
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UpadatePic extends StatefulWidget {
  final dynamic userid;

  const UpadatePic({required this.userid});
  @override
  _UpadatePic createState() => _UpadatePic();
}

class _UpadatePic extends State<UpadatePic> {
  String resultbord = "";
  bool Loading = false;
  late File _imageFile = File('');

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 10);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _updatePhoto() async {
    if (_imageFile.path.isEmpty) {
      setState(() {
        resultbord = "Please select an image first.";
      });
      return;
    }

    String userId = widget.userid; // Replace with the actual user ID

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://codzshop.com/myapp/update_profile_photo.php'),
      );

      request.fields['user_id'] = userId.toString();
      request.files.add(
        await http.MultipartFile.fromPath(
          'photo',
          _imageFile.path,
        ),
      );

      var response = await request.send();

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyProfile(),
            ));
        setState(() {
          Loading = false;
        });
        // Handle success, e.g., show a success message
      } else {
        setState(() {
          resultbord = 'Failed to update photo. Status code: ${response.statusCode}';
        });
        // Handle failure, e.g., show an error message
      }
    } catch (e) {
      print('Error: $e');
      // Handle errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile Picture'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Loading? CupertinoActivityIndicator(color: Colors.red,animating: true,):
            _imageFile.path.isEmpty
                ? Text(resultbord)
                : ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(50)),
                  child: Image.file(
                      _imageFile,
                      height: 100,
                    width: 100,
                    ),
                ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: ElevatedButton(
                onPressed: _pickImage,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image),
                    Text('Select profile picture'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _updatePhoto();
                if(_imageFile.path.isNotEmpty){

                  setState(() {
                    Loading = true;
                  });
                }

              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
