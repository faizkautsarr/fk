class Product {
  final int id;
  final String title;
  final String category;
  final double price;
  final String description;
  final String image;
  final double rating;
  final int ratingCount;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.image,
      required this.rating,
      required this.ratingCount,
      required this.category,
      required this.price});
}
