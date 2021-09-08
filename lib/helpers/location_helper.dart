import 'package:http/http.dart' as http;
import 'dart:convert';

const MAP_BOX_API =
    'pk.eyJ1IjoidGVhdHVuZyIsImEiOiJja3RiMTQ2d3QwNDJkMnFucjQyZHY3NTRhIn0.Sreh5fMooujPt2RPOpa22w';

class LocationHelper {
  static String generateLocationPreviewImage(
      {required double latitude, required double longitude}) {
    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-l($longitude,$latitude)/$longitude,$latitude,14.25,0,0/600x300?access_token=$MAP_BOX_API';
  }

  static String generatePreview(
      {required double latitude, required double longitude}) {
    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-l($longitude,$latitude)/$longitude,$latitude,14.25,0,0/600x300?access_token=$MAP_BOX_API';
  }

  static Future<String> getPlaceAddress(
      double latitude, double longitude) async {
    final url = Uri.parse(
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$longitude,$latitude.json?access_token=$MAP_BOX_API');
    final response = await http.get(url);
    return json.decode(response.body)['features'][0]['place_name'];
  }
}
