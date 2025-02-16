class GameDataVM {
  final List<Category> category;
  final List<String> roundsLengthOption;

  GameDataVM({
    required this.category,
    required this.roundsLengthOption,
  });

  factory GameDataVM.fromJson(Map<String, dynamic> json) {
    List<Category> categories = (json['category'] as List)
        .map((categoryJson) => Category.fromJson(categoryJson))
        .toList();

    List<String> roundsLengthOption =
        List<String>.from(json['roundsLengthOption']);

    return GameDataVM(
      category: categories,
      roundsLengthOption: roundsLengthOption,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category.map((category) => category.toJson()).toList(),
      'roundsLengthOption': roundsLengthOption,
    };
  }
}

class Category {
  final String name;
  final List<String> data;

  Category({
    required this.name,
    required this.data,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
      data: List<String>.from(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'data': data,
    };
  }
}