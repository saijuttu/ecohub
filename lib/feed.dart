import 'package:flutter/material.dart';
import 'package:ecohub_app/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Feed extends StatefulWidget {
  final MyAppState myapp;
  const Feed({Key key,
    @required this.myapp,
  }
      ): super(key: key);

  @override
  FeedState createState() => FeedState();
}

class FeedState extends State<Feed> {

  QuerySnapshot documents;

  void wait() async {
    QuerySnapshot docs = await Firestore.instance.collection("Locations").getDocuments();
    setState(() {
      this.documents = docs;
    });
  }


  Widget BlogList(){
  wait();

    return Container(
      child: Column(
        children: <Widget>[

          Expanded(
            child:ListView.builder(
      padding: EdgeInsets.symmetric(horizontal:16, vertical: 16),
        itemCount: documents.documents.length,
        shrinkWrap: true,
        itemBuilder:(context,index){
          return  BlogsTile(
              myapp: widget.myapp,
              title: documents.documents[index].data["Event Name"],
              imgUrl: documents.documents[index].data['imageURL'],
              description: documents.documents[index].data["Description"],
              date: "date",
              hours: "${documents.documents[index].data["Hours"]} hours",
              organizer: "organizer",
              location: documents.documents[index].data["Location"]);
        }
    ),
        )
      ],

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
  MyAppState myapp;
  BlogsTile({
    @required this.imgUrl,
    @required this.title,
    @required this.description,
    @required this.date,
    @required this.hours,
    @required this.organizer,
    @required this.location,
    @required this.myapp,
  });

  openTile(){
    print(title);
    myapp.changePage(PageType.EVENTVIEW);
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
        onTap: (){
          openTile();
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