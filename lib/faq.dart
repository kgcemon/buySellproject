import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class faq extends StatelessWidget {
  const faq({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Frequently Asked Question (FAQ)")),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
              children: [
            Row(

              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.question_answer),
                ),
                Text("বাই এন্ড সেল ইন খাগড়াছড়ি (বিএসকে) কী?",style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            Container(
              width: double.infinity,
              color: Colors.black12,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.topLeft,
                    child: Text("বিএসকে একটি বিনামূল্যে ব্যাবহারযোগ্য অ্যাপস যেটি ক্রেতা এবং বিক্রেতাকে সংযুক্ত করার জন্যে সহজ মাধ্যম হিসেবে তৈরি করা হয়েছে। এটি বিক্রেতাদেরকে সুযোগ দিবে তাঁদের পণ্যগুলো তালিকা করে প্রদর্শনে, ক্রেতাকে সুযোগ দিবে অসংখ্য পণ্যের মাঝে বাছাই করে পণ্য কেনার।বিএসকে বর্তমানে খুবই সহজভাবে এবং ইউজার ফ্রেন্ডলি করে ডেভেলপ করা হয়েছে যাতে আমাদের খাগড়াছড়ির মতো মফস্বল শহরের মানুষজন খুব সহজে সবকিছু বুঝতে পারে। ",textAlign: TextAlign.justify)),
              ),),

            Container(
              width: double.infinity,
              color: Colors.black12,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("data"),
              ),),

            SizedBox(height: 10),
            Divider(),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.question_answer),
                ),
                Text("বিএসকে সম্পূর্ণ বিনামূল্যে ব্যবহারযোগ্য?",style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            Container(
              width: double.infinity,
              color: Colors.black12,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("জি, বিএসকে সম্পূর্ণ বিনামূল্যে ব্যবহার করতে পারবেন, যেখানে হিডেন কোনো চার্জ নেই। আমাদের লক্ষ্য হচ্ছে ক্রয়-বিক্রয় কার্যক্রমকে সাধ্যমতো সহজ এবং সাশ্রয়ী মূল্যে সরবরাহের ব্যবস্থা করা। ",textAlign: TextAlign.justify),
              ),),

                SizedBox(height: 5),
                Divider(),

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.question_answer),
                ),
                FittedBox(child: Text("আমি বিএসকে’তে কীভাবে পণ্য বিক্রির পোস্ট করবো? ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12))),
              ],
            ),

            Container(
              width: double.infinity,
              color: Colors.black12,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("পণ্য বিক্রির জন্য প্রথমে এপসে প্রবেশ করে আপনাকে Signup অপশনে গিয়ে নাম, ঠিকানা, ফোন নাম্বার দিয়ে রেজিস্ট্রেশন করতে হবে। অতঃপর ‘বিজ্ঞাপন দিন’ অপশনে গিয়ে আপনার পণ্যের নাম, ক্যাটাগরি, লোকেশন, ফোন নাম্বার, ছবি ইত্যাদি তথ্য দিয়ে বিজ্ঞাপন দিতে পারবেন। ",textAlign: TextAlign.justify),
              ),),

                SizedBox(height: 10),
                Divider(),

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.question_answer),
                    ),
                    Text("বিএসকে'তে কোন সাইজের ছবি দিলে সুন্দর দেখাবে?",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                  ],
                ),

                Container(
                  width: double.infinity,
                  color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("বিএসকে'তে width: 500, Hight 300 pixel এর ছবি আপলোড করলে সুন্দরভাবে দেখাবে।"),
                  ),),
                SizedBox(height: 10),
                Divider(),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(Icons.question_answer),
                    ),
                    Text("আমি কি নিকটবর্তী এলাকায় ক্রয়-বিক্রয় করতে পারবো?",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
                  ],
                ),

                Container(
                  width: double.infinity,
                  color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("জি পারবেন। আমরা এমনভাবে এই অ্যাপসটি সাজিয়েছি যাতে করে আপনি আপনার নিকটবর্তী সকল এলাকার পণ্য সহজে খুঁজে বের করতে পারেন।"),
                  ),),

                SizedBox(height: 10),
                Divider(),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.question_answer),
                    ),
                    Text("আমি কীভাবে বিক্রেতার সাথে যোগাযোগ করবো?",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
                  ],
                ),

                Container(
                  width: double.infinity,
                  color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("আপনার যে পণ্যটি পছন্দ হবে সেটির নিচের দিকে তাকালে দু’টি অপশন দেখতে পাবেন ‘কল করুন’ এবং ‘ম্যাসেজ করুন’ অপশন।  ‘কল করুন’ অপশনে ক্লিক করেই আপনি সরাসরি বিক্রেতার সাথে ফোনে কানেক্ট হতে পারবেন। আবার ‘ম্যাসেজ করুন’ অপশনে ক্লিক করে আপনি সরাসরি বিক্রেতার ফেসবুক ম্যাসেজে যুক্ত হতে পারবেন। "),
                  ),),

                SizedBox(height: 10),
                Divider(),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.question_answer),
                    ),
                    Text("কোনো সেইফটি টিপস কি রয়েছে আপনাদের পক্ষ থেকে?",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                  ],
                ),

                Container(
                  width: double.infinity,
                  color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("অবশ্যই আছে। আপনি পণ্য কেনার সময় অবশ্যই লোকালয়ে দাঁড়িয়ে চেক করবেন, যদি সম্ভব হয় সাথে কাউকে নিয়ে যাবেন। নির্জনে গিয়ে লেনদেনকে আমরা নিরুৎসাহিত করি। আমরা নিরাপদ পরিবেশ নিশ্চিতে চেষ্টা করি, তবে ব্যক্তিগত সতর্কতা সবচে জরুরী।"),
                  ),),
                Divider(),


                SizedBox(height: 10),
                Divider(),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.question_answer),
                    ),
                    Text("আমি কোন ধরণের পণ্য বিএসকে’তে বিক্রি করতে পারবো?",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                  ],
                ),

                Container(
                  width: double.infinity,
                  color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("আপনি বিভিন্ন শ্রেণির পণ্য বিএসকে’তে বিক্রি করতে পারবেন। মোবাইল, ল্যাপটপ, কম্পিউটার, ইলেকট্রনিক্স পণ্য, মোটরবাইক, গাড়ি, আসবাবপত্র, ফার্নিচার ইত্যাদি। আপনি আমাদের শর্তাবলী মেনে যেকোনো পণ্য বিক্রির উদ্দেশ্যে তালিকাভুক্ত করতে পারবেন। যেকোনো অবৈধ পণ্য বিক্রি সম্পূর্ণ নিষিদ্ধ। "),
                  ),),

                SizedBox(height: 10),
                Divider(),

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.question_answer),
                    ),
                    Text("আমি কি দর কষাকষি করতে পারবো বিক্রেতার সাথে?",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                  ],
                ),

                Container(
                  width: double.infinity,
                  color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("অবশ্যই পারবেন, এবং আমরা এতে ক্রেতা-বিক্রেতাকে উৎসাহিত করি। কিছু কিছু পণ্যে দামের পাশে দেখবেন আলোচনা সাপেক্ষে লিখা আছে, সেসব পণ্যের ক্ষেত্রে আপনি বিক্রেতার সাথে দর কষাকষি করতে পারবেন।"),

                  ),),

                SizedBox(height: 10),
                Divider(),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.question_answer),
                    ),
                    Text("আমি কীভাবে কোনো ইস্যুতে রিপোর্ট করবো বিএসকে’তে?",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10)),
                  ],
                ),

                Container(
                  width: double.infinity,
                  color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("আপনি যদি কোনো ধরণের সমস্যার সম্মুখীন হোন, অথবা কোনো পণ্যের বিরুদ্ধে রিপোর্ট করতে চান আপনি সরাসরি আমাদের মেইলে জানান এ ঠিকানায়। ইমেইলঃ buysellinkhagrachari@gmail.com "),
                  ),),

                SizedBox(height: 10),
                Divider(),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.question_answer),
                    ),
                    Text("বিএসকে কি সারাবিশ্বে ব্যবহারযোগ্য?",style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Container(
                  width: double.infinity,
                  color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("বিএসকে মূলত বাংলাদেশের মধ্যে ব্যবহারের জন্য তৈরি করা হয়েছে। আপনার এলাকায় এভেইলেভল কি-না চেক করুন অ্যাপস স্টোরে গিয়ে। "),
                  ),),

                SizedBox(height: 10),
                Divider(),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.question_answer),
                    ),
                    Text("আমি কি রিভিউ এবং রেটিং দিতে পারবো সেলারকে?",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10)),
                  ],
                ),

                Container(
                  width: double.infinity,
                  color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("প্রাথমিকভাবে আমরা এ অপশনটি এখনো  চালু করিনি। তবে পরবর্তী যেকোনো আপডেটে এ বিষয়টি যুক্ত করা হবে।"),
                  ),),

                SizedBox(height: 10),
                Divider(),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.question_answer),
                    ),
                    Text("বিএসকে কি অতিরিক্ত কোনো ফিচার দিচ্ছে প্রিমিয়াম ইউজারদের জন্যে?",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 9)),
                  ],
                ),

                Container(
                  width: double.infinity,
                  color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("বর্তমানে বিএসকে সম্পূর্ণ বিনামূল্যে ব্যবহারের উপযোগি করে তৈরি করা হয়েছে। তবে আগামীতে প্রিমিয়াম ইউজারদের জন্যে আগামীতে বিশেষ সুবিধা দিয়ে অ্যাপসটি সাজানো হবে। "),
                  ),),
                
                Container(color: Colors.red,
                  child: Text("Copyright © Hasanul Karim, Founder & Owner of Buy & Sell in Khagrachari (BSK)",style: TextStyle(color: Colors.white)),
                ),

          ]),
        ),
      ),

    );
  }
}
