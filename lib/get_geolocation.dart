import 'package:geocoding/geocoding.dart';
import 'package:mobile_app/permission_request.dart';

class GetAddress{
  final double latitude;
  final double longitude;
  GetAddress({
    required this.latitude,
    required this.longitude
  });

  Future<String> getAddressFromLatLng() async {
    String getAddress = "Not Found";
    await placemarkFromCoordinates(
        latitude, longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      getAddress = "${place.street}, ${place.locality}, ${place.country}";
      });
      return getAddress;
    }
}