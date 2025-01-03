import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../drawer/drawer_menu.dart';
import '../viewmodels/home_viewmodel.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/inspection_item_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Lưu trữ các điều kiện tìm kiếm
  String? vinNo;
  String? fromDate;
  String? toDate;
  String? jobStatus;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeViewModel>(context, listen: false).fetchJobs();
    });

    // Thêm sự kiện cuộn để tải thêm dữ liệu
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        Provider.of<HomeViewModel>(context, listen: false).fetchMoreJobs();
      }
    });
  }
  void _onSearch(Map<String, String> criteria) {
    setState(() {
      vinNo = criteria['search'];
      fromDate = criteria['from_date'];
      toDate = criteria['to_date'];
      jobStatus = criteria['status'];
    });

    Provider.of<HomeViewModel>(context, listen: false)
        .fetchJobsWithCriteria(criteria);
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);


    return Scaffold(
      appBar: CustomAppBar(onSearch: _onSearch),
      drawer: const DrawerMenu(userEmail: 'balloon28th@gmail.com'),
      body: homeViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : homeViewModel.errorMessage != null
          ? Center(
        child: Text(
          'Error: ${homeViewModel.errorMessage}',
          style: const TextStyle(color: Colors.red),
        ),
      )
          : ListView.builder(
        controller: _scrollController,
        itemCount: homeViewModel.groupedJobs.length +
            (homeViewModel.isFetchingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == homeViewModel.groupedJobs.length) {
            return const Center(child: CircularProgressIndicator());
          }

          final group = homeViewModel.groupedJobs[index];
          final date = group['date'];
          final items =
          group['items'] as List<Map<String, dynamic>>;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hiển thị ngày
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 16.0),
                child: Row(
                  children: [
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      radius: 12,
                      child: Text(
                        '${items.length}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Hiển thị danh sách item trong ngày
              ...items.map((item) {
                return InspectionItemCard(
                  job_id: item['job_id'],
                  imageUrl: item['segment_img'],
                  vehicleNumber: item['vin_no'],
                  description: item['job_status'],
                  onTap: () {
                  },
                );
              }).toList(),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}