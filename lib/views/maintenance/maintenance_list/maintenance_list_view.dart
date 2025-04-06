import 'package:altur/controller/maintenance_controller.dart';
import 'package:altur/view_models/maintenance_view_model.dart';
import 'package:altur/views/maintenance/maintenance_add/maintenance_add_view.dart';
import 'package:altur/views/maintenance/maintenance_list/past_record_list_view.dart';
import 'package:altur/views/maintenance/maintenance_list/upcoming_record_list_view.dart';
import 'package:altur/widgets/common_appbar.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MaintenanceListView extends StatefulWidget {
  final int vehicleId;
  final int initialIndex;

  const MaintenanceListView({super.key, required this.vehicleId, this.initialIndex = 0});

  @override
  _MaintenanceListViewState createState() => _MaintenanceListViewState();
}

class _MaintenanceListViewState extends State<MaintenanceListView> {
  late int _selectedIndex;
  late MaintenanceViewModel maintenanceViewModel;
  bool isLoading = true;

  static const List<IconData> iconList = [
    Icons.history,
    Icons.schedule,
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    var maintenanceRecordController = Get.find<MaintenanceRecordController>();
    maintenanceViewModel = Get.put(MaintenanceViewModel(maintenanceRecordController: maintenanceRecordController));
    loadRecords(); // Load records on init
  }

  Future<void> loadRecords() async {
    await maintenanceViewModel.loadRecords(widget.vehicleId);
    setState(() {
      isLoading = false;
    });
    if (maintenanceViewModel.pastRecords.isEmpty && maintenanceViewModel.upcomingRecords.isEmpty) {
      Get.off(() => MaintenanceAddView(vehicleId: widget.vehicleId,));
    }
  }

  List<Widget> _widgetOptions() {
    return [
      PastRecordListView(),
      UpcomingRecordListView(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : _widgetOptions().elementAt(_selectedIndex),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          Get.to(() => MaintenanceAddView(vehicleId: widget.vehicleId));
        },
        backgroundColor: Colors.blueGrey.shade700,
        child: Icon(Icons.add, color: Colors.white,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: Colors.blueGrey.shade600,
        icons: iconList,
        activeIndex: _selectedIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.smoothEdge,
        onTap: _onItemTapped,
        activeColor: Colors.white,
        splashColor: Colors.white,
        inactiveColor: Colors.white54,
        iconSize: 30,
        leftCornerRadius: 5,
        rightCornerRadius: 5,
      ),
    );
  }
}

  