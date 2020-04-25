import 'package:flutter/material.dart';

class Feed extends StatefulWidget {

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  int itemCount = 2;

  Widget BlogList(){
    return Container(
      child: Column(
        children: <Widget>[
        ListView.builder(
          padding: EdgeInsets.symmetric(horizontal:16),
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
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      height: 150,
      child: Stack(children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(
              'https://cdn.pixabay.com/photo/2016/10/22/17/46/scotland-1761292_960_720.jpg',
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
    );
  }
}