import 'package:almithaq/core/constant/routes.dart';
import 'package:almithaq/core/middleware/mymiddleware.dart';
import 'package:almithaq/view/screen/about.dart';
import 'package:almithaq/view/screen/auth/edit_profile.dart';
import 'package:almithaq/view/screen/auth/forgetpassword.dart';
import 'package:almithaq/view/screen/auth/resetpassword.dart';
import 'package:almithaq/view/screen/auth/success_resetpassword.dart';
import 'package:almithaq/view/screen/auth/verifycodeforgot.dart';
import 'package:almithaq/view/screen/auth/verifycodesignup.dart';
import 'package:almithaq/view/screen/auth/view_profile.dart';
import 'package:almithaq/view/screen/orders/gmap_live_location.dart';
import 'package:almithaq/view/screen/orders/gmap_pharm_pick_location.dart';
import 'package:almithaq/view/screen/orders/gmap_pick_location.dart';
import 'package:almithaq/view/screen/orders/gmap_view_location.dart';
import 'package:almithaq/view/screen/orders/orderform.dart';
import 'package:almithaq/view/screen/orders/other_order_dest_location.dart';
import 'package:almithaq/view/screen/orders/other_order_start_location.dart';
import 'package:almithaq/view/screen/orders/rejected.dart';
import 'package:almithaq/view/screen/auth/login.dart';
import 'package:almithaq/view/screen/auth/signup.dart';
import 'package:almithaq/view/screen/auth/success_signup.dart';
import 'package:almithaq/view/screen/cart.dart';
import 'package:almithaq/view/screen/homescreen.dart';
import 'package:almithaq/view/screen/items.dart';
import 'package:almithaq/view/screen/orders/archive.dart';
import 'package:almithaq/view/screen/orders/details.dart';
import 'package:almithaq/view/screen/orders/pending.dart';
import 'package:almithaq/view/screen/orders/otherorderform.dart';
import 'package:almithaq/view/screen/orders/pharmsform.dart';
import 'package:almithaq/view/screen/orders/pharmsformrousheta.dart';
import 'package:almithaq/view/screen/productdetails.dart';
import 'package:almithaq/view/screen/restaurants.dart';
import 'package:almithaq/view/screen/splash.dart';
import 'package:almithaq/view/screen/supermarkets.dart';
import 'package:almithaq/view/screen/viewimage.dart';
import 'package:almithaq/view/screen/wallet/wallet_screen.dart';
import 'package:almithaq/view/screen/wallet/wallet_transfer_screen.dart';
import 'package:get/get.dart';


List<GetPage<dynamic>>? routes = [
  GetPage(name: "/", page: () => const Splash()),

  GetPage(name: "/login", page: () => const Login(), middlewares: [MyMiddleWare()]),
      
  GetPage(name: AppRoute.homepage, page: () => const HomeScreen()),

  GetPage(name: AppRoute.about, page: () => AboutUs()),


//  Auth
  GetPage(name: AppRoute.login, page: () => const Login()),
  GetPage(name: AppRoute.signUp, page: () => const SignUp()),
  GetPage(name: AppRoute.successSignUp, page: () => const SuccessSignUp()),

  GetPage(name: AppRoute.forgetPassword, page: () => const ForgetPassword()),
  GetPage(name: AppRoute.resetPassword, page: () => const ResetPassword()),
  GetPage(name: AppRoute.successResetpassword, page: () => const SuccessResetPassword()),
  GetPage(name: AppRoute.verfiyCodeSignUp, page: () => const VerfiyCodeSignUp()),
  GetPage(name: AppRoute.verfiyCode, page: () => const VerfiyCode()),

  GetPage(name: AppRoute.viewprofile, page: () => const ViewProfile()),
  GetPage(name: AppRoute.editprofile, page: () => const EditProfile()),

  // Home - Items - Details - Favourites
  GetPage(name: AppRoute.homepage, page: () => const HomeScreen()),
  GetPage(name: AppRoute.items, page: () => const Items()),
  GetPage(name: AppRoute.productdetails, page: () => const ProductDetails()),
  GetPage(name: AppRoute.viewimage, page: () => PhotoViewPage()),
  GetPage(name: AppRoute.cart, page: () => const Cart()),

  
  // Orders
  GetPage(name: AppRoute.picklocation, page: () => GmapPickLocation()),
  GetPage(name: AppRoute.livelocation, page: () => GmapLiveLocation()),
  GetPage(name: AppRoute.startinglocation, page: () => const GmapViewLocation()),
  GetPage(name: AppRoute.orderspending, page: () => const OrdersPending()),
  GetPage(name: AppRoute.ordersarchive, page: () => const OrdersArchiveView()),
  GetPage(name: AppRoute.ordersrejected, page: () => const OrdersRejectedView()),
  GetPage(name: AppRoute.ordersdetails, page: () => const OrdersDetails()),
  GetPage(name: AppRoute.restaurants, page: () => const Restaurants()),
  GetPage(name: AppRoute.supermarkets, page: () => const Supermarkets()),
  GetPage(name: AppRoute.pharmsform, page: () => PharmsForm()),
  GetPage(name: AppRoute.orderform, page: () => OrderForm()),
  GetPage(name: AppRoute.otherorderform, page: () => OtherOrderForm()),
  GetPage(name: AppRoute.pharmsformrousheta, page: () => PharmsFormRousheta()),
  GetPage(name: AppRoute.pharmspicklocation, page: () => const GmapPharmPickLocation()),
  GetPage(name: AppRoute.otherorderdestlocation, page: () => const OtherOrderDestLocation()),
  GetPage(name: AppRoute.otherorderstartinglocation, page: () => const OtherOrderStartingLocation()),

  // Wallet
  GetPage(name: AppRoute.wallet, page: () => const WalletScreen()),
  GetPage(name: AppRoute.walletTransfer, page: () => const WalletTransferScreen()),

];
