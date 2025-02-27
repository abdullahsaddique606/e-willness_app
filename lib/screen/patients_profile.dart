import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myproject/constants/constatsvalue.dart';
import 'package:myproject/viewmodel/patient_viewmodel.dart';
import 'package:provider/provider.dart';

class
PatientProfile extends StatelessWidget {
  String? profileName;
  PatientProfile({super.key, required this.profileName});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<PatientViewModel>(builder: (context, viewModel, _) {
      return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white70,
          body: Container(
            margin: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.blue,
            ),
            height: DynamicSize.height(0.9, context),
            width: DynamicSize.width(0.97, context),
            child: Stack(
              children: [
                Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            const Text(
                              'Create Profile',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w500),
                            ),
                            IconButton(
                              icon: const Icon(Icons.settings),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        Stack(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 50.0,
                              backgroundImage: viewModel.selectedImage != null
                                  ? FileImage(viewModel.selectedImage!)
                                  : const AssetImage(
                                          "assets/images/profileimage.jpg")
                                      as ImageProvider,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () async {
                                  await viewModel.pickImageFromGallery();
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        const Text(
                          'Select Profile Picture',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value != null && value.isNotEmpty) {
                                return null;
                              }
                              return "Enter Full Name";
                            },
                            controller: viewModel.fullName,
                            decoration: InputDecoration(
                              hintText: 'Enter Full name',
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.account_circle),
                                onPressed: () {
                                  // Handle icon pressed
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                          child: TextFormField(
                            controller: viewModel.dob,
                            readOnly: true, // Make the TextFormField read-only
                            onTap: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );

                              if (pickedDate != null) {
                                // Format the date as per your requirements
                                String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                viewModel.dob.text = formattedDate;
                              }
                            },
                            decoration: const InputDecoration(
                              hintText: 'Date of Birth',
                              suffixIcon: Icon(Icons.calendar_today_sharp),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 20),
                          child: TextFormField(
                            validator: (value) {
                              if (value != null && value.isNotEmpty) {
                                return null;
                              }
                              return "Enter Age";
                            },
                            controller: viewModel.age,
                            decoration: InputDecoration(
                              hintText: 'Age',
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.man_outlined),
                                onPressed: () {
                                  // Handle icon pressed
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 20),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: SingleChildScrollView(
                              child: DropdownButtonFormField<List<String>>(
                                value: viewModel.selectedDiseases.isNotEmpty
                                    ? viewModel.selectedDiseases
                                    : null,
                                onChanged: (newValue) {
                                  if (newValue != null) {
                                    viewModel.selectedDiseases = newValue;
                                    viewModel.updateState();
                                  }
                                },
                                items: [
                                  DropdownMenuItem<List<String>>(
                                    value: viewModel.selectedDiseases,
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: List.generate(
                                          viewModel.patientDisease.length,
                                              (index) {
                                            final disease = viewModel
                                                .patientDisease[index];
                                            final isSelected = viewModel
                                                .selectedDiseases
                                                .contains(disease);

                                            return CheckboxListTile(
                                              title: Text(disease),
                                              value: isSelected,
                                              onChanged: (checked) {
                                                if (checked!) {
                                                  viewModel.selectedDiseases
                                                      .add(disease);
                                                } else {
                                                  viewModel.selectedDiseases
                                                      .remove(disease);
                                                }
                                                viewModel.updateState();
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                decoration: const InputDecoration(
                                  labelText: 'Select Specialist',
                                  contentPadding:
                                  EdgeInsets.only(top: 10, bottom: 20),
                                  border: InputBorder.none,
                                ),
                                isExpanded: true,
                                selectedItemBuilder: (BuildContext context) {
                                  return viewModel.selectedDiseases
                                      .map<Widget>((String disease) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2),
                                      child: Text(disease),
                                    );
                                  }).toList();
                                },
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 80,
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState != null &&
                                    _formKey.currentState!.validate()) {
                                  viewModel.savePatientData(profileName.toString());
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                "Create Profile",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
