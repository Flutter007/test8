class DiscountCard {
  final String? id;
  final String shopTitle;
  final String? shopImageURL;
  final String cardFrontSideImageURL;
  final String? cardBackSideImageURL;
  final String? notes;
  final DateTime? createdAt;

  DiscountCard({
    this.id,
    required this.shopTitle,
    required this.shopImageURL,
    required this.cardFrontSideImageURL,
    required this.cardBackSideImageURL,
    required this.notes,
    this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'shopTitle': shopTitle,
      'shopImageURL': shopImageURL,
      'cardFrontSideImageURL': cardFrontSideImageURL,
      'cardBackSideImageURL': cardBackSideImageURL,
      'notes': notes,
    };
  }

  factory DiscountCard.fromJson(Map<String, dynamic> json) {
    return DiscountCard(
      id: json['id'],
      shopTitle: json['shopTitle'],
      shopImageURL: json['shopImageURL'],
      cardFrontSideImageURL: json['cardFrontSideImageURL'],
      cardBackSideImageURL: json['cardBackSideImageURL'],
      notes: json['notes'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
