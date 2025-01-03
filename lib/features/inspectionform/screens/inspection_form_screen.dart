import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/local/app_localizations.dart';
import '../../../core/utils/alert.dart';
import '../../../core/utils/navigation_utils.dart';
import '../constant/accessories.dart';
import '../constant/installation_type.dart';
import '../controller/inspection_checklist_controller.dart';
import '../viewmodels/inspection_form_viewmodel.dart';
import '../widgets/custom_add_field.dart';
import '../widgets/custom_date_picker.dart';
import '../widgets/custom_location_field.dart';
import '../widgets/custom_photo_field.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/inspection_checklist_field.dart';

class InspectionFormScreen extends StatefulWidget {
  final dynamic params;
  InspectionFormScreen({super.key, required this.params});
  @override
  State<InspectionFormScreen> createState() => _InspectionFormState();
}


class _InspectionFormState extends State<InspectionFormScreen> {

  // Controllers for text fields
  final TextEditingController saleOrderController = TextEditingController();
  final TextEditingController ticketNoController = TextEditingController();
  final TextEditingController odoController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController installationDateController = TextEditingController();
  final TextEditingController installationLocationController = TextEditingController();
  final TextEditingController otherController = TextEditingController();

  final InspectionChecklistController engineOilController = InspectionChecklistController();
  final InspectionChecklistController transmissionController = InspectionChecklistController();
  final InspectionChecklistController differentialController = InspectionChecklistController();
  // Images
  // Images and delete flags

  File? frontViewImage;
  bool frontViewImageDelete = false;

  File? backViewImage;
  bool backViewImageDelete = false;

  File? carChassisImage;
  bool carChassisImageDelete = false;

  File? gpsDevicesImage;
  bool gpsDevicesImageDelete = false;

  File? beforeInstallationImage;
  bool beforeInstallationImageDelete = false;

  File? afterInstallationImage;
  bool afterInstallationImageDelete = false;

  File? antennaGPSImage;
  bool antennaGPSImageDelete = false;

  File? accessoriesImage;
  bool accessoriesImageDelete = false;

  File? additionalEquipmentImg1;
  bool additionalEquipmentImg1Delete = false;

  File? additionalEquipmentImg2;
  bool additionalEquipmentImg2Delete = false;

  File? additionalImage;
  bool additionalImageDelete = false;

  Map<String, dynamic>? jobDetails;
  bool isLoading = true;
  bool notEditing = true;

  @override
  void initState() {
    super.initState();
    _loadJobDetails();
  }

  void _toggleEditing() {
    setState(() {
      notEditing = !notEditing;
    });
  }

  void _confirmCancel()  async {
    bool confirmed = await Alert.showConfirmDialog(
      context: context,
      title: AppLocalizations.of(context).translate('confirm_cancel_title'),
      content: AppLocalizations.of(context).translate('confirm_cancel_content'),
    );

    if (confirmed) {
      _toggleEditing();
      _loadJobDetails();
    }
  }

  void _loadJobDetails() async {
    setState(() {
      isLoading = true; // Hiển thị hiệu ứng loading
    });
    final viewModel = Provider.of<InspectionFormViewmodel>(context, listen: false);
    final details = await viewModel.getDetailJob(widget.params);
    if (details != null) {
      setState(() {
        jobDetails = details;
        isLoading = false;
        engineOilController.setInitialStatus(
          jobDetails?['engine_oil_status'] ?? CAR_PARAMETER_STATUS.NA,
        );
        transmissionController.setInitialStatus(
          jobDetails?['transmission_status'] ?? CAR_PARAMETER_STATUS.NA,
        );
        differentialController.setInitialStatus(
          jobDetails?['differential_status'] ?? CAR_PARAMETER_STATUS.NA,
        );
      });
      saleOrderController.text = jobDetails?['sale_order'] ?? '';
      ticketNoController.text = jobDetails?['ticket_no'] ?? '';
      odoController.text = jobDetails?['odometer_reading'] ?? '';
      notesController.text = jobDetails?['notes'] ?? '';
      noteController.text = jobDetails?['note'] ?? '';
      installationDateController.text = jobDetails?['installation_date'] ?? '';
      installationLocationController.text = jobDetails?['installation_location'] ?? '';
      otherController.text = jobDetails?['other'] ?? '';

    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Selected values for CustomAddField
  List<String> selectedInstallationTypes = [];
  List<String> selectedAccessories = [];

  Future<void> _onSave() async {
    // Collect all data
    final Map<String, dynamic> formData = {
      'installation_type': (selectedInstallationTypes.isNotEmpty ? selectedInstallationTypes.join(", ") : ''),
      'accessories': (selectedAccessories.isNotEmpty ? selectedAccessories.join(", ") : ''),
      'note': noteController.text.isNotEmpty ? noteController.text : '',
      'installation_date': installationDateController.text.isNotEmpty ? installationDateController.text : '',
      'installation_location': installationLocationController.text.isNotEmpty ? installationLocationController.text : '',
      'odometer_reading': odoController.text.isNotEmpty ? odoController.text : '',
      'front_view_img_file': frontViewImage,
      'front_view_img_del': frontViewImageDelete,
      'back_view_img_file': backViewImage,
      'back_view_img_del': backViewImageDelete,
      'car_chassis_img_file': carChassisImage,
      'car_chassis_img_del': carChassisImageDelete,
      'gps_devices_img_file': gpsDevicesImage,
      'gps_devices_img_del': gpsDevicesImageDelete,
      'before_installation_img_file': beforeInstallationImage,
      'before_installation_img_del': beforeInstallationImageDelete,
      'accessories_img_file': accessoriesImage,
      'accessories_img_del': accessoriesImageDelete,
      'additional_equipment_img1_file': additionalEquipmentImg1,
      'additional_equipment_img1_del': additionalEquipmentImg1Delete,
      'additional_equipment_img2_file': additionalEquipmentImg2,
      'additional_equipment_img2_del': additionalEquipmentImg2Delete,
      'after_installation_img_file': afterInstallationImage,
      'after_installation_img_del': afterInstallationImageDelete,
      'anten_gps_gsm_img_file': antennaGPSImage,
      'anten_gps_gsm_img_del': antennaGPSImageDelete,
      'engine_oil_status': engineOilController.selectedStatus,
      'transmission_status': transmissionController.selectedStatus,
      'differential_status': differentialController.selectedStatus,
      'other': otherController.text.isNotEmpty ? otherController.text : '',
      'notes': notesController.text.isNotEmpty ? notesController.text : '',
      'additional_img_file': additionalImage,
      'additional_img_del': additionalImageDelete,
    };

    // Gửi dữ liệu đến ViewModel
    bool isSuccess = await Provider.of<InspectionFormViewmodel>(context, listen: false).updateJob(widget.params, formData);
    if (isSuccess) {
      Alert.showOverlay(
        context: context,
        message:  AppLocalizations.of(context).translate('updated_job_success'),
        color: Colors.green,
      );
      _loadJobDetails();
    } else {
      Alert.showOverlay(
        context: context,
        message:  AppLocalizations.of(context).translate('updated_job_error'),
        color: Colors.red,
      );
    }
  }

  Future<void> finishJob() async {
    bool isSuccess = await Provider.of<InspectionFormViewmodel>(context, listen: false).doneJobs(widget.params);
    if (isSuccess) {
      Alert.showOverlay(
        context: context,
        message:  AppLocalizations.of(context).translate('done_job_success'),
        color: Colors.green,
      );

      navigateToRouteWithAnimationBack(
        context: context,
        routeName: '/home',
      );

    } else {
      Alert.showOverlay(
        context: context,
        message:  AppLocalizations.of(context).translate('done_job_error'),
        color: Colors.red,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inspections Form'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            navigateToRouteWithAnimationBack(
              context: context,
              routeName: '/home',
            );
          },
        ),
      ),
      body: isLoading ? const Center(child: CircularProgressIndicator()) :
      Column(
        children: [
          // Nội dung biểu mẫu
            Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  CustomAddField(label: AppLocalizations.of(context).translate('installation_type'),
                    options: InstallationType.all,
                    initialSelectedItems: jobDetails?['installation_type'],
                    notEditing: notEditing,
                    onChanged: (selectedValues) {
                      setState(() {
                        selectedInstallationTypes = selectedValues;
                      });
                    },
                  ),
                  CustomAddField(label: AppLocalizations.of(context).translate('accessories'),
                    options: Accessories.all,
                    initialSelectedItems: jobDetails?['accessories'],
                    notEditing: notEditing,
                    onChanged: (selectedValues) {
                      setState(() {
                        selectedAccessories = selectedValues;
                      });
                    },),
                  CustomTextField(label: AppLocalizations.of(context).translate('note'), controller: noteController, notEditing: notEditing,),
                  CustomDatePicker(label: AppLocalizations.of(context).translate('installation_date'), controller: installationDateController, notEditing: notEditing,),
                  CustomLocationField(label: AppLocalizations.of(context).translate('installation_location'), controller: installationLocationController, notEditing: notEditing,),
                  CustomTextField(label: AppLocalizations.of(context).translate('odometer_reading'), controller: odoController, notEditing: notEditing,),
                  CustomPhotoField(
                    label: AppLocalizations.of(context).translate('accessories_img'),
                    imageUrl: jobDetails?['accessories_img_path'] ?? '',
                    notEditing: notEditing,
                    onImageChanged: (file, isDeleted) {
                      setState(() {
                        accessoriesImage = file;
                        accessoriesImageDelete = isDeleted;
                      });
                    },
                  ),
                  CustomPhotoField(
                    label: AppLocalizations.of(context).translate('front_view'),
                    imageUrl: jobDetails?['front_view_img_path'] ?? '',
                    notEditing: notEditing,
                    onImageChanged: (file, isDeleted) {
                      setState(() {
                        frontViewImage = file;
                        frontViewImageDelete = isDeleted;
                      });
                    },
                  ),
                  CustomPhotoField(
                    label: AppLocalizations.of(context).translate('back_view'),
                    imageUrl: jobDetails?['back_view_img_path'] ?? '',
                    notEditing: notEditing,
                    onImageChanged: (file, isDeleted) {
                      setState(() {
                        backViewImage = file;
                        backViewImageDelete = isDeleted;
                      });
                    },
                  ),
                  CustomPhotoField(
                    label: AppLocalizations.of(context).translate('car_chassis'),
                    imageUrl: jobDetails?['car_chassis_img_path'] ?? '',
                    notEditing: notEditing,
                    onImageChanged: (file, isDeleted) {
                      setState(() {
                        carChassisImage = file;
                        carChassisImageDelete = isDeleted;
                      });
                    },
                  ),
                  CustomPhotoField(
                    label: AppLocalizations.of(context).translate('gps_devices'),
                    imageUrl: jobDetails?['gps_devices_img_path'] ?? '',
                    notEditing: notEditing,
                    onImageChanged: (file, isDeleted) {
                      setState(() {
                        gpsDevicesImage = file;
                        gpsDevicesImageDelete = isDeleted;
                      });
                    },
                  ),
                  CustomPhotoField(
                    label: AppLocalizations.of(context).translate('antenna_gps_gsm'),
                    imageUrl: jobDetails?['anten_gps_gsm_img_path'] ?? '',
                    notEditing: notEditing,
                    onImageChanged: (file, isDeleted) {
                      setState(() {
                        antennaGPSImage = file;
                        antennaGPSImageDelete = isDeleted;
                      });
                    },
                  ),
                  CustomPhotoField(
                    label: AppLocalizations.of(context).translate('before_installation'),
                    imageUrl: jobDetails?['before_installation_img_path'] ?? '',
                    notEditing: notEditing,
                    onImageChanged: (file, isDeleted) {
                      setState(() {
                        beforeInstallationImage = file;
                        beforeInstallationImageDelete = isDeleted;
                      });
                    },
                  ),
                  CustomPhotoField(
                    label: AppLocalizations.of(context).translate('after_installation'),
                    imageUrl: jobDetails?['after_installation_img_path'] ?? '',
                    notEditing: notEditing,
                    onImageChanged: (file, isDeleted) {
                      setState(() {
                        afterInstallationImage = file;
                        afterInstallationImageDelete = isDeleted;
                      });
                    },
                  ),
                  CustomPhotoField(
                    label: AppLocalizations.of(context).translate('additional_equipment_1'),
                    imageUrl: jobDetails?['additional_equipment_img1_path'] ?? '',
                    notEditing: notEditing,
                    onImageChanged: (file, isDeleted) {
                      setState(() {
                        additionalEquipmentImg1 = file;
                        additionalEquipmentImg1Delete = isDeleted;
                      });
                    },
                  ),
                  CustomPhotoField(
                    label: AppLocalizations.of(context).translate('additional_equipment_2'),
                    imageUrl: jobDetails?['additional_equipment_img2_path'] ?? '',
                    notEditing: notEditing,
                    onImageChanged: (file, isDeleted) {
                      setState(() {
                        additionalEquipmentImg2 = file;
                        additionalEquipmentImg2Delete = isDeleted;
                      });
                    },
                  ),
                  CustomPhotoField(
                    label: AppLocalizations.of(context).translate('additional_images'),
                    imageUrl: jobDetails?['additional_img_path'] ?? '',
                    notEditing: notEditing,
                    onImageChanged: (file, isDeleted) {
                      setState(() {
                        print("isDeleted $isDeleted");
                        additionalImage = file;
                        additionalImageDelete = isDeleted;
                      });
                    },
                  ),
                  InspectionChecklistWidget(label: AppLocalizations.of(context).translate('engine_oil'), controller: engineOilController, notEditing: notEditing,),
                  InspectionChecklistWidget(label: AppLocalizations.of(context).translate('transmission'), controller: transmissionController, notEditing: notEditing,),
                  InspectionChecklistWidget(label: AppLocalizations.of(context).translate('differential'), controller: differentialController, notEditing: notEditing,),
                  CustomTextField(label: AppLocalizations.of(context).translate('notes'), controller: notesController, notEditing: notEditing,),
                  CustomTextField(label: AppLocalizations.of(context).translate('other'), controller: otherController, notEditing: notEditing,),
                ],
              ),
            ),
          ),

          // Save and Cancel
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey, width: 0.5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: notEditing
                  ? [
                // Cancel Button
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _toggleEditing();
                    },
                    child: const Center(
                      child: Text(
                        'Edit',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 20), // Khoảng cách giữa hai button

                // Save Button
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _toggleEditing();
                      finishJob();
                    },
                    child: const Center(
                      child: Text(
                        'Done',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ]
                  : [
                // Cancel Button
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _confirmCancel();
                      _toggleEditing();
                    },
                    child: const Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 20), // Khoảng cách giữa hai button

                // Save Button
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _toggleEditing();
                      _onSave();
                    },
                    child: const Center(
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}