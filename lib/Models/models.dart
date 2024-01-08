//
//
//
//
//
class Category {
  Category({
    required this.id,
    required this.title,
    required this.image,
  });
  final String id;
  final String title;
  final String image;
}
//
//
//
//
//
class ServiceProviderModel {
  ServiceProviderModel({
    required this.id,
    required this.title,
    required this.profileImage,
    required this.email,
    required this.phone,
    required this.countryCode,
    required this.categoryId,
    required this.categoryName,
    required this.ratings,
  });
  final String id;
  final String title;
  final String email;
  final String phone;
  final String profileImage;
  final String countryCode;
  final String categoryId;
  final String categoryName;
  final String ratings;
}
//
//
//
//
//
class SubCategory {
  SubCategory({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  });
  final String id;
  final String title;
  final String description;
  final String image;
}
//
//
//
//
//
class AdvertisementModel {
  AdvertisementModel({
    required this.image,
    required this.link,
    required this.id,
  });

  final String id;
  final String image;
  final String link;
}
//
//
//
//
//
class ReviewModel {
  ReviewModel({
    required this.image,
    required this.name,
    required this.review,
    required this.rating,
  });

  final String name;
  final String image;
  final String review;
  final String rating;
}
//
//
//
//
//
class AdminReviewModel {
  AdminReviewModel({
    required this.userName,
    required this.userImage,
    required this.ratings,
    required this.review,
  });

  final String userName;
  final String userImage;
  final String ratings;
  final String review;
}
//
//
//
//
//
class OnboardModel {
  OnboardModel({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image;
  final String title;
  final String subtitle;
}
