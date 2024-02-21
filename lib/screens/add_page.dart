import 'package:flutter/material.dart';

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class AddPage extends StatefulWidget {
  const AddPage({Key? key});

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _maxDepthController = TextEditingController();
  final TextEditingController _totalBottomTimeController =
      TextEditingController();
  final TextEditingController _watchedFishCountController =
      TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  File? _videoFile;

  String _selectedType = 'Single Gas'; // Default type
  final RegExp _dateRegExp = RegExp(
    r'^\d{4}-\d{2}-\d{2}$',
  );

  bool _isFormValid() {
    return _nameController.text.isNotEmpty &&
        _dateController.text.isNotEmpty &&
        _locationController.text.isNotEmpty &&
        _maxDepthController.text.isNotEmpty &&
        _totalBottomTimeController.text.isNotEmpty &&
        _watchedFishCountController.text.isNotEmpty &&
        _videoFile != null;
  }

  Future<void> _upload() async {
    // 사용자가 입력한 폼 검사
    if (!_isFormValid()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(
              'Please fill all the required fields and select a video.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    // 서버 엔드포인트 설정
    var uri = Uri.parse('YOUR_SERVER_UPLOAD_ENDPOINT');

    // 파일 업로드를 위한 multipart 요청 생성
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('video', _videoFile!.path));

    // 요청 보내기
    var response = await request.send();

    // 응답 확인
    if (response.statusCode == 200) {
      print('Video uploaded successfully');
    } else {
      print('Failed to upload video. Error: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Dive Information'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          padding: const EdgeInsets.only(left: 10.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
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
                              value: type,
                              child: Text(type),
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
              const SizedBox(height: 20.0),
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
                child: const Text('Select Video'),
              ),
              if (_videoFile != null)
                Text('Selected video: ${_videoFile!.path}'),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _upload,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
