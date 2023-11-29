import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Ourinfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Future<void> _launchUrl(Uri call) async {
      if (!await launchUrl(call)) {
        throw Exception('Could not launch $call');
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text("Info")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(

                color: Colors.black12,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network("https://codzshop.com/myapp/uploads/hasanul.jpg",height: 100,)),
                    ),
                    Container(
                        alignment: Alignment.center,
                        child: Center(
                            child: InkWell(
                              onTap: () {
                                final Uri callnum =
                                Uri.parse("https://www.facebook.com/hasanulrmstu");
                                _launchUrl(callnum);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                          "হাছানুল করিম",
                          style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 5),
                                      child: Icon(Icons.verified,color: Colors.blue,size: 18)),
                                ],
                              ),
                            ))),
                    Container(
                        alignment: Alignment.center,
                        child: Text("প্রতিষ্ঠাতা ও স্বত্বাধিকারী ",
                            style: TextStyle(fontStyle: FontStyle.italic))),
                    Text("বাই এন্ড সেল ইন খাগড়াছড়ি (বিএসকে)")
                  ],
                ),
              ),
              
              Container(
                margin: EdgeInsets.all(10),

                  child: Text("খাগড়াছড়ি জেলায় আপনার বিশ্বস্ত মাল্টি-ভেন্ডর মার্কেটপ্লেস BSK-তে স্বাগতম",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold, ),)),

              Text("৯ ফেব্রুয়ারি ২০১৪ সালে ক্রিয়েট করি Buy & Sell in Khagrachari (BSK) নামে একটি ফেসবুক গ্রুপ। এতে মানুষ, সম্প্রদায় এবং ব্যবসায়কে একত্রিত করি। আমাদের লক্ষ্য হ'ল একটি প্রাণবন্ত এবং সমৃদ্ধ অনলাইন মার্কেটপ্লেস তৈরি করা যেখানে বিভিন্ন স্থানের ক্রেতা এবং বিক্রেতারা বিভিন্ন পণ্য ও পরিষেবার অন্বেষণ, আবিষ্কার এবং বিনিময় করতে একত্রিত হতে পারে।",textAlign: TextAlign.justify),

              Text("আমাদের দৃষ্টি",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.left),
              Text("বিএসকে একটি ই-কমার্স প্ল্যাটফর্মের চেয়েও বেশি কিছু। খাগড়াছড়ি জেলা এবং খাগড়াছড়ির বাইরের জেলার মানুষদের একত্রিত করতে এটি একটি সেতু হিসেবে কাজ করবে। আমরা এমন একটি ভবিষ্যতের কল্পনা করি যেখানে প্রত্যেকে তাঁদের নিজ বাড়ি থেকে পণ্য ক্রয়-বিক্রয় করতে পারবে।",textAlign: TextAlign.justify),
              SizedBox(height: 20,),
              Text("সংস্কৃতি এবং সম্প্রদায়গুলিকে সংযুক্ত করা",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.justify),
              Text("খাগড়াছড়ি জেলা তার বৈচিত্র্যের জন্য পুরো দেশে পরিচিত একটি স্থান। আমরা অনন্য কারুশিল্প, ঐতিহ্যবাহী শিল্প এবং স্থানীয় দক্ষতা প্রদর্শনের জন্য নিবেদিত যা আমাদের জেলাকে চিত্রিত করবে। ক্রেতারা ঐতিহ্যবাহী হস্ত বোনা টেক্সটাইল থেকে শুরু করে আধুনিক প্রযুক্তি পর্যন্ত বিস্তৃত পণ্যগুলি খুঁজতে পারবে এ প্ল্যাটফর্মে। এবং খুব সহজে দেশের এক প্রান্তের ক্রেতা অন্য প্রান্তের বিক্রেতার কাছে পৌঁছাতে পারবে। ",textAlign: TextAlign.justify),
              SizedBox(height: 20,),
              Text("স্থানীয় উদ্যোক্তাদের ক্ষমতায়ন",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.justify),
              Text("BSK-তে, আমরা বিশ্বাস করি যে প্রতিটি ব্যবসা সেটা হোক বড় কিংবা ছোট তা উন্নতি করবে আমাদের মাধ্যমে। আমরা স্থানীয় উদ্যোক্তাদের অনলাইন স্টোর তৈরি করতে, তাদের পণ্য বাজারজাত করতে এবং বিশ্বব্যাপী মানুষের কাছে পৌঁছানোর ক্ষমতা দিয়ে থাকি। আমরা উদ্যোক্তাদের স্বপ্ন বাস্তবায়ন করতে পাশে থাকবো। "),
              SizedBox(height: 20,),
              Text("আপনার বিশ্বাসই আমাদের অগ্রাধিকার",style: TextStyle(fontWeight: FontWeight.bold),),
              Text("বিশ্বাস হল যেকোনো সফল ই-কমার্স প্ল্যাটফর্মের ভিত্তি। BSK একটি নিরাপদ এবং স্বচ্ছ কেনাকাটার অভিজ্ঞতা প্রদান করতে প্রতিশ্রুতিবদ্ধ। উচ্চ স্তরের গুণমান এবং বিশ্বস্ততা নিশ্চিত করতে আমরা আমাদের বিক্রেতাদের যাচাই ও পরীক্ষা করি। গ্রাহক সন্তুষ্টি আমাদের চূড়ান্ত লক্ষ্য, এবং আমরা অবিলম্বে যেকোনো সমস্যা সমাধান করতে এখানে আছি।"),

              SizedBox(height: 20,),
              Text("BSK কমিউনিটিতে যোগ দিন",style: TextStyle(fontWeight: FontWeight.bold),),
              Text("বিএসকে শুধু একটি মার্কেটপ্লেস নয়; এটি উত্সাহী ক্রেতা এবং বিক্রেতাদের একটি সম্প্রদায়। আমরা আপনাকে রিভিউ দিতে, আপনার অভিজ্ঞতা শেয়ার করতে এবং অন্যান্য সম্প্রদায়ের সদস্যদের সাথে যুক্ত হতে উৎসাহিত করি। আমরা সকলে মিলে BSK-কে সবার জন্য একটি ভালো ঠিকানা করে তুলতে পারি।"),
              SizedBox(height: 20,),
              Text("আজই শুরু করুন",style: TextStyle(fontWeight: FontWeight.bold),),
              Text("আপনি ইউনিক এবং বৈচিত্র্যময় পণ্যের যদি সন্ধানকারী একজন ক্রেতা হয়ে থাকেন, তবে BSK হল আপনার সেই জায়গা যেখানে আপনি সব পাবেন। আমাদের ক্রমবর্ধমান সম্প্রদায়ের অংশ হিসাবে আপনাকে পেয়ে আমরা খুশি। খাগড়াছড়ি জেলায় আপনার বিশ্বস্ত মাল্টি-ভেন্ডর মার্কেটপ্লেস BSK-এর সাথে থেকে আপনার পছন্দের পণ্য খুঁজুন, আবিষ্কার করুন এবং যুক্ত করুন।",textAlign: TextAlign.justify),

             SizedBox(height: 20,),
              Text("আপনার ই-কমার্স এর গন্তব্য হিসাবে BSK-কে বেছে নেওয়ার জন্য আপনাকে ধন্যবাদ। আমরা আপনাকে সেবা দিতে এবং আপনার অনলাইন শপিং এবং বিক্রয়ের অভিজ্ঞতাকে যতটা সম্ভব নির্বিঘ্ন এবং উপভোগ্য করতে এখানে আছি।",textAlign: TextAlign.justify),


            ],
          ),
        ),
      ),
    );
  }
}
