import 'package:demo_database/view_page.dart';
import 'package:flutter/material.dart';

import 'DBHelper.dart';

class Insertpage extends StatefulWidget {
  const Insertpage({Key? key}) : super(key: key);

  @override
  State<Insertpage> createState() => _InsertpageState();
}

class _InsertpageState extends State<Insertpage> {
  TextEditingController tname = TextEditingController();
  TextEditingController tcontact = TextEditingController();
  TextEditingController temail = TextEditingController();

  bool namestatus = false;
  String? contacterror;
  String? emailerror;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return Insertpage();
              },
            ));
          },
          child: Icon(Icons.home_filled),
        ),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "New Contact",
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      iconColor: Colors.red,
                      hintText: "Enter Name",
                      labelText: "Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      errorText: namestatus ? "Fill your Name" : null),
                  controller: tname,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Enter Number",
                      labelText: "Contact",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      errorText: namestatus ? "Fill your Number" : null),
                  controller: tcontact,
                  maxLength: 10,
                ),
              ), Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Enter Email",
                      labelText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      errorText: namestatus ? "Fill your Email" : null),
                  controller: temail,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  String name = tname.text;
                  String contact = tcontact.text;
                  String email = temail.text;

                  if (name.isEmpty) {
                    namestatus = true;
                    setState(() {});
                  } else if (contact.isEmpty) {
                    contacterror = "Please enter the contact";
                    setState(() {});
                  } else if (contact.length < 10) {
                    contacterror = "Please enter the valid contact";
                    setState(() {});
                  } else if(email.isEmpty) {
                    contacterror = "Enter the Email";
                    setState(() {});
                  }else {
                    String insertqry =
                        "insert into ContactDiary (name,contact,email) values('$name','$contact','$email')";
                    int a = await DBHelper.database!.rawInsert(insertqry);
                    print(a);
                    if (a > 0) {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return ViewPage();
                        },
                      ));
                      // ScaffoldMessenger.of(context)
                      //     .showSnackBar(SnackBar(content: Text("Data Inserted")));
                    } else {
                      print("Data Not Inserted");
                    }
                  }
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
