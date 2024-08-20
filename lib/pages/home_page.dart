import 'package:cumin_task/model/feed_model.dart';
import 'package:cumin_task/pages/account_page.dart';
import 'package:cumin_task/pages/favorite_page.dart';
import 'package:cumin_task/pages/saved_page.dart';
import 'package:cumin_task/provider/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDataProvider>(
      builder: (context, userValue, child) {
        return Scaffold(
          bottomNavigationBar: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: userValue.bottomNavIndexHome,
                onTap: (value) {
                  userValue.setBottomNavIndex(value);
                },
                selectedItemColor: Colors.orange,
                unselectedItemColor: Colors.white,
                backgroundColor: Colors.black,
                items: const [
                  BottomNavigationBarItem(
                    label: 'Home',
                    icon: Icon(Icons.home_filled),
                  ),
                  BottomNavigationBarItem(
                    label: 'favorite',
                    icon: Icon(Icons.favorite),
                  ),
                  BottomNavigationBarItem(
                    label: 'saved',
                    icon: Icon(Icons.save_rounded),
                  ),
                  BottomNavigationBarItem(
                    label: 'account',
                    icon: Icon(Icons.account_box),
                  )
                ]),
          ),
          appBar: AppBar(
            elevation: 3,
            backgroundColor: Colors.black,
            shadowColor: Colors.white,
            title: const Text(
              "PIXELS",
              style: TextStyle(color: Colors.orange),
            ),
          ),
          body: pages[userValue.bottomNavIndexHome],
        );
      },
    );
  }
}

final List<Widget> pages = [
  const FeedPage(),
  const Favoritepage(),
  const SavedPage(),
  const AccountPage()
];

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDataProvider>(
      builder: (context, value, child) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, index) {
                  final data = feedList[index];

                  return CustomFeedCard(
                      feed: feedList[index],
                      prov: value,
                      imageUrl: data.imageUrl,
                      title: data.title,
                      subtitle: data.subtitle);
                },
              ))
            ],
          ),
        );
      },
    );
  }
}

class CustomFeedCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final UserDataProvider prov;
  final FeedModel feed;
  const CustomFeedCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.prov,
    required this.feed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.white10.withRed(1),
      elevation: 4,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                      width: double.infinity,
                      fit: BoxFit.cover,
                      image: NetworkImage(imageUrl)),
                ),
              ),
              SizedBox(
                height: 70,
                child: ListTile(
                  trailing: SizedBox(
                      child: Wrap(
                    children: [
                      IconButton(
                        onPressed: () {
                          prov.addToFavoritedFeeds(feed);
                        },
                        icon: const Icon(Icons.favorite),
                        color: prov.favoritedFeeds.contains(feed)
                            ? Colors.red
                            : Colors.grey,
                      ),
                      IconButton(
                        onPressed: () {
                          prov.addToSavedFeeds(feed);
                        },
                        icon: const Icon(Icons.save),
                        color: prov.savedFeeds.contains(feed)
                            ? const Color.fromARGB(255, 0, 64, 116)
                            : Colors.grey,
                      ),
                    ],
                  )),
                  title: Text(
                    title,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    subtitle,
                    style: const TextStyle(color: Colors.white54),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
