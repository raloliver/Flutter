import 'package:flutter/material.dart';
class BookWidget extends StatefulWidget {
  String title;
  String authors;
  String image;
  BookWidget({this.title, this.authors, this.image});
  @override
  _BookWidgetState createState() => _BookWidgetState();
}

class _BookWidgetState extends State<BookWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        height: 250,
        margin: EdgeInsets.fromLTRB(16, 12, 24,12),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(12)
                ),
                child: Image.network(widget.image,
                fit: BoxFit.fill,
                  width: 200,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 220,
                height: 200,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 15,
                    )
                  ]
                ),
          
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text("${widget.title}", 
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),),
                    Text("${widget.authors}",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.arrow_forward_ios, color: Colors.grey,))
                  ],
                ),
              ),
            )
          ],
        ),
    );
  }
}