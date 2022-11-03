import 'package:flutter/material.dart';
import 'package:uas_2020130002/user/history.dart';
import 'package:uas_2020130002/user/user.dart';
import 'homelibrary.dart';

class AppUser extends StatefulWidget {
  const AppUser({Key? key}) : super(key: key);

  @override
  State<AppUser> createState() => _AppUserState();
}

class _AppUserState extends State<AppUser> {
  bool auth = false;
  int pageIndex = 0;
  PageController pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: BottomBar(),
      ),
      floatingActionButton: const FloatingActionButton(onPressed: null),
      appBar: AppBar(

      ),
      body: PageView(
            controller: pageController,
            children: [
              HomeLibrary(),
              Text('Wishlist'),
              HistoryPage(),
              UserHome()
            ],
        physics: BouncingScrollPhysics(),
      ),
    );
  }

  Widget BottomBar() {
    return BottomAppBar(
      shape: CircularNotchedRectangle(
      ),
      color: Colors.black,
      child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Container(
            height: 65,
            child: Row(
              children: <Widget>[
                Expanded(child:  IconButton(
                  tooltip: 'Open navigation menu',
                  icon: const Icon(Icons.home),
                  onPressed: () {
                    pageController.jumpToPage(0);
                  },
                ),
                ),
                Expanded(child:  IconButton(
                  tooltip: 'Favorite',
                  icon: const Icon(Icons.book),
                    onPressed: () {
                      pageController.jumpToPage(1);
                    },
                ),),
                Expanded(child: IconButton(
                  tooltip: 'Search',
                  icon: const Icon(Icons.history),
                  onPressed: () {
                    pageController.jumpToPage(2);
                  },
                ),),
                Expanded(child:  IconButton(
                  tooltip: 'Favorite',
                  icon: const Icon(Icons.person),
                  onPressed: () {
                    pageController.jumpToPage(3);
                  },
                ),),
              ],
            ),
          )
      ),
    );
  }
}

