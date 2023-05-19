import 'package:flutter/material.dart';
import 'DBHelper.dart';
import 'form_page.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({Key? key}) : super(key: key);

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  /// try Random color generate

  List<Map<String, Object?>> l = [];
  bool refresh = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAlldata();
  }

  getAlldata() async {
    String insertqry = "Select * from ContactDiary";
    l = await DBHelper.database!.rawQuery(insertqry);
    refresh = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return refresh
        ? Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Contact"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.update_sharp))
        ],
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
                return Insertpage();
              }));
        },
        child: Icon(Icons.add),
      ),
      body: InkWell(
        onTap: () {
          ListView.builder(
            itemCount: l.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  child: Text(
                    "${l[index]["name"].toString().substring(0, 1).toUpperCase()}",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                title: Text("${l[index]['name']}"),
                subtitle: Text("${l[index]["contact"]}"),
                trailing: InkWell(
                  // child: Icon(Icons.delete),
                  onTap: () {showDialog(context: context, builder: (context) => AlertDialog(),);
                  deletcontact(index);
                    // Navigator.pushReplacement(context, MaterialPageRoute(
                    //   builder: (context) {
                    //     return ViewPage();
                    //   },
                    // ));
                  },
                ),
              );
            },
          );
        },
      ),
    )
        : CircularProgressIndicator();
  }

  void deletcontact(int myindex) async {
    String a = l[myindex]["id"].toString();
    await DBHelper.database!.rawDelete('DELETE FROM ContactDiary WHERE id =$a');

  }
}
