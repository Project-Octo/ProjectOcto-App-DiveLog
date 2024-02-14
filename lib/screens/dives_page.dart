import 'package:flutter/material.dart';

class DivesPage extends StatefulWidget {
  const DivesPage({Key? key}) : super(key: key);

  @override
  _DivesPageState createState() => _DivesPageState();
}

class _DivesPageState extends State<DivesPage> {
  late List<Map<String, dynamic>> diveRecords;
  late List<bool> _isExpandedList;

  @override
  void initState() {
    super.initState();
    diveRecords = [
      {
        'name': 'John Doe',
        'location': 'Maldives',
        'date': '2022-01-31',
        'maxDepth': '20 meters',
        'totalBottomTime': '50 minutes',
        'watchedFishCount': 5,
        'safetyStops': 'Yes',
        'tanks': 'Aluminum 80s',
        'weights': '20 lbs',
        'current': 'Mild',
        'visibility': '20 meters',
        'diveType': 'Recreational',
        'marineLife': 'Saw a turtle',
        'note': 'No special notes',
      },
      // Add more dive records as needed
    ];
    _isExpandedList = List.generate(diveRecords.length, (index) => false);
  }

  void deleteRecord(int index) {
    setState(() {
      diveRecords.removeAt(index);
      _isExpandedList.removeAt(index);
    });
  }

  void editRecord(int index) {
    final record = diveRecords[index];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Dive Record'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: record['name'],
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  record['name'] = value;
                },
              ),
              TextFormField(
                initialValue: record['location'],
                decoration: const InputDecoration(labelText: 'Location'),
                onChanged: (value) {
                  record['location'] = value;
                },
              ),
              // Add more form fields for other dive record fields
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                // Save the changes made in the dialog
              });
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void toggleExpansion(int index) {
    setState(() {
      _isExpandedList[index] = !_isExpandedList[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: diveRecords.length,
      itemBuilder: (BuildContext context, int index) {
        final record = diveRecords[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
          child: ExpansionTile(
            title: Text(
              record['name'] ?? '',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
            childrenPadding: const EdgeInsets.all(16.0),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _isExpandedList[index]
                  ? [
                      _buildInfoRow(Icons.location_on, 'Location',
                          record['location'] ?? ''),
                      _buildInfoRow(
                          Icons.calendar_today, 'Date', record['date'] ?? ''),
                      _buildInfoRow(Icons.arrow_downward, 'Max Depth',
                          record['maxDepth'] ?? ''),
                      _buildInfoRow(Icons.timer, 'Total Bottom Time',
                          record['totalBottomTime'] ?? ''),
                      _buildInfoRow(Icons.set_meal, 'Watched Fish Count',
                          record['watchedFishCount']?.toString() ?? ''),
                      _buildInfoRow(Icons.directions_boat, 'Dive Type',
                          record['diveType'] ?? ''),
                      _buildInfoRow(
                          Icons.short_text, 'Note', record['note'] ?? ''),
                    ]
                  : [
                      _buildInfoRow(Icons.location_on, 'Location',
                          record['location'] ?? ''),
                      _buildInfoRow(
                          Icons.calendar_today, 'Date', record['date'] ?? ''),
                      _buildInfoRow(Icons.arrow_downward, 'Max Depth',
                          record['maxDepth'] ?? ''),
                      _buildInfoRow(Icons.timer, 'Total Bottom Time',
                          record['totalBottomTime'] ?? ''),
                    ],
            ),
            trailing: _isExpandedList[index]
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _isExpandedList[index]
                            ? Icons.expand_less
                            : Icons.expand_more,
                        color: Colors.grey,
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        color: Colors.grey,
                        onPressed: () => editRecord(index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.grey,
                        onPressed: () => deleteRecord(index),
                      ),
                    ],
                  )
                : Icon(
                    _isExpandedList[index]
                        ? Icons.expand_less
                        : Icons.expand_more,
                    color: Colors.grey,
                  ),
            onExpansionChanged: (expanded) {
              toggleExpansion(index);
            },
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.grey[700],
            size: 20,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
