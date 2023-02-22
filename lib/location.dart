// ignore_for_file: unnecessary_brace_in_string_interps
import 'package:flutter/material.dart';
import 'package:flutter_demo/location_controller.dart';
import 'package:flutter_demo/location_service.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  UserLocationController userLocationController = Get.find();
  final LocationService locationService = LocationService();
  dynamic data;
  var myDest;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    await userLocationController.getLocation();
    data = await locationService.postData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Location")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Your Live Location: ' +
                    '${userLocationController.address}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () async {
                      var addresses = await Geocoder.local
                          .findAddressesFromQuery(
                              data['response']['viewdetaildata'][0]['address']);
                      var first = addresses.first.coordinates;

                      String googleUrl =
                          'https://www.google.com/maps/dir/?api=1&origin=${userLocationController.latitude},${userLocationController.longitude}&destination=${first}&travelmode=driving&dir_action=navigate';
                      if (await canLaunch(googleUrl)) {
                        await launch(googleUrl);
                      } else {
                        throw 'Could not open the map.';
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Get Destination',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
