import 'package:flutter/material.dart';
import 'package:panow/ui/home/home_product_grid_tile.dart';
import 'package:provider/provider.dart';

// import 'product_grid_tile.dart';
import '../../ui/control_screen.dart';
import '../../models/product.dart';

class SearchRecent extends StatelessWidget {

  const SearchRecent({super.key});

  @override
  Widget build(BuildContext context) {
    
  List<String> searchList = [
    "Keyboard",
    "logitech 650",
    "Gaming mouse",
    "Keychron K8 Pro"
  ];
    // final productsManager = ProductsManager();
    // final products = searchText ? productsManager.favoriteItems : productsManager.items;
    return Column(
      
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: const [
                    Text(
                      'Recent search',
                      style: TextStyle(
                          fontFamily: 'SFCompactRounded',
                          color: black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Spacer(),
                    Text(
                      'See all',
                      style: TextStyle(
                        fontFamily: 'SFCompactRounded',
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
              const Icon(Icons.access_time_rounded),
              const SizedBox(width: 10),
              Text(
                pairsList[i],
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close_rounded),
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
}