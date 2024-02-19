import 'package:flutter/material.dart';

class DivesPage extends StatefulWidget {
  const DivesPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
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
        'maxDepth': '20',
        'totalBottomTime': '50',
        'watchedFishCount': '5',
        'visibility': '20 meters',
        'diveType': 'Recreational',
        'note': 'My first dive!! It was Gooood!!!!',
      },
      {
        'name': 'Jane Smith',
        'location': 'Hawaii',
        'date': '2022-02-15',
        'maxDepth': '15',
        'totalBottomTime': '45',
        'watchedFishCount': '3',
        'visibility': '15 meters',
        'diveType': 'Recreational',
        'note': 'Beautiful coral reefs!',
      },
      {
        'name': 'Alice Johnson',
        'location': 'Great Barrier Reef',
        'date': '2022-03-05',
        'maxDepth': '25',
        'totalBottomTime': '60',
        'watchedFishCount': '8',
        'visibility': '25 meters',
        'diveType': 'Recreational',
        'note': 'Saw a shark!',
      },
    ];
    _isExpandedList = List.generate(diveRecords.length, (index) => false);
  }

  // void deleteRecord(int index) {
  //   setState(() {
  //     //TODO: 삭제 로직
  //     diveRecords.removeAt(index);
  //     _isExpandedList.removeAt(index);
  //   });
  // }

  // void editRecord(int index) {
  //   final record = diveRecords[index];
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text('Edit Dive Record'),
  //       content: SingleChildScrollView(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             TextFormField(
  //               initialValue: record['name'],
  //               decoration: const InputDecoration(labelText: 'Name'),
  //               onChanged: (value) {
  //                 record['name'] = value;
  //               },
  //             ),
  //             TextFormField(
  //               initialValue: record['location'],
  //               decoration: const InputDecoration(labelText: 'Location'),
  //               onChanged: (value) {
  //                 record['location'] = value;
  //               },
  //             ),
  //             // Add more form fields for other dive record fields
  //           ],
  //         ),
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           },
  //           child: const Text('Cancel'),
  //         ),
  //         TextButton(
  //           onPressed: () {
  //             setState(() {
  //               // Save the changes made in the dialog
  //             });
  //             Navigator.of(context).pop();
  //           },
  //           child: const Text('Save'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  void toggleExpansion(int index) {
    setState(() {
      _isExpandedList[index] = !_isExpandedList[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 238, 248, 255),
      child: ListView.builder(
        itemCount: diveRecords.length,
        itemBuilder: (BuildContext context, int index) {
          final record = diveRecords[index];
          return Card(
            elevation: 0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: ExpansionTile(
                //카드 제목 및 날짜
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "#${(index + 1).toString()} ${record['name'] ?? ''}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      " / ${record['date'] ?? ''}",
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w200,
                          color: Colors.black54),
                    ),
                  ],
                ),
                tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
                childrenPadding: const EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // 타일의 모서리를 라운드 처리
                ),
                subtitle: Column(
                  //본문
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _isExpandedList[index]
                      ?
                      //확장된 상태
                      [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on_outlined,
                                          color: Colors.black87,
                                          size: 20.0,
                                        ),
                                        Text(
                                          " ${record['location'] ?? ''}",
                                          style: const TextStyle(
                                              color: Colors.black87,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.water,
                                                color: Colors.black87,
                                                size: 20.0,
                                              ),
                                              Text(
                                                " ${record['maxDepth'] + " m" ?? ''}",
                                                style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.access_time_rounded,
                                                color: Colors.black87,
                                                size: 20.0,
                                              ),
                                              Text(
                                                " ${record['totalBottomTime'] + " min" ?? ''}",
                                                style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.remove_red_eye_outlined,
                                                color: Colors.black87,
                                                size: 20.0,
                                              ),
                                              Text(
                                                " ${record['watchedFishCount'] + " species" ?? ''}",
                                                style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        ]),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Dive Type: ${record['diveType'] ?? ''}",
                                      style: const TextStyle(
                                          color: Colors.black87, fontSize: 15),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Note: ${record['note'] ?? ''}",
                                      style: const TextStyle(
                                          color: Colors.black87, fontSize: 15),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ]
                      :
                      //확장되지 않은 상태
                      [
                          //not expanded
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on_outlined,
                                          color: Colors.black87,
                                          size: 20.0,
                                        ),
                                        Text(
                                          " ${record['location'] ?? ''}",
                                          style: const TextStyle(
                                              color: Colors.black87,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.water,
                                              color: Colors.black87,
                                              size: 20.0,
                                            ),
                                            Text(
                                              " ${record['maxDepth'] + " m" ?? ''}",
                                              style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.access_time_rounded,
                                              color: Colors.black87,
                                              size: 20.0,
                                            ),
                                            Text(
                                              " ${record['totalBottomTime'] + " min" ?? ''}",
                                              style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.remove_red_eye_outlined,
                                              color: Colors.black87,
                                              size: 20.0,
                                            ),
                                            Text(
                                              " ${record['watchedFishCount'] + " species" ?? ''}",
                                              style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                ),
                onExpansionChanged: (expanded) {
                  toggleExpansion(index);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
