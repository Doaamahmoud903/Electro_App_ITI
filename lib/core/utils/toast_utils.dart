import 'package:fluttertoast/fluttertoast.dart';
import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/widgets/custom_toast.dart';

class ToastUtils {
  static void showSuccessToast(String msg) {
    CustomToast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: ColorsManager.greenColor,
      textColor: ColorsManager.whiteColor,
      fontSize: 16.0,
    );
  }

  static void showErrorToast(String msg) {
    CustomToast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: ColorsManager.errorColor,
      textColor: ColorsManager.whiteColor,
      fontSize: 16.0,
    );
  }
}
