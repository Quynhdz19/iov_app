import 'package:flutter/material.dart';

class InspectionChecklistWidget extends StatelessWidget {
  final String label;

  const InspectionChecklistWidget({Key? key, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 16),
          // Buttons Layout
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Requires Attention Button
                OutlinedButton(
                  onPressed: () {
                    // Handle Requires Attention action
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: const Color.fromRGBO(248, 249, 251, 1), // Màu nền RGB
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Bo góc
                    ),
                    side: const BorderSide(color: Colors.grey), // Màu viền
                  ),
                  child: const Text(
                    'Requires Attention',
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 8),
                // Future Attention and OK Buttons in Row
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // Handle Future Attention action
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor:
                          const Color.fromRGBO(248, 249, 251, 1), // Màu nền RGB
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // Bo góc
                          ),
                          side: const BorderSide(color: Colors.grey), // Màu viền
                        ),
                        child: const Text(
                          'Future Attention',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // Handle OK action
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor:
                          const Color.fromRGBO(248, 249, 251, 1), // Màu nền RGB
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // Bo góc
                          ),
                          side: const BorderSide(color: Colors.grey), // Màu viền
                        ),
                        child: const Text(
                          'OK',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // N/A Button
                OutlinedButton(
                  onPressed: () {
                    // Handle N/A action
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: const Color.fromRGBO(248, 249, 251, 1), // Màu nền RGB
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Bo góc
                    ),
                    side: const BorderSide(color: Colors.grey), // Màu viền
                  ),
                  child: const Text(
                    'N/A',
                    style: TextStyle(fontSize: 12, color: Colors.black),
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