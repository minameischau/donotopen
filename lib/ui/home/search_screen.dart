import 'package:flutter/material.dart';

import 'package:panow/ui/control_screen.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-product';
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final search = ValueNotifier<String>('');
  List<String> searchList = [
    "Bàn phím cơ",
    "logitech 650",
    "Tai nghe Gaming",
    "bàn phím"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: 40,
        title: searchBox(),
        iconTheme: const IconThemeData(
          color: primaryCorlor,
        ),
        backgroundColor: white,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(top: 20.0),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: const [
                    Text(
                      'Tìm kiếm gần đây',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          color: black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Spacer(),
                    Text(
                      'Xem tất cả',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: primaryCorlor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .8,
                width: MediaQuery.of(context).size.width,
                child: searchListView(searchList),
              ),
            ],
          ),
          // builder: ((context, value, child) => Text(value)),
        ),
        // child:
      ),
    );
  }

  Widget searchListView(List pairsList) {
    return ListView.builder(
      itemCount: pairsList.length,
      itemBuilder: (ctx, i) {
        return ListTile(
          contentPadding: const EdgeInsets.only(left: 25, right: 20),
          title: Row(
            children: [
              const Icon(Icons.access_time),
              const SizedBox(width: 10),
              Text(
                pairsList[i],
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {},
              )
            ],
          ),
          onTap: () {
            // Navigator.of(context).pushNamed(
            //   SearchDetailScreen.routeName,
            //   arguments: matchQuery[i],
            // );
          },
        );
      },
    );
  }

  Widget iconSearch() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.search),
      color: primaryCorlor,
    );
  }

  Widget searchBox() {
    return Container(
      margin: const EdgeInsets.only(right: 0.0),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      height: 58,
      decoration: const BoxDecoration(
        color: white,
      ),
      child: TextField(
        onSubmitted: ((value) {}),
        onChanged: (value) {
          search.value = value;
        },
        decoration: InputDecoration(
          hintText: "Tìm kiếm",
          hintStyle: const TextStyle(
            color: primaryCorlor,
          ),
          border: InputBorder.none,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: primaryCorlor,
            ),
          ),
          suffixIcon: iconSearch(),
        ),
      ),
    );
  }
}
