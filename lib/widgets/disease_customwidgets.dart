import 'package:flutter/material.dart';
import 'package:myproject/screen/doctor_listscreen.dart';

class DiseaseListItem extends StatelessWidget {
  final String disease;

  const DiseaseListItem({Key? key, required this.disease}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint("---------------disease--${disease}");
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DoctorListScreen(selectedDisease: disease)),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.local_hospital, color: Colors.blue),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                disease,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
