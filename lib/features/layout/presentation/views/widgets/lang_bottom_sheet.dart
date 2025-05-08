// import 'package:electro/core/localization/app_localization.dart';
// import 'package:electro/core/utils/string_manager.dart';
// import 'package:electro/features/account/presentation/manager/pic_lang_cubit.dart';
// import 'package:electro/features/layout/presentation/views/widgets/selected_bottom_item.dart';
// import 'package:electro/features/layout/presentation/views/widgets/unselected_bottom_item.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class LanguageBottomSheet extends StatelessWidget {
//   const LanguageBottomSheet({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     String currentLang = Localizations.localeOf(context).languageCode;
//     var picLangCubit = context.read<PicLangCubit>();
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         InkWell(
//           onTap: () {
//             picLangCubit.changePicLang('en');
//           },
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: width * 0.04,
//               vertical: height * 0.02,
//             ),
//             child:
//                 currentLang == ("en")
//                     ? SelectedBottomItem(
//                       selectedItem: StringManager.english.tr(context),
//                     )
//                     : UnselectedBottomItem(
//                       selectedItem: StringManager.english.tr(context),
//                     ),
//           ),
//         ),

//         InkWell(
//           onTap: () {
//             picLangCubit.changePicLang('ar');
//           },
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: width * 0.04,
//               vertical: height * 0.01,
//             ),
//             child:
//                 currentLang == ("ar")
//                     ? SelectedBottomItem(
//                       selectedItem: StringManager.arabic.tr(context),
//                     )
//                     : UnselectedBottomItem(
//                       selectedItem: StringManager.arabic.tr(context),
//                     ),
//           ),
//         ),
//       ],
//     );
//   }
// }
