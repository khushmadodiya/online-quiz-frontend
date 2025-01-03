import 'package:flutter/material.dart';
import '../model/marksmodel.dart';

class StudentMarksWidget extends StatelessWidget {
  final List<Marks> marksList;

  const StudentMarksWidget({super.key, required this.marksList});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Center(
      child: Container(

        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(

            columns: const [
              DataColumn(
                label: Text(
                  'No.',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Name',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Email',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Marks',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ],
            rows: marksList
                .asMap()
                .entries
                .map(
                  (entry) => DataRow(
                cells: [
                  DataCell(
                    Text(
                      '${entry.key + 1}', // Row number
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                  DataCell(
                    Text(
                      entry.value.student!.username,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                  DataCell(
                    Text(
                      entry.value.student!.email,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                  DataCell(
                    Text(
                      entry.value.marksObtained?.toString() ?? 'N/A',
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            )
                .toList(),
          ),
        ),
      ),
    );
  }
}
