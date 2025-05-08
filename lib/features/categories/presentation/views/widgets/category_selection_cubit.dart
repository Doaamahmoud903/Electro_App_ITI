import 'package:electro/features/categories/data/models/api_categories_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electro/features/categories/presentation/views/widgets/selected_category.dart';

class CategorySelectionCubit extends Cubit<SelectedCategory?> {
  CategorySelectionCubit() : super(null);

  void selectCategory(int index, String id, String name, Image image) {
    emit(SelectedCategory(index: index, id: id, name: name, image: image));
  }
}
