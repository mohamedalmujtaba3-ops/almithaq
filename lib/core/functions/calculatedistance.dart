import 'dart:math';

double calculateDistance(
  double lat1,
  double lng1,
  double lat2,
  double lng2,
) {
  const double earthRadius = 6371; // بالكيلومتر

  double dLat = _toRadians(lat2 - lat1);
  double dLng = _toRadians(lng2 - lng1);

  double a = pow(sin(dLat / 2), 2) +
      cos(_toRadians(lat1)) *
      cos(_toRadians(lat2)) *
      pow(sin(dLng / 2), 2);

  double c = 2 * asin(sqrt(a));

  return earthRadius * c;
}

double _toRadians(double degree) {
  return degree * pi / 180;
}