import 'package:almithaq/core/functions/calculatedistance.dart';

List sortSellersByRoute(
  List sellersCoord,
  double userLat,
  double userLong,
) {
  List sorted = [];
  List remaining = List.from(sellersCoord);

  double currentLat = userLat;
  double currentLong = userLong;

  while (remaining.isNotEmpty) {
    var nearest = remaining.first;

    double minDistance = calculateDistance(
      currentLat,
      currentLong,
      nearest["seller_lat"].toDouble(),
      nearest["seller_long"].toDouble(),
    );

    for (var seller in remaining) {
      double dist = calculateDistance(
        currentLat,
        currentLong,
        seller["seller_lat"].toDouble(),
        seller["seller_long"].toDouble(),
      );

      if (dist < minDistance) {
        minDistance = dist;
        nearest = seller;
      }
    }

    sorted.add(nearest);
    remaining.remove(nearest);

    currentLat = nearest["seller_lat"].toDouble();
    currentLong = nearest["seller_long"].toDouble();
  }

  return sorted;
}