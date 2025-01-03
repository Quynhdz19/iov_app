class JobStatus {
  static const String ASSIGNED = 'Assigned';
  static const String FINISHED_INSTALLATION = 'Finished Installation';
  static const String COMPLETED = 'Completed';
  static const String NEED_UPDATE = 'Need Update';
  static const String UPDATED = 'Updated';

  static const List<String> values = [
    ASSIGNED,
    FINISHED_INSTALLATION,
    COMPLETED,
    NEED_UPDATE,
    UPDATED,
  ];
}