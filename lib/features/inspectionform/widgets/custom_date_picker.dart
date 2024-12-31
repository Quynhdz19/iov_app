import 'package:flutter/material.dart';

class CustomDatePicker extends StatefulWidget {
  final String label;

  const CustomDatePicker({Key? key, required this.label}) : super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          // Label với chiều rộng cố định
          SizedBox(
            width: 120, // Chiều rộng cố định của label
            child: Text(
              widget.label,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          const SizedBox(width: 8), // Khoảng cách giữa label và ô nhập
          // TextFormField để chọn ngày
          Expanded(
            child: TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () async {
                // Hiển thị hộp thoại chọn ngày
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  setState(() {
                    _controller.text =
                    "${pickedDate.toLocal()}".split(' ')[0]; // Định dạng ngày
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}