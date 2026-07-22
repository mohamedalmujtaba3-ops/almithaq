class AppLink { 

  static const imageststatic = "https://afia-care.com/almithaq/almithaq-api/upload/";
  static const server = "https://afia-care.com/almithaq/almithaq-api/";

//========================== Image ============================
  static const String imagestCategories = "$imageststatic/categories";
  static const String imagestItems = "$imageststatic/items";
  static const String imagestWallet = "$imageststatic/wallet";


// =============================================================
 static const String test = "$server/test.php";


// ================================= Auth ========================== //
  static const String signUp = "$server/user/auth/signup.php";
  static const String login = "$server/user/auth/login.php";
  static const String editprofile = "$server/user/auth/editprofile.php";
  static const String verifycodessignup = "$server/user/auth/verfiycodesignup.php";
  static const String resend = "$server/user/auth/resend.php";
  static const String checkPhoneForgot = "$server/user/auth/checkphoneforgot.php";
  static const String resetPassword = "$server/user/auth/resetpassword.php";
  static const String verifycodeforgetpassword = "$server/user/auth/verifycodeforgot.php";



// Home
  static const String homepage = "$server/user/home.php";

  
// items
  static const String items = "$server/user/items/items.php";
  static const String searchitems = "$server/user/items/search.php";

// Favorite

  static const String favoriteAdd = "$server/user/favorite/add.php";
  static const String favoriteRemove = "$server/user/favorite/remove.php";
  static const String favoriteView = "$server/user/favorite/view.php";
  static const String deletefromfavroite =
      "$server/user/favorite/deletefromfavroite.php";

  // Sellers
  static const String restaurants= "$server/user/sellers/restaurants.php";
  static const String supermarkets= "$server/user/sellers/supermarkets.php";
  static const String pharmacies= "$server/user/sellers/pharmacies.php";


  // Cart
  static const String cartview = "$server/user/cart/view.php";
  static const String cartadd = "$server/user/cart/add.php";
  static const String cartdelete = "$server/user/cart/delete.php";
  static const String cartgetcountitems = "$server/user/cart/getcountitems.php";
  static const String delvprice  = "$server/user/cart/deliveryprice.php";

  
  // Order
  static const String checkout  = "$server/user/orders/checkout.php";
  static const String addpharmorder  = "$server/user/orders/addpharmorder.php";  
  static const String addotherorder  = "$server/user/orders/addotherorder.php";  
  static const String pendingorders  = "$server/user/orders/pending.php";
  static const String ordersarchive  = "$server/user/orders/archive.php";
  static const String oredersrejected  = "$server/user/orders/rejected.php";
  static const String ordersdetails  = "$server/user/orders/details.php";
  static const String setdone  = "$server/user/orders/done.php";
  static const String ordersdelete  = "$server/user/orders/delete.php";  
  static const String getdelvlocation  = "$server/user/orders/getdelvlocation.php";

  // Prefs
  static const String prefs = "$server/prefs.php";

  // Wallet
  static const String walletBalance    = "$server/user/wallet/balance.php";
  static const String walletTopup      = "$server/user/wallet/topup_request.php";
  static const String walletTransfer   = "$server/user/wallet/transfer.php";

}
