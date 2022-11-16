import 'package:flutter/material.dart';
import 'package:uas_2020130002/admin/anggotalist.dart';
import 'package:uas_2020130002/admin/bukulist.dart';
import 'package:uas_2020130002/admin/transaksibuku.dart';
import 'package:animate_gradient/animate_gradient.dart';

class AppAdmin extends StatefulWidget {
  const AppAdmin({Key? key}) : super(key: key);

  @override
  State<AppAdmin> createState() => _AppAdminState();
}

class _AppAdminState extends State<AppAdmin> {
  bool auth = false;
  int pageIndex = 0;
  PageController pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
      BottomBarAnimated(),
      appBar: AppBar(
        backgroundColor: Color(0xFF3F0CAD),
      ),
      body: AnimateGradient(
    primaryBegin: Alignment.bottomLeft,
    primaryEnd: Alignment.topLeft,
    secondaryBegin: Alignment.topRight,
    secondaryEnd: Alignment.bottomRight,
    primaryColors: const [
    Colors.tealAccent,
    Colors.greenAccent,
    Colors.white,
    ],
    secondaryColors: const [
    Colors.white,
    Colors.lightBlueAccent,
    Colors.blue,
    ],
    child: PageView(
        scrollDirection: Axis.horizontal,
        controller: pageController,
        children: [
              AnggotaList(),
              BukuList(),
              TransaksiBukuList()
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
      )
    );
  }

  Widget BottomBarAnimated(){
    return BottomNavigationBar(
      backgroundColor: Color(0xFF3F0CAD),
      items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: IconButton(
            tooltip: 'Open navigation menu',
            icon: const Icon(Icons.person_rounded, color: Colors.white,),
            onPressed: () {
              pageController.jumpToPage(0);
              setState(() {
                pageIndex = 0;
              });
            },
          ),label: "Anggota"),
        BottomNavigationBarItem(icon: IconButton(
    tooltip: 'Favorite',
    icon: const Icon(Icons.book,color: Colors.white,),
    onPressed: () {
    pageController.jumpToPage(1);
    setState(() {
    pageIndex = 1;
    });
    },
    ),label: "Buku"),
        BottomNavigationBarItem(icon: IconButton(
          tooltip: 'Search',
          icon: const Icon(Icons.local_activity_rounded,color: Colors.white,),
          onPressed: () {
            pageController.jumpToPage(2);
            setState(() {
              pageIndex = 2;
            });
          },
        ),label: "Transaksi"),
        ],
      currentIndex: pageIndex,
      selectedItemColor: Colors.red,
      // onTap: (index){
      //   pageIndex = index;
      // },
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
                  icon: const Icon(Icons.person_rounded),
                  onPressed: () {
                    pageController.jumpToPage(0);
                    setState(() {
                      pageIndex = 0;
                    });
                  },
                ),
                ),
                Expanded(child:  IconButton(
                  tooltip: 'Favorite',
                  icon: const Icon(Icons.book),
                  onPressed: () {
                    pageController.jumpToPage(1);
                    setState(() {
                      pageIndex = 1;
                    });
                  },
                ),),
                Expanded(child: IconButton(
                  tooltip: 'Search',
                  icon: const Icon(Icons.local_activity_rounded),
                  onPressed: () {
                    pageController.jumpToPage(2);
                    setState(() {
                      pageIndex = 2;
                    });
                  },
                ),),
              ],
            ),
          )
      ),
    );
  }
}

