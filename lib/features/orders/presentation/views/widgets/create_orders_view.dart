import 'package:electro/core/localization/app_localization.dart';
import 'package:electro/core/routes/routes.dart';
import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/utils/string_manager.dart';
import 'package:electro/core/utils/toast_utils.dart';
import 'package:electro/features/layout/presentation/views/widgets/second_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electro/features/orders/presentation/manager/orders_cubit.dart';
import 'package:electro/features/orders/presentation/manager/orders_states.dart';
import 'package:electro/features/orders/data/models/orders_model.dart';
import 'package:go_router/go_router.dart';

class CreateOrdersView extends StatefulWidget {
  final String token;
  final String cartId;

  const CreateOrdersView({
    super.key,
    required this.token,
    required this.cartId,
  });

  @override
  State<CreateOrdersView> createState() => _CreateOrdersViewState();
}

class _CreateOrdersViewState extends State<CreateOrdersView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondAppbar(name: StringManager.addOrder.tr(context)),
      body: BlocConsumer<OrdersCubit, OrdersState>(
        listener: (context, state) {
          if (state is CreateOrderSuccess) {
            ToastUtils.showSuccessToast(
              StringManager.addOrderSuccess.tr(context),
            );
            cityController.clear();
            streetController.clear();
            phoneController.clear();
            context.push(Routes.orders); // move after success
          } else if (state is OrdersFailure) {
            ToastUtils.showErrorToast(state.message);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField(
                    context,
                    controller: cityController,
                    label: StringManager.city.tr(context),
                    icon: Icons.location_city,
                    validator:
                        (value) =>
                            value!.isEmpty
                                ? StringManager.enterCity.tr(context)
                                : null,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    context,
                    controller: streetController,
                    label: StringManager.street.tr(context),
                    icon: Icons.streetview,
                    validator:
                        (value) =>
                            value!.isEmpty
                                ? StringManager.enterStreet.tr(context)
                                : null,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    context,
                    controller: phoneController,
                    label: StringManager.phone.tr(context),
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    validator:
                        (value) =>
                            value!.isEmpty
                                ? StringManager.enterPhone.tr(context)
                                : null,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed:
                          state is OrdersLoading
                              ? null
                              : () {
                                if (_formKey.currentState!.validate()) {
                                  final address = ShoppingAddress(
                                    city: cityController.text,
                                    street: streetController.text,
                                    phone: phoneController.text,
                                  );
                                  context.read<OrdersCubit>().createOrder(
                                    token: widget.token,
                                    cartId: widget.cartId,
                                    shoppingAddress: address,
                                  );
                                }
                              },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManager.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child:
                          state is OrdersLoading
                              ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                              : Text(
                                StringManager.addOrder.tr(context),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    IconData? icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: ColorsManager.primary),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorsManager.primary),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: validator,
    );
  }
}
