import 'package:cumin_task/pages/home_page.dart';
import 'package:cumin_task/provider/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favoritepage extends StatelessWidget {
  const Favoritepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<UserDataProvider>(
      builder: (context, value, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            value.favoritedFeeds.isEmpty
                ? const Center(
                    child: Text("No Feeds In Favorite"),
                  )
                : Expanded(
                    child: ListView.builder(
                    itemCount: value.favoritedFeeds.length,
                    itemBuilder: (context, index) {
                      final data = value.favoritedFeeds[index];
                      return CustomFeedCard(
                          imageUrl: data.imageUrl,
                          title: data.title,
                          subtitle: data.subtitle,
                          prov: value,
                          feed: data);
                    },
                  ))
          ],
        );
      },
    ));
  }
}
