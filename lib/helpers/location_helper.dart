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
}
