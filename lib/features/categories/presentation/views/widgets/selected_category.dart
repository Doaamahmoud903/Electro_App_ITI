import 'package:electro/features/categories/data/models/api_categories_response_model.dart';

class SelectedCategory {
  final int index;
  final String id;
  final String name;
  final Image image;

  SelectedCategory({
    required this.index,
    required this.id,
    required this.name,
    required this.image,
  });
}
