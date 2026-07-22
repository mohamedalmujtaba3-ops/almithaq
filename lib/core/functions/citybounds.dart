import 'package:almithaq/core/services/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

MyServices myServices = Get.find();
CityBounds(){
  LatLngBounds bounds = LatLngBounds(southwest:  LatLng(19.5500, 37.1500), northeast: LatLng(19.6500, 37.3000));
  if (myServices.sharedPreferences.getString("city").toString() == "بورتسودان") {
    bounds = LatLngBounds(southwest:  const LatLng(19.5500, 37.1500), northeast:  const LatLng(19.6500, 37.3000));
  }
  if (myServices.sharedPreferences.getString("city").toString() == "عطبرة") {
    bounds = LatLngBounds(southwest:  const LatLng(17.6500, 33.961316505707), northeast:  const LatLng(17.722315164801927, 34.059335141892525));
  }
  if (myServices.sharedPreferences.getString("city").toString() == "مدني") {
    bounds = LatLngBounds(southwest:  const LatLng(14.296921202006558, 33.509588802609066), northeast:  const LatLng(14.465863818865104, 33.57893999178411));
  }
  if (myServices.sharedPreferences.getString("city").toString() == "القضارف") {
    bounds = LatLngBounds(southwest:  const LatLng(13.984369176140804, 35.31345009302674), northeast:  const LatLng(14.076299403582095, 35.43567298087978));
  }
  if (myServices.sharedPreferences.getString("city").toString() == "كسلا") {
    bounds = LatLngBounds(southwest:  const LatLng(15.413783859268822, 36.37292257264068), northeast:  const LatLng(15.49733794810238, 36.45137181386097));
  }
  if (myServices.sharedPreferences.getString("city").toString() == "مروي") {
    bounds = LatLngBounds(southwest:  const LatLng(18.44601881594843, 31.821814878479753), northeast:  const LatLng(18.51407318244488, 31.843100887038432));
  }
  if (myServices.sharedPreferences.getString("city").toString() == "أم درمان") {
    bounds = LatLngBounds(southwest:  const LatLng(15.501567281051651, 32.36349844770904), northeast:  const LatLng(15.78654804288272, 32.54202626142698));
  }
  if (myServices.sharedPreferences.getString("city").toString() == "شندي") {
    bounds = LatLngBounds(southwest:  const LatLng(16.65012479512781, 33.43388678222934), northeast:  const LatLng(16.708829437893467, 33.463412536036536));
  }
  if (myServices.sharedPreferences.getString("city").toString() == "كريمة") {
    bounds = LatLngBounds(southwest: const LatLng(18.45490716480801, 31.795390302822533), northeast:  const LatLng(18.585124332996312, 31.845858742469723));
  }
  if (myServices.sharedPreferences.getString("city").toString() == "الدامر") {
    bounds = LatLngBounds(southwest: const LatLng(17.55533382350695, 33.96783862597098), northeast:  const LatLng(17.60966292090415, 33.97925410732403));
  }
  if (myServices.sharedPreferences.getString("city").toString() == "بحري") {
    bounds = LatLngBounds(southwest: const LatLng(15.637939215274317, 32.45159796745202), northeast: const LatLng(16.32444686108335, 33.303038370228194));
  }
  if (myServices.sharedPreferences.getString("city").toString() == "الخرطوم") {
    bounds = LatLngBounds(southwest: const LatLng(15.377715214042102, 32.456572613685275), northeast: const LatLng(15.634436348368105, 32.6605063230599));
  }
  if (myServices.sharedPreferences.getString("city").toString() == "الحصاحيصا") {
    bounds = LatLngBounds(southwest: const LatLng(14.706231909889313, 33.2758960996812), northeast: const LatLng(14.782805522664564, 33.3175203697156));
  }
  if (myServices.sharedPreferences.getString("city").toString() == "المناقل") {
    bounds = LatLngBounds(southwest: const LatLng(14.19099646314076, 32.98941022411831), northeast: const LatLng(14.298480115337291, 33.00142651901866));
  }
  if (myServices.sharedPreferences.getString("city").toString() == "سنجة") {
    bounds = LatLngBounds(southwest: const LatLng(13.118517173911355, 33.92511597192735), northeast: const LatLng(13.176752244684081, 33.942877874542795));
  }
  if (myServices.sharedPreferences.getString("city").toString() == "سنار") {
    bounds = LatLngBounds(southwest: const LatLng(13.556928634287994, 33.544776881828), northeast: const LatLng(13.583627686340888, 33.582370719989896));
  }
  if (myServices.sharedPreferences.getString("city").toString() == "الدويم") {
    bounds = LatLngBounds(southwest: const LatLng(13.95323666542674, 32.30192786796919), northeast: const LatLng(14.048176870607564, 32.32029563364646));
  }
  if (myServices.sharedPreferences.getString("city").toString() == "كوستي") {
    bounds = LatLngBounds(southwest: const LatLng(13.051344807131548, 32.639675382404455), northeast: const LatLng(13.201468899846802, 32.70284676342536));
  }
  if (myServices.sharedPreferences.getString("city").toString() == "ربك") {
    bounds = LatLngBounds(southwest: const LatLng(13.157954008990483, 32.691930480273165), northeast: const LatLng(13.214445747424687, 32.786000906358645));
  }
  if (myServices.sharedPreferences.getString("city").toString() == "دنقلا") {
    bounds = LatLngBounds(southwest: const LatLng(19.035016705940368, 30.42495759301121), northeast: const LatLng(19.224445244129996, 30.497742010274425));
  }  
  if (myServices.sharedPreferences.getString("city").toString() == "الابيض") {
    bounds = LatLngBounds(southwest: const LatLng(13.123668617295639, 30.15856479307979), northeast: const LatLng(13.2282996857213, 30.274264550710466));
  }
  if (myServices.sharedPreferences.getString("city").toString() == "الدمازين") {
    bounds = LatLngBounds(southwest: const LatLng(11.760859623735456, 34.316481412743585), northeast: const LatLng(11.831266758292829, 34.38737755503063));
  }
  if (myServices.sharedPreferences.getString("city").toString() == "الفاشر") {
    bounds = LatLngBounds(southwest: const LatLng(13.562533748949216, 25.284430424499565), northeast: const LatLng(13.690992270446639, 25.405966668420216));
  }
  if (myServices.sharedPreferences.getString("city").toString() == "الضعين") {
    bounds = LatLngBounds(southwest: const LatLng(11.424274704500272, 26.092100583154213), northeast: const LatLng(11.496617386318562, 26.17106480943034));
  }
  if (myServices.sharedPreferences.getString("city").toString() == "النهود") {
    bounds = LatLngBounds(southwest: const LatLng(12.66261257976718, 28.38764158695742), northeast: const LatLng(12.719886414800403, 28.461455972389455));
  }
  if (myServices.sharedPreferences.getString("city").toString() == "الجنينة") {
    bounds = LatLngBounds(southwest: const LatLng(13.406116989822895, 22.392293656811418), northeast: const LatLng(13.493600541951073, 22.507993414442094));
  }
  if (myServices.sharedPreferences.getString("city").toString() == "نيالا") {
    bounds = LatLngBounds(southwest: const LatLng(11.99204862399133, 24.829829964383077), northeast: const LatLng(12.109227830899716, 24.829829964383077 != 24.971278926234227 ? 24.971278926234227 : 24.829829964383077));
  }
  if (myServices.sharedPreferences.getString("city").toString() == "حلفا الجديدة") {
    bounds = LatLngBounds(southwest: const LatLng(15.29795513673904, 35.58346453294468), northeast: const LatLng(15.352589028743687, 35.622431661998334));
  }
  

  return bounds;
}