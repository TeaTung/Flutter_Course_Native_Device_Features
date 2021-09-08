import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../models/place.dart';

const MAPBOX_API_KEY =
    'pk.eyJ1IjoidGVhdHVuZyIsImEiOiJja3RiMTQ2d3QwNDJkMnFucjQyZHY3NTRhIn0.Sreh5fMooujPt2RPOpa22w';
const MAPBOX_USER = 'teatung';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  MapScreen(
      {this.initialLocation =
          const PlaceLocation(latitude: 29.228890, longitude: 110.545084),
      this.isSelecting = false});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<Marker> _markers = [];
  List<Widget> _actions = [];

  @override
  Widget build(BuildContext context) {
    LatLng? _pickedLocation;
    void _selectLocation(LatLng position) {
      setState(() {
        _pickedLocation = position;
        _markers.add(Marker(
          width: 50.0,
          height: 50.0,
          point: _pickedLocation!,
          builder: (ctx) => Container(
            child: FlutterLogo(),
          ),
        ));
        _actions.add(IconButton(
          icon: Icon(Icons.check),
          onPressed: () => Navigator.of(context).pop(_pickedLocation),
        ));
      });
    }

    //print('build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Map'),
        actions: _actions,
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(widget.initialLocation.latitude,
              widget.initialLocation.longitude),
          zoom: 13.0,
          onLongPress: widget.isSelecting ? _selectLocation : null,
        ),
        layers: [
          TileLayerOptions(
              urlTemplate:
                  "https://api.mapbox.com/styles/v1/teatung/cktb3qzo87hoq17k7f3gqmfaf/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoidGVhdHVuZyIsImEiOiJja3RiMHBuYWIxcmU4MnFwbHZlYXZzbjgzIn0.zWfW4LkJLM4vXUjDCAhEcA",
              additionalOptions: {
                'accessToken': MAPBOX_API_KEY,
                'id': 'mapbox.mapbox-streets-v7'
              }),
          MarkerLayerOptions(
            markers: widget.isSelecting
                ? _markers
                : [
                    Marker(
                      width: 50.0,
                      height: 50.0,
                      point: _pickedLocation ??
                          LatLng(widget.initialLocation.latitude,
                              widget.initialLocation.longitude),
                      builder: (ctx) => Icon(Icons.add_location),
                    )
                  ],
          ),
        ],
      ),
    );
  }
}
