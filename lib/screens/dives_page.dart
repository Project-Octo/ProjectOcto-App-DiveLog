import 'package:flutter/material.dart';

class DivesPage extends StatefulWidget {
  const DivesPage({Key? key}) : super(key: key);

  @override
  _DivesPageState createState() => _DivesPageState();
}

class _DivesPageState extends State<DivesPage> {
  late List<Map<String, dynamic>> diveRecords;
  late List<bool> _isExpandedList; // _isExpandedList 변수 추가

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
      },
      {
        'name': 'Jane Smith',
        'location': 'Great Barrier Reef',
        'date': '2022-02-15',
        'maxDepth': '25 meters',
        'totalBottomTime': '60 minutes',
        'watchedFishCount': 8,
        'safetyStops': 'No',
        'tanks': 'Steel 100s',
        'weights': '15 lbs',
        'current': 'Strong',
        'visibility': '15 meters',
        'diveType': 'Technical',
        'marineLife': 'Spotted a clownfish',
      },
      {
        'name': 'Alex Johnson',
        'location': 'Red Sea',
        'date': '2022-03-20',
        'maxDepth': '30 meters',
        'totalBottomTime': '45 minutes',
        'watchedFishCount': 10,
        'safetyStops': 'Yes',
        'tanks': 'Steel 120s',
        'weights': '18 lbs',
        'current': 'Moderate',
        'visibility': '25 meters',
        'diveType': 'Recreational',
        'marineLife': 'Swam with dolphins',
      },
      {
        'name': 'Emily Brown',
        'location': 'Galapagos Islands',
        'date': '2022-04-10',
        'maxDepth': '18 meters',
        'totalBottomTime': '55 minutes',
        'watchedFishCount': 6,
        'safetyStops': 'Yes',
        'tanks': 'Aluminum 80s',
        'weights': '16 lbs',
        'current': 'Mild',
        'visibility': '20 meters',
        'diveType': 'Recreational',
        'marineLife': 'Encountered a hammerhead shark',
      },
      {
        'name': 'Michael Wilson',
        'location': 'Cocos Island',
        'date': '2022-05-05',
        'maxDepth': '40 meters',
        'totalBottomTime': '75 minutes',
        'watchedFishCount': 12,
        'safetyStops': 'Yes',
        'tanks': 'Steel 100s',
        'weights': '20 lbs',
        'current': 'Strong',
        'visibility': '30 meters',
        'diveType': 'Technical',
        'marineLife': 'Saw a school of hammerhead sharks',
      },

      // Add more dive records as needed
    ];
    _isExpandedList = List.generate(
        diveRecords.length, (index) => false); // Initialize _isExpandedList
  }

  void deleteRecord(int index) {
    setState(() {
      diveRecords.removeAt(index);
      _isExpandedList.removeAt(index); // 확장 상태를 추적하는 리스트에서도 제거
    });
  }

  void editRecord(int index) {
    // Implement edit functionality here
    // You can navigate to a new page for editing or show a dialog
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
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
          child: ExpansionTile(
            title: Text(
              record['name'] ?? '',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
            childrenPadding: const EdgeInsets.all(16.0),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!_isExpandedList[index]) ...[
                  _buildInfoRow(
                      Icons.location_on, 'Location', record['location'] ?? ''),
                  _buildInfoRow(
                      Icons.calendar_today, 'Date', record['date'] ?? ''),
                  _buildInfoRow(Icons.arrow_downward, 'Max Depth',
                      record['maxDepth'] ?? ''),
                  _buildInfoRow(Icons.timer, 'Total Bottom Time',
                      record['totalBottomTime'] ?? ''),
                  _buildInfoRow(Icons.set_meal, 'Watched Fish Count',
                      record['watchedFishCount']?.toString() ?? ''),
                ],
                if (_isExpandedList[index]) ...[
                  _buildInfoRow(
                      Icons.location_on, 'Location', record['location'] ?? ''),
                  _buildInfoRow(
                      Icons.calendar_today, 'Date', record['date'] ?? ''),
                  _buildInfoRow(Icons.arrow_downward, 'Max Depth',
                      record['maxDepth'] ?? ''),
                  _buildInfoRow(Icons.timer, 'Total Bottom Time',
                      record['totalBottomTime'] ?? ''),
                  _buildInfoRow(Icons.set_meal, 'Watched Fish Count',
                      record['watchedFishCount']?.toString() ?? ''),
                  _buildInfoRow(Icons.warning, 'Safety Stops',
                      record['safetyStops'] ?? ''),
                  _buildInfoRow(
                      Icons.local_gas_station, 'Tanks', record['tanks'] ?? ''),
                  _buildInfoRow(
                      Icons.fitness_center, 'Weights', record['weights'] ?? ''),
                  _buildInfoRow(
                      Icons.waves, 'Current', record['current'] ?? ''),
                  _buildInfoRow(Icons.visibility, 'Visibility',
                      record['visibility'] ?? ''),
                  _buildInfoRow(Icons.directions_boat, 'Dive Type',
                      record['diveType'] ?? ''),
                  _buildInfoRow(Icons.bubble_chart, 'Marine Life',
                      record['marineLife'] ?? ''),
                ],
              ],
            ),
            trailing: _isExpandedList[index]
                ? const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        color: Colors.grey,
                        onPressed: null,
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.grey,
                        onPressed: null,
                      ),
                    ],
                  )
                : null,
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
