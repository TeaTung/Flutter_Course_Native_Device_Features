import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';

import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> _showPreview(double latitude, double longitude) async {
    final previewUrl = LocationHelper.generatePreview(
      latitude: latitude,
      longitude: longitude,
    );
    setState(() {
      _previewImageUrl = previewUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();
      _showPreview(locData.latitude!, locData.longitude!);
      widget.onSelectPlace(locData.latitude, locData.longitude);
    } catch (error) {
      print(error);
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final selectedLocation =
        await Navigator.of(context).push<LatLng>(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (ctx) => MapScreen(
                  isSelecting: true,
                )));
    if (selectedLocation == null) {
      return;
    }
    //print(selectedLocation);
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _previewImageUrl == null
              ? Center(
                  child: Text('No Location Chosen'),
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              onPressed: _getCurrentUserLocation,
            ),
            SizedBox(width: 20),
            TextButton.icon(
              icon: Icon(Icons.map),
              label: Text('Select on Map'),
              onPressed: _selectOnMap,
            )
          ],
        )
      ],
    );
  }
}
