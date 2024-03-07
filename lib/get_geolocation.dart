import 'package:geocoding/geocoding.dart';

class GetAddress{
  final double latitude;
  final double longitude;
  GetAddress({
    required this.latitude,
    required this.longitude
  });
  String address() {
    String? output = "";
    List<Placemark> placemarks =  placemarkFromCoordinates(latitude, longitude) as List<Placemark> ;
    if (placemarks.isNotEmpty) {
      String? name = placemarks[0].name;
      String? subLocality = placemarks[0].subLocality;
      String? locality = placemarks[0].locality;
      String? administrativeArea = placemarks[0].administrativeArea;
      String? postalCode = placemarks[0].postalCode;
      String? country = placemarks[0].country;
      output = "found$name, $subLocality, $locality, $administrativeArea, $postalCode, $country";
    }
    else{
      output = "Not found";
    }
    return output;
  }
  String getAddressFromLatLng() {
    String getAddress = "Not Found";
    placemarkFromCoordinates(
        latitude, longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      getAddress = "${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}";
      });
      return getAddress;
    }
}