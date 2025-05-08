import 'package:electro/core/localization/app_localization.dart';
import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/utils/string_manager.dart';
import 'package:electro/core/utils/toast_utils.dart';
import 'package:electro/core/widgets/custom_loading_item.dart';
import 'package:electro/core/widgets/custom_toast.dart';
import 'package:electro/features/reviews/presentation/manager/reviews_cubit.dart';
import 'package:electro/features/reviews/presentation/manager/reviews_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class ReviewsViewBody extends StatefulWidget {
  final Map<String, dynamic> extra;
  const ReviewsViewBody({super.key, required this.extra});
  @override
  ReviewsViewBodyState createState() => ReviewsViewBodyState();
}

class ReviewsViewBodyState extends State<ReviewsViewBody> {
  final TextEditingController _feedbackController = TextEditingController();
  int _characterCount = 0;
  int _selectedRating = 0;
  final int _minCharacters = 10;
  String productId = "";
  String token = "";

  @override
  @override
  void initState() {
    super.initState();
    final extra = widget.extra;
    productId = extra["productId"];
    token = extra["token"];
    print("Tokeeeeeeeen $token");
    print("Product Id $productId");
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocConsumer<ReviewCubit, ReviewState>(
      listener: (context, state) {
        if (state is AddReviewSuccess) {
          ToastUtils.showErrorToast(state.message);
        } else if (state is ReviewFailure) {
          ToastUtils.showErrorToast(state.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(StringManager.feedback.tr(context)),
            backgroundColor: ColorsManager.primary,
            foregroundColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  StringManager.storeFeedbackQues.tr(context),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height * 0.02),

                // Rate
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        _selectedRating > index
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {
                          _selectedRating = index + 1;
                        });
                      },
                    );
                  }),
                ),
                SizedBox(height: height * 0.02),

                TextField(
                  controller: _feedbackController,
                  maxLines: 5,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: StringManager.productFeedbackQues.tr(context),
                  ),
                  onChanged: (text) {
                    setState(() {
                      _characterCount = text.length;
                    });
                  },
                ),

                SizedBox(height: height * 0.02),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Text(
                //       '$_characterCount/$_minCharacters characters',
                //       style: TextStyle(
                //         color:
                //             _characterCount >= _minCharacters
                //                 ? Colors.green
                //                 : Colors.grey,
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(height: height * 0.04),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        (_characterCount >= _minCharacters &&
                                _selectedRating > 0)
                            ? () {
                              final cubit = context.read<ReviewCubit>();
                              cubit.addReview(
                                token: token,
                                productId: productId,
                                comment: _feedbackController.text,
                                rate: _selectedRating,
                              );
                              _feedbackController.clear();
                              setState(() {
                                _characterCount = 0;
                                _selectedRating = 0;
                              });
                            }
                            : null,
                    child:
                        state is ReviewLoading
                            ? const CustomLoadingItem()
                            : Text(StringManager.feedbackBtn.tr(context)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
