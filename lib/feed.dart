import 'package:flutter/material.dart';

class Feed extends StatefulWidget {

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  int itemCount = 10;

  Widget BlogList(){
    return Container(
      child: Column(
        children: <Widget>[
        ListView.builder(
          itemCount: itemCount,
          shrinkWrap: true,
          itemBuilder:(context,index){
            return BlogsTile(
                imgUrl: "https://drive.google.com/open?id=1TQrjw3l8cdWlL6GXzpU8e58aNlxHG2E8",
                title: "title",
                description: "description",
                date: "date",
                hours: "hours",
                organizer: "organizer",
                location: "location"
            );
          }
        )],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlogList(),
      backgroundColor: Colors.red,


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
    return Container(
      height: 150,
      child: Stack(children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(imgUrl)),
        Container(
          height: 150,
          decoration: BoxDecoration(
              color: Colors.black45.withOpacity(0.3),
              borderRadius: BorderRadius.circular(6)
          ),

          ),
        Container(child: Column(children: <Widget>[
          Text(title),
          Text(description),
          Text(date),
          Text(hours),
          Text(organizer),
          Text(location),
        ])
        )
      ],),
    );
  }
}