import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'SecondRoute.dart';
import 'package:barcode_scan/barcode_scan.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Http App amnzo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyListScreen(),
    );
  }
}

class MyListScreen extends StatefulWidget {
  @override
  createState() => _MyListScreenState();
}

class _MyListScreenState extends State {
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) {
        print('on launch $message');
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.getToken().then((token){
      print(token);
    });
  }
  alert( BuildContext context,int index) {
    _firebaseMessaging.getToken().then((token){
      print(token);
    });
  }
  dispose() {
    super.dispose();
  }

  @override
  build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fire Store"),
          actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Firestore.instance.collection('postes').add({"nom":"ADD1b"});
              },
            ),
            IconButton(
              icon: Icon(Icons.camera),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondRoute()),
                );
              },
            ),
            // action button
            IconButton(
              icon: Icon(Icons.add_box),
              onPressed: () {
                Firestore.instance.collection('postes').add({"nom":"ADDkhhh2"});
                alert(context,1);
              },
            ),

          ],
        ),
      drawer: Drawer(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {

            return Column(
              children: <Widget>[
                Divider(height: 5.0),
                ListTile(
                  title: Text(
                    "ds['nom']",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                  subtitle: Text(
                    "ds['nom']",
                    style: new TextStyle(
                      fontSize: 18.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  leading: Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        radius: 50.0,


                      ),
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),

                      ),
                    ],
                  ),
                  onTap: ()=> alert(context,index),

                ),
              ],
            );

          },
        ),
      ),
        floatingActionButton: new FloatingActionButton(
            elevation: 0.0,
            child: new Icon(Icons.check),
            backgroundColor: new Color(0xFFE57373),
            onPressed: (){}
        ),
        body:  new StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('postes').snapshots(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return Text("Loading");
               return ListView.builder(
                 itemCount: snapshot.data.documents.length,
                 itemBuilder: (context, index) {
                   DocumentSnapshot ds=snapshot.data.documents[index];
                   return Column(
                     children: <Widget>[
                       Divider(height: 5.0),
                       ListTile(
                         title: Text(
                           ds['nom'],
                           style: TextStyle(
                             fontSize: 22.0,
                             color: Colors.deepOrangeAccent,
                           ),
                         ),
                         subtitle: Text(
                           ds['nom'],
                           style: new TextStyle(
                             fontSize: 18.0,
                             fontStyle: FontStyle.italic,
                           ),
                         ),
                         leading: Column(
                           children: <Widget>[
                             CircleAvatar(
                                 backgroundColor: Colors.blueAccent,
                                 radius: 50.0,
                               child:  Image.network('https://picsum.photos/250?image=9',),

                             ),
                             IconButton(
                               icon: const Icon(Icons.remove_circle_outline),

                             ),
                           ],
                         ),
                         onTap: ()=> alert(context,index),

                       ),
                     ],
                   );

                 },
               );
            
          },
        ),
    );
  }
}