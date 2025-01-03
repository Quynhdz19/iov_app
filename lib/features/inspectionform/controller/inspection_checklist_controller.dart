import '../widgets/inspection_checklist_field.dart';

class InspectionChecklistController {
  String selectedStatus = CAR_PARAMETER_STATUS.NA;

  void updateStatus(String status) {
    selectedStatus = status;
  }

  void setInitialStatus(String status) {
    selectedStatus = status;
  }
}