// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:application_1/model/currency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:intl/intl.dart' as intl;

void main() {
  runApp(myapp());
}

// ignore: camel_case_types, use_key_in_widget_constructors
class myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa', ''), // persian
      ],
      theme: ThemeData(
          textTheme: const TextTheme(
              headline1: TextStyle(
                  fontFamily: 'Arial',
                  fontSize: 14,
                  color: Colors.red,
                  fontWeight: FontWeight.w700),
              headline2: TextStyle(
                  fontFamily: 'Arial',
                  fontSize: 14,
                  color: Colors.green,
                  fontWeight: FontWeight.w700))),
      debugShowCheckedModeBanner: false,
      home: Home1(),
    );
  }
}

class Home1 extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  Home1({
    Key? key,
  }) : super(key: key);

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  List<Arz> worldcurrency = [];
  Future getResponse(BuildContext context) async {
    var url =
        "https://sasansafari.com/flutter/api.php?access_key=flutter123456";
    var value = await http.get(Uri.parse(url));
    {
      if (worldcurrency.isEmpty) {
        if (value.statusCode == 200) {
          // ignore: use_build_context_synchronously
          _showsnackbar(context, "                    اطلاعات دریافت شد");
          List jsonList = convert.jsonDecode(value.body);

          // ignore: prefer_is_empty
          if (jsonList.length > 0) {
            for (var i = 0; i < jsonList.length; i++) {
              setState(() {
                worldcurrency.add(Arz(
                    id: jsonList[i]["id"],
                    title: jsonList[i]["title"],
                    price: jsonList[i]["price"],
                    changes: jsonList[i]["changes"],
                    status: jsonList[i]["status"]));
              });
            }
          }
        }
      }
    }
    return value;
  }

  @override
  void initState() {
    super.initState();
    getResponse(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(243, 243, 243, 243),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue,
        actions: [
          Image.asset("assets/images/icon.png"),
          const Align(
              alignment: Alignment.centerRight,
              child: Text("  قیمت لحظه ای ارزها  ♥",
                  style: TextStyle(color: Colors.black, fontSize: 16))),
          (Expanded(
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset("assets/images/menu.png")))),
          const SizedBox(
            width: 8,
          ),
        ],
      ),
      //colum & scrollview
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/images/q.png"),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "نرخ ارز آزاد چیست ؟",
                    style: TextStyle(fontSize: 16, fontFamily: 'Arial'),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Text(
                  "نرخ ارزها در معاملات نقدی و رایج روزانه است. معاملات نقدی معاملاتی هستند که خریدار و فروشنده به محض انجام معامله ارز و ریال را با هم تبادل می نمایند.",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 13.5, fontFamily: 'arial')),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 30,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(1000),
                    ),
                    color: Color.fromARGB(255, 130, 130, 130)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text(
                      "نام ارز",
                      style:
                          TextStyle(fontFamily: 'Arial', color: Colors.white),
                    ),
                    Text("قیمت",
                        style: TextStyle(
                            fontFamily: 'Arial', color: Colors.white)),
                    Text("تغییرات",
                        style:
                            TextStyle(fontFamily: 'Arial', color: Colors.white))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                // ignore: sized_box_for_whitespace
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 2,
                  child: FuturebuilderMethod(context),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 225, 225, 225),
                      borderRadius: BorderRadius.circular(1000)),
                  //updatebutton in ROW
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(1000))),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 202, 193, 255))),
                          onPressed: () {
                            worldcurrency.clear();
                            FuturebuilderMethod(context);
                          },
                          icon: (const Icon(CupertinoIcons.refresh_bold)),
                          label: const Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text("بروزرسانی قیمت",
                                style: TextStyle(
                                    fontFamily: 'Arial',
                                    color: Colors.black,
                                    fontSize: 16)),
                          )),
                      Text(
                        "آخرین بروزرسانی: ${_time()}",
                        style:
                            const TextStyle(fontFamily: 'Arial', fontSize: 16),
                      ),
                      //sizedbox width updatetimer bitch :))
                      const SizedBox(
                        width: 7,
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<dynamic> FuturebuilderMethod(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: worldcurrency.length,
                itemBuilder: (BuildContext context, int postion) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: Myitem(postion, worldcurrency),
                  );
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
      future: getResponse(context),
    );
  }
}

class Myitem extends StatelessWidget {
  int postion;
  List<Arz> worldcurrency;

  // ignore: use_key_in_widget_constructors
  Myitem(this.postion, this.worldcurrency);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          boxShadow: const <BoxShadow>[
            BoxShadow(blurRadius: 1.0, color: Colors.grey)
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(1000),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(worldcurrency[postion].title),
            Text(farsinumber(worldcurrency[postion].price.toString()),
                style: const TextStyle(fontFamily: 'Arial', fontSize: 17)),
            Text(farsinumber(worldcurrency[postion].changes.toString()),
                style: worldcurrency[postion].status == "n"
                    ? Theme.of(context).textTheme.headline1
                    : Theme.of(context).textTheme.headline2)
          ],
        ));
  }
}

void _showsnackbar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg,
          style: const TextStyle(
              fontFamily: 'Arial', color: Colors.black, fontSize: 18)),
      backgroundColor: Colors.green));
}

String _time() {
  DateTime now = DateTime.now();
  return intl.DateFormat('kk:mm:ss').format(now);
}

String farsinumber(String number) {
  const en = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const fa = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
  // ignore: avoid_function_literals_in_foreach_calls
  en.forEach((element) {
    number = number.replaceAll(element, fa[en.indexOf(element)]);
  });
  return number;
}
