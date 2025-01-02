// ignore_for_file: omit_local_variable_types

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hni_customers_app/blocs/homepage/widget/camera_screen.dart';
import 'package:hni_customers_app/core/app_color.dart';
import 'package:hni_customers_app/model/hni_customer_met_model.dart';
import 'package:hni_customers_app/utils/shared_preference.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart';

class DynamicForm extends StatefulWidget {
  const DynamicForm({
    required this.hniCustomerMetResponce,
    required this.allForms,
    super.key,
  });
  final HniCustomerMetResponce hniCustomerMetResponce;
  final List<HniCustomerMetResponce> allForms;

  @override
  State<DynamicForm> createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  HniCustomerMetResponce? _selectedForm;
  final Map<int, TextEditingController> _controllers = {};
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _selectedForm = widget.hniCustomerMetResponce;

    // Initialize controllers for existing fields
    for (final Question question
        in _selectedForm?.data?.getUserForm?.questions ?? []) {
      question.userResponse ??= '';
      _controllers[question.id!] = TextEditingController(
        text: question.userResponse as String? ??
            '', // Initialize with existing value
      );
      _initializeNestedControllers(question);
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _initializeNestedControllers(Question question) {
    if (question.questionType == 'FORM' && question.options != null) {
      for (final nestedForm in question.options!) {
        for (final Question nestedQuestion in nestedForm.questions ?? []) {
          nestedQuestion.userResponse ??= '';
          _controllers.putIfAbsent(
            nestedQuestion.id!,
            () => TextEditingController(
              text: nestedQuestion.userResponse as String? ?? '',
            ),
          );
          _initializeNestedControllers(nestedQuestion); // Recursive call
        }
      }
    }
  }

  Future<void> _fetchLocation(BuildContext context, Question question) async {
    // Check if running on the web
    if (kIsWeb) {
      try {
        // Check and request permissions
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          permission = await Geolocator.requestPermission();
        }

        if (permission == LocationPermission.whileInUse ||
            permission == LocationPermission.always) {
          // Fetch location
          final position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );
          setState(() {
            question.userResponse =
                '${position.latitude}, ${position.longitude}';
          });
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('Location: ${position.latitude}, ${position.longitude}'),
            ),
          );
        } else {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Location permissions are denied'),
            ),
          );
        }
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching location: $e')),
        );
      }
    } else {
      final status = await Permission.location.request();
      if (status.isGranted) {
        // Fetch location
        final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        setState(() {
          question.userResponse = '${position.latitude}, ${position.longitude}';
        });
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Location: ${position.latitude}, ${position.longitude}',
            ),
          ),
        );
      } else {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permission denied')),
        );
      }
    }
  }

  Future<void> _fetchCameraImage(Question question) async {
    if (kIsWeb) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Camera is not supported on the web')),
      );
      return;
    }

    try {
      if (kIsWeb) {
        // Web: Allow user to pick an image from file picker
        final XFile? pickedFile = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );
        setState(() {
          question.userResponse = pickedFile?.path;
        });
      } else {
        try {
          WidgetsFlutterBinding.ensureInitialized();
          final cameras = await availableCameras();
          if (!mounted) return;
          final image = await Navigator.push<String>(
            context,
            MaterialPageRoute(
              builder: (context) => CameraScreen(cameras: cameras),
            ),
          );
          if (image != null) {
            setState(() {
              _imageFile = File(image);
              question.userResponse = _imageFile!.path;
            });
          }
        } catch (e) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No image selected $e')),
          );
        }
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error accessing camera: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final questions = _selectedForm?.data?.getUserForm?.questions;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.hniCustomerMetResponce.data?.getUserForm?.name ?? 'Questions',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView.builder(
          itemCount: (questions?.length ?? 0) +
              2, // +1 for the Dropdown, +1 for Submit button
          itemBuilder: (context, index) {
            if (index == 0) {
              // The first item is the DropdownButtonFormField
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      top: 10,
                      bottom: 10,
                    ),
                    child: Text(
                      'Log in your work',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: DropdownButtonFormField<HniCustomerMetResponce>(
                      icon: Icon(
                        Icons.arrow_drop_down_circle_outlined,
                        color: Theme.of(context).primaryColor,
                      ),
                      value: _selectedForm,
                      items: widget.allForms.map((form) {
                        return DropdownMenuItem<HniCustomerMetResponce>(
                          value: form,
                          child: Text(
                            form.data?.getUserForm?.name ?? 'Unnamed Form',
                          ),
                        );
                      }).toList(),
                      onChanged: (form) {
                        setState(() {
                          _selectedForm = form;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Select Form',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              );
            } else if (index == (questions?.length ?? 0) + 1) {
              // The last item is the Submit button
              return Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(
                    'Submit',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              );
            }

            final question = questions![index - 1];
            return Padding(
              padding: const EdgeInsets.all(16),
              child: _buildQuestionWidget(question),
            );
          },
        ),
      ),
    );
  }

  Widget _buildQuestionWidget(Question question) {
    if (question.questionType == 'TEXTFORMFIELD') {
      return _buildTextFormField(question);
    } else if (question.questionType == 'MOBILENUMBER') {
      return _buildMobileNumberField(question);
    } else if (question.questionType == 'RADIO') {
      return _buildRadioButton(question);
    } else if (question.questionType == 'FORM') {
      return _buildNestedForm(question);
    } else if (question.questionType == 'ELEVATEDBUTTON') {
      return _buildElevatedButton(question);
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildTextFormField(Question question) {
    _controllers.putIfAbsent(
      question.id!,
      () => TextEditingController(
        text: question.userResponse as String? ?? '', // Default to empty string
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${question.question}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black),
                ),
                if (question.isMandatoryField ?? false)
                  TextSpan(
                    text: '*',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: AppColors.darkRed),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _controllers[question.id],
          key: ValueKey(question.id),
          maxLines: question.maxLines,
          decoration: InputDecoration(
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
            ),
            hintText: question.hintText,
            border: const OutlineInputBorder(),
          ),
          validator: (value) {
            if ((question.isMandatoryField ?? false) &&
                (value == null || value.isEmpty)) {
              return 'This field is required';
            }
            return null;
          },
          onChanged: (value) {
            question.userResponse = value;
          },
        ),
      ],
    );
  }

  Widget _buildMobileNumberField(Question question) {
    _controllers.putIfAbsent(
      question.id!,
      () => TextEditingController(text: question.userResponse as String? ?? ''),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${question.question}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black),
                ),
                if (question.isMandatoryField ?? false)
                  TextSpan(
                    text: '*',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: AppColors.darkRed),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _controllers[question.id],
          key: ValueKey(question.id),
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: question.hintText,
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
            ),
            border: const OutlineInputBorder(),
          ),
          validator: (value) {
            if ((question.isMandatoryField ?? false) &&
                (value == null || value.isEmpty)) {
              return 'This field is required';
            }
            if (question.reValidation != null &&
                !RegExp(question.reValidation!).hasMatch(value!)) {
              return 'Invalid phone number';
            }
            return null;
          },
          onChanged: (value) {
            question.userResponse = value;
          },
        ),
      ],
    );
  }

  Widget _buildRadioButton(Question question) {
    question.userResponse ??= question.options?.first.id.toString();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 3),
          child: Text(
            question.question ?? '',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.black),
          ),
        ),
        if (question.options != null)
          Wrap(
            spacing: 20,
            children: question.options!.map<Widget>((option) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<String>(
                    key: ValueKey('${question.id}_${option.id}'),
                    value: option.id!.toString(),
                    groupValue: question.userResponse.toString(),
                    onChanged: (value) {
                      setState(() {
                        question.userResponse = value;
                      });
                    },
                  ),
                  Text(
                    option.option ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.black),
                  ),
                ],
              );
            }).toList(),
          )
        else
          Container(),
      ],
    );
  }

  Widget _buildElevatedButton(Question question) {
    return ElevatedButton(
      onPressed: () {
        if (question.answerType == 'FETCHLOCATION') {
        } else if (question.answerType == 'FETCHCAMERA') {}
      },
      child: Text(
        question.question ?? '',
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }

  Widget _buildElevatedButtonwithIcon(Question question) {
    return ElevatedButton.icon(
      icon: question.answerType == 'FETCHLOCATION'
          ? const Icon(Icons.location_searching)
          : const Icon(Icons.camera),
      onPressed: () async {
        if (question.answerType == 'FETCHLOCATION') {
          await _fetchLocation(context, question);
        } else if (question.answerType == 'FETCHCAMERA') {
          await _fetchCameraImage(question);
        }
      },
      label: Text(question.question ?? ''),
    );
  }

  Widget _buildNestedForm(Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...question.options!.map<Widget>((nestedForm) {
          if (nestedForm.name == 'location & selfie') {
            return Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(
                          '${nestedForm.questions![0].question}*',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildElevatedButtonwithIcon(nestedForm.questions![0]),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(
                          nestedForm.questions![1].question ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildElevatedButtonwithIcon(nestedForm.questions![1]),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: nestedForm.questions!
                  .map<Widget>(_buildQuestionWidget)
                  .toList(),
            );
          }
        }),
      ],
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      await SharedPreferencesHelper.saveLatestUserData(_selectedForm!);
      for (final Question question
          in _selectedForm!.data?.getUserForm?.questions ?? []) {
        question.userResponse = null;
        if (question.questionType == 'FORM' && question.options != null) {
          for (final nestedForm in question.options!) {
            for (final Question nestedQuestion in nestedForm.questions ?? []) {
              nestedQuestion.userResponse = null;
            }
          }
        }
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Form saved successfully!')),
        );
      }

      if (mounted) {
        Navigator.pop(context);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Validation failed')),
      );
    }
  }
}
