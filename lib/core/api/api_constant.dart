class ApiConstant {
  static const String login = "/auth/login";
  static const String signup = "/auth/register";
  static const String forgetPassword = "/auth/forgot-password";
  static const String resetPassword = "/auth/reset-password";
  static const String changePassword = "/users/change-password";
  static const String categories = "/categories";
  static const String products = "/products";
  static const String cart = "/cart";
  static const String updateQuantity = "/cart/:id";
  static const String deleteFromCart = "/cart/:id";
  static const String deleteFromWishlsit = "/wishlist/:id";
  static const String updateUser = "/users/update-account";
  static const String getUser = "/users";
  static const String wishlist = "/wishlist";
  static const String orders = "/orders";
  static const String orderDeleted = "/orders/:orderId";
  static const String orderCreated = "/orders/:cartId";
  static const String user = "/user";
  static const String reviews = "/reviews";
  static const String coupons = "/coupons";
  static const String brands = "/brands";
  static const String deleteReview = "/reviews/:orderId";
  static const String addReview = "/products/:productId/reviews";
}
