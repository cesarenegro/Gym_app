enum SellerType { gymOfficial, member }

class MarketplaceProduct {
  final String id;
  final String title;
  final String category;
  final double priceEur;
  final String sellerName;
  final SellerType sellerType;
  final String imageUrl;
  final String description;
  final String condition;
  final String sizeOrVariant;
  final bool isAvailable;

  const MarketplaceProduct({
    required this.id,
    required this.title,
    required this.category,
    required this.priceEur,
    required this.sellerName,
    required this.sellerType,
    required this.imageUrl,
    required this.description,
    required this.condition,
    required this.sizeOrVariant,
    this.isAvailable = true,
  });
}
