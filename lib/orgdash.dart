import 'package:flutter/material.dart';
import 'package:ecohub_app/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'main.dart';
class OrgDash extends StatefulWidget {
  final String userId;
  final MyAppState myapp;
  final BaseAuth auth;
  const OrgDash({
    Key key,
    this.userId,
    this.auth,
    @required this.myapp,
  }) : super(key: key);

  void _submit(){
    this.myapp.changePage(PageType.ORGANIZE);
  }

  void _logout(){
    auth.signOut();
    this.myapp.changePage(PageType.LOGIN);
    this.myapp.setState((){
      myapp.userId = "";
      myapp.authState = AuthStatus.NOT_LOGGED_IN;
      myapp.email = "";
      myapp.imageUrl = "";
    });
  }

  @override
  OrgDashState createState() => OrgDashState();
}

class OrgDashState extends State<OrgDash> {

  QuerySnapshot documents;

  void wait() async {
    QuerySnapshot docs = await Firestore.instance.collection("Locations").getDocuments();
    setState(() {
      this.documents = docs;
    });
  }

  Widget BlogList(){
    wait();

    return Stack(
        children: <Widget>[
          Container(
            child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal:16, vertical: 100),
                    itemCount: documents.documents.length,
                    shrinkWrap: true,
                    itemBuilder:(context,index){
                      return BlogsTile(
                          myapp: widget.myapp,
                          title: documents.documents[index].data["Event Name"],
                          imgUrl: documents.documents[index].data['imageURL'],
                          description: documents.documents[index].data["Description"],
                          date: "date",
                          hours: "${documents.documents[index].data["Hours"]} hours",
                          organizer: "organizer",
                          location: documents.documents[index].data["Location"]

                      );
                    }
                ),
              )
            ],
          ),
          ),
          Padding(padding: EdgeInsets.only(left: 31),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton(backgroundColor: Colors.red,
                  child: Icon(Icons.exit_to_app),
                  onPressed: (){
                    widget._logout();
                  }
              ),
            ),),
          Padding(padding: EdgeInsets.only(right:31),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed:(){
                    print("update");
                    widget._submit();
                  }
              ),

            ),
          )


        ],

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
    @required this.myapp});

  openTile(){
    print(title);
    List data = [this.imgUrl, this.title, this.description, this.date, this.hours, this.organizer,this.location];
    myapp.changePageWithData(PageType.EVENTVIEWORG,data);
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

