import 'package:cumin_task/pages/home_page.dart';
import 'package:cumin_task/provider/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<UserDataProvider>(
      builder: (context, value, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            value.savedFeeds.isEmpty
                ? const Center(
                    child: Text("No Feeds Saved"),
                  )
                : Expanded(
                    child: ListView.builder(
                    itemCount: value.savedFeeds.length,
                    itemBuilder: (context, index) {
                      final data = value.savedFeeds[index];
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
