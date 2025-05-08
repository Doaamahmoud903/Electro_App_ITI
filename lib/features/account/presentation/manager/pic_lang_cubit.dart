import 'package:electro/features/account/presentation/manager/pic_lang_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PicLangCubit extends Cubit<PicLangState> {
  PicLangCubit() : super(PicLangInitial());

  static PicLangCubit get(BuildContext context) =>
      BlocProvider.of<PicLangCubit>(context);

  String currentLang = 'en';

  void changePicLang(String newLang) {
    currentLang = newLang;
    emit(ChangePicLangState());
  }
}
