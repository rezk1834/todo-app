
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'components/tile.dart';
import 'data/database.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final box = Hive.box('ToDoList');
  ToDo db = ToDo();
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (box.get("ToDoList") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
  void _inviteFriends() {
    final String inviteLink = 'https://www.yourapp.com/invite';
    Share.share('Join me on this amazing app! Use this link: $inviteLink');
  }
  void checkbox(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateData();
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.deepPurple[600],
        elevation: 0,
        centerTitle: true,
        title: Text(
          'To Do',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35,
            color: Colors.white,
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.deepPurple[200],
          child: ListView(
            children: [
              DrawerHeader(
                  child: Center(
                    child: Image(image: AssetImage("assets/icon/splash_logo.png"),),
                  )
              ),
              GestureDetector(
                child: ListTile(
                  leading: Image(image: AssetImage("assets/icon/contact.png"),),
                  title: Text("Contact Us",style: TextStyle(color: Colors.white,fontSize: 20),),
                  onTap: () => _launchURL('https://www.linkedin.com/in/moustafarezk1834/'),
                ),
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListTile(
                    leading: Icon(Icons.more,color: Colors.white,size: 29,),
                    title: Text("More Applications",style: TextStyle(color: Colors.white,fontSize: 20),),
                    onTap: () => _launchURL('https://drive.google.com/drive/folders/1-HFaqY-nKXCBXxfAiH0X1iKOgd0LWhBA?usp=sharing'),
                  ),
                ),
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListTile(
                    leading: Icon(Icons.add_comment,color: Colors.white,size: 29,),
                    title: Text("Invite Friends",style: TextStyle(color: Colors.white,fontSize: 20),),
                    onTap: () => _inviteFriends(),
                  ),
                ),
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListTile(
                    //leading: Image(image: AssetImage("assets/icon/contact.png"),),
                    leading: Icon(Icons.info,color: Colors.white,size: 29,),
                    title: Text("About",style: TextStyle(color: Colors.white,fontSize: 20),),
                    onTap: () => _launchURL('https://github.com/rezk1834/todo-app/blob/master/README.md'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (BuildContext context, int index) {
          return Tile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkbox(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
      floatingActionButton: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 10, 5),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Add new item',
                  filled: true,
                  fillColor: Colors.deepPurple[200],
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                setState(() {
                  db.toDoList.add([_controller.text, false]);
                });
                db.updateData();
                _controller.clear();
              }
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
