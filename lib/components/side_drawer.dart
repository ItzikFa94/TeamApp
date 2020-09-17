import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DrawerCode extends StatelessWidget {
  DrawerCode({@required this.signOut});

  final Function signOut;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.orange),
            child: Column(
              children: <Widget>[
                Flexible(
                  child: Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://pagesix.com/wp-content/uploads/sites/3/2019/06/chris-hemsworth.jpg?quality=90&strip=all&w=915'),
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
                Text(
                  "Itzik Fadida",
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                Text(
                  "{student Field of study}",
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.person_outline),
            title: Text("Profile"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(
                  //builder: (context) => Profile()
              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings_applications),
            title: Text("Setting"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(
                  //builder: (context) => Setting()
              ));
              print("Go to Settings");
            },
          ),
          ListTile(
            leading: Icon(Icons.arrow_back),
            title: Text("Logout"),
            onTap: this.signOut,
              // Navigator.pop(context);
              // SystemNavigator.pop();
          ),
        ],
      ),
    );
  }
}