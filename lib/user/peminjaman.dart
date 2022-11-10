
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WishlistBook extends StatelessWidget {
  // const WishlistBook({Key? key}) : super(key: key);
  WishlistBook(this.useruid);
  final String useruid;

  @override
  Widget build(BuildContext context) {
    return bookCard();
  }
  Widget bookCard(){
    return Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
        child: SizedBox(
          height: 800,
          child: new GridView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 6,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1
                  , childAspectRatio: 0.7,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10), itemBuilder: (context, index){
            return Card(
              child: Text("Ini Buku ke- ${index}"),
            );
          }
          ),
        ),
            )
    )

        ]
    );
  }
}


