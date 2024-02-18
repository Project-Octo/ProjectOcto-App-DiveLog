import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String _selectedVideo = '';
  String _selectedLocation = '';
  DateTime? _selectedDateTime;
  String _selectedWeather = '';

  Future<void> _selectVideo() async {
    // TODO: Implement video selection from file or gallery
  }

  Future<void> _selectLocation() async {
    // TODO: Implement location selection from list or GPS
  }

  void _selectDateTime() {
    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      onChanged: (date) {
        setState(() {
          _selectedDateTime = date;
        });
      },
      currentTime: DateTime.now(),
    );
  }

  void _selectWeather() {
    // TODO: Implement weather selection
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Dive Record'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Dive Video',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _selectVideo,
                icon: const Icon(Icons.video_library),
                label: Text(
                    _selectedVideo.isNotEmpty ? 'Selected' : 'Select Video'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Dive Location',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _selectLocation,
                icon: const Icon(Icons.location_on),
                label: Text(_selectedLocation.isNotEmpty
                    ? _selectedLocation
                    : 'Select Location'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Dive Time',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _selectDateTime,
                icon: const Icon(Icons.access_time),
                label: Text(_selectedDateTime != null
                    ? _selectedDateTime.toString()
                    : 'Select Time'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Weather Conditions',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _selectWeather,
                icon: const Icon(Icons.wb_sunny),
                label: Text(_selectedWeather.isNotEmpty
                    ? _selectedWeather
                    : 'Select Weather'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement dive record submission logic
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
