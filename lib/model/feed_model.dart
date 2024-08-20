class FeedModel {
  final String title;
  final String subtitle;
  final String imageUrl;
  bool isFavorite;
  bool isSaved;
  FeedModel({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.isFavorite,
    required this.isSaved,
  });
}

List<FeedModel> feedList = [
  FeedModel(
      title: "A Nice Place To Visit In india",
      subtitle: "it is clearly a nice place to visit this time of the year in ",
      imageUrl:
          "https://imageio.forbes.com/specials-images/dam/imageserve/1171238184/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds",
      isFavorite: false,
      isSaved: false),
  FeedModel(
    title: "Family Time is Important",
    subtitle: "a get together with the family happy days",
    imageUrl:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQvVsVaasrbBA-IhRruiVGOb9HAqIruf1uJ0A&s",
    isFavorite: false,
    isSaved: false,
  ),
  FeedModel(
      title: "Deadly landslide in wayanad",
      subtitle: "deadly landslide happened in wayand which cause many death",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoWhFsTz7yJE80K_wdDXlj6mhhmFJV8vSsJQ&s",
      isFavorite: false,
      isSaved: false),
  FeedModel(
      title: "iphone 16 Launching Soon",
      subtitle:
          "iPhone 16 ready to launch in september 2024 pre booking ahs started",
      imageUrl:
          "https://static.tnn.in/thumb/msid-112620286,thumbsize-15042,width-1280,height-720,resizemode-75/112620286.jpg?quality=100",
      isFavorite: false,
      isSaved: false),
];
