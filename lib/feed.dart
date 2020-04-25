import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Feed extends StatefulWidget {

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  int itemCount = 3;
  List<BlogsTile> tiles = [];

  Future<String> addTiles() async {
    setState(() {
      Firestore.instance.collection("Locations")
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) => tiles.add(new BlogsTile(imgUrl: f.data['imageURL'],
            title: f.data["Event Name"],
            description: f.data["Description"],
            date: "date",
            hours: "${f.data["Hours"]}",
            organizer: "organizer",
            location: f.data["Location"])));
        return 'success';
      });
    });

  }

  void wait() async {
    await addTiles();
    print("Loaded Tiles");
    print(tiles.length);
  }

  Widget BlogList(){

  wait();

    return Container(
      child: Column(
        children: <Widget>[
        ListView.builder(
          padding: EdgeInsets.symmetric(horizontal:16, vertical: 16),
          itemCount: tiles.length,
          shrinkWrap: true,
          itemBuilder:(context,index){
            return tiles[index];
          }
        )],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlogList(),
      backgroundColor: Colors.black87,


    );
  }
}

class BlogsTile extends StatelessWidget {

  String imgUrl, title, description, date, hours, organizer, location;

  BlogsTile({
    @required this.imgUrl,
    @required this.title,
    @required this.description,
    @required this.date,
    @required this.hours,
    @required this.organizer,
    @required this.location});


  @override
  Widget build(BuildContext context) {

    return InkWell(
        onTap: (){
          print("tapped on");
        },
      child: Container(
      margin: EdgeInsets.only(bottom: 16),
      height: 150,
      child: Stack(children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(
              imgUrl,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover)
        ),
        Container(
          height: 150,
          decoration: BoxDecoration(
              color: Colors.black45.withOpacity(0.3),
              borderRadius: BorderRadius.circular(15)
          ),

          ),

        Container(
          width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(title,
                      style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500)
                      ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(hours,
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400)
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(location,
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400)
                  ),
            ])
          )
        ],),
      )
    );
  }
}