import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _maxDepthController = TextEditingController();
  TextEditingController _totalBottomTimeController = TextEditingController();
  TextEditingController _watchedFishCountController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  File? _videoFile;

  String _selectedType = 'Single Gas'; // Default type
  final RegExp _dateRegExp = RegExp(
    r'^\d{4}-\d{2}-\d{2}$',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Dive Information'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Container(
          padding: EdgeInsets.only(left: 10.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                    labelText: 'Date (yyyy-MM-dd)',
                    prefixIcon: Icon(Icons.calendar_today)),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (!_dateRegExp.hasMatch(value!)) {
                    return _dateRegExp.pattern;
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                    labelText: 'Location',
                    prefixIcon: Icon(Icons.location_on_sharp)),
              ),
              DropdownButtonFormField(
                value: _selectedType,
                items:
                    ['Single Gas', 'Multi Gas', 'Gauge', 'Apnea Hunt', 'Apnea']
                        .map((type) => DropdownMenuItem(
                              child: Text(type),
                              value: type,
                            ))
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedType = value!;
                  });
                },
                decoration: const InputDecoration(
                    labelText: 'Type', prefixIcon: Icon(Icons.anchor_sharp)),
              ),
              TextFormField(
                controller: _maxDepthController,
                decoration: const InputDecoration(
                    labelText: 'Max Depth (m)', prefixIcon: Icon(Icons.water)),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _totalBottomTimeController,
                decoration: const InputDecoration(
                    labelText: 'Total Bottom Time (min)',
                    prefixIcon: Icon(Icons.timer_outlined)),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _watchedFishCountController,
                decoration: const InputDecoration(
                    labelText: 'Watched Fish Count',
                    prefixIcon: Icon(Icons.remove_red_eye_outlined)),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _noteController,
                decoration: const InputDecoration(
                    labelText: 'Note', prefixIcon: Icon(Icons.edit_note_sharp)),
                maxLines: null,
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(type: FileType.video);
                  if (result != null) {
                    setState(() {
                      _videoFile = File(result.files.single.path!);
                    });
                  }
                },
                child: Text('Select Video'),
              ),
              if (_videoFile != null)
                Text('Selected video: ${_videoFile!.path}'),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Save dive information to database or perform desired action
                  // You can access the entered information using the controllers
                  // Also use _videoFile to access the selected video file
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
