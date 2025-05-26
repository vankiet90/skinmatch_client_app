import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import '../models/customer_model.dart';
import 'package:intl/intl.dart';
import '../views/customer_detail_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../views/custom_donut_chart.dart';

enum SortOption {
  nameAZ,
  nameZA,
  spentHighToLow,
  spentLowToHigh,
  dateEarliest,
  dateLatest,
}

class CustomerView extends StatefulWidget {
  const CustomerView({super.key});

  @override
  State<CustomerView> createState() => _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView> {
  bool isOverview = true;
  late PageController _pageController;

  bool showFilterPopup = false;
  SortOption? selectedOption;

  final skinColorList = [
    Colors.pink.shade100,
    Colors.pink.shade300,
    Colors.pink.shade400,
    Colors.pink.shade600,
  ];

  final List<Map<String, dynamic>> customerMaps = [
    {
      "name": "Esther Howard",
      "avatar": "https://i.pravatar.cc/100?img=1",
      "badge": "Standard",
      "totalSpent": "\$1,234",
      "scanCount": "3 scans",
      "lastVisited": "23/12/2024",
      "servedBy": "Anna",
      "badgeColor": Colors.grey[200],
      "badgeTextColor": Colors.black,
    },
    {
      "name": "Savannah Nguyen",
      "avatar": "https://i.pravatar.cc/100?img=2",
      "badge": "V.I.P",
      "totalSpent": "\$1,234",
      "scanCount": "3 scans",
      "lastVisited": "23/12/2024",
      "servedBy": "Anna",
      "badgeColor": Colors.pink[400],
      "badgeTextColor": Colors.white,
    },
    {
      "name": "Cody Fisher",
      "avatar": "https://i.pravatar.cc/100?img=3",
      "badge": "V.I.P",
      "totalSpent": "\$1,234",
      "scanCount": "3 scans",
      "lastVisited": "23/12/2024",
      "servedBy": "Anna",
      "badgeColor": Colors.pink[400],
      "badgeTextColor": Colors.white,
    },
  ];

  late List<CustomerModel> customers;

  final skinProfileData = {
    "Oil": 40.0,
    "Combination": 10.0,
    "Dry": 30.0,
    "Sensitive": 20.0,
  };

  final ageData = {
    "14–18": 20.0,
    "19–24": 10.0,
    "25–30": 30.0,
    "31–40": 40.0,
  };

  final genderData = {
    "Female": 55.0,
    "Male": 20.0,
    "Other": 25.0,
  };

  final colorList = const [
    Color(0xFFF06292), // Female, Oil, 14–18
    Color(0xFFF8BBD0), // Male, Combination, 19–24
    Color(0xFF8E244D), // Other, Dry, 25–30
    Color(0xFFE3A8BD), // Sensitive, 31–40
  ];

  void applySorting(SortOption option) {
    setState(() {
      switch (option) {
        case SortOption.nameAZ:
          customers.sort((a, b) {
            final nameA = a.name?.toLowerCase() ?? '';
            final nameB = b.name?.toLowerCase() ?? '';
            return nameA.compareTo(nameB);
          });
          break;

        case SortOption.nameZA:
          customers.sort((a, b) {
            final nameA = a.name?.toLowerCase() ?? '';
            final nameB = b.name?.toLowerCase() ?? '';
            return nameB.compareTo(nameA);
          });
          break;

        case SortOption.spentHighToLow:
          customers
              .sort((a, b) => (b.totalSpent ?? 0).compareTo(a.totalSpent ?? 0));
          break;
        case SortOption.spentLowToHigh:
          customers
              .sort((a, b) => (a.totalSpent ?? 0).compareTo(b.totalSpent ?? 0));
          break;
        case SortOption.dateEarliest:
          customers.sort((a, b) => (a.lastVisited ?? DateTime(1900))
              .compareTo(b.lastVisited ?? DateTime(1900)));
          break;
        case SortOption.dateLatest:
          customers.sort((a, b) => (b.lastVisited ?? DateTime(1900))
              .compareTo(a.lastVisited ?? DateTime(1900)));
          break;
      }
    });
  }

  Widget buildFilterPopup() {
    final localization = AppLocalizations.of(context)!;
    return Positioned(
      top: 60,
      right: 16,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 250,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.pink.shade100),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildFilterGroup(localization.customerName, [
                buildFilterItem(localization.fromAtoZ, SortOption.nameAZ),
                buildFilterItem(localization.fromZtoA, SortOption.nameZA),
              ]),
              const Divider(),
              buildFilterGroup(localization.totalSpent, [
                buildFilterItem(
                    localization.highToLow, SortOption.spentHighToLow),
                buildFilterItem(
                    localization.lowToHigh, SortOption.spentLowToHigh),
              ]),
              const Divider(),
              buildFilterGroup(localization.lastVisitedDate, [
                buildFilterItem(localization.earliest, SortOption.dateEarliest),
                buildFilterItem(localization.latest, SortOption.dateLatest),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFilterGroup(String title, List<Widget> options) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 6),
          ...options,
        ],
      ),
    );
  }

  Widget buildFilterItem(String label, SortOption option) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedOption = option;
          showFilterPopup = false;
          applySorting(option);
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Text(label),
      ),
    );
  }

  Widget buildCustomerItem(BuildContext context, CustomerModel customer) {
    final localization = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CustomerDetailView(customer: customer),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage:
                      customer.avatar != null && customer.avatar!.isNotEmpty
                          ? NetworkImage(customer.avatar!)
                          : const AssetImage('assets/images/default_avatar.png')
                              as ImageProvider,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customer.name ?? localization.noName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: customer.badgeColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        customer.badge ?? localization.noBadge,
                        style: TextStyle(
                          fontSize: 12,
                          color: customer.badgeTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildCustomerDetail(localization.totalSpent,
                    "\$${(customer.totalSpent ?? 0).toStringAsFixed(2)}"),
                buildCustomerDetail(localization.skinScan,
                    customer.scanCount?.toString() ?? '0'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildCustomerDetail(
                  localization.lastVisited,
                  customer.lastVisited != null
                      ? DateFormat('dd/MM/yyyy').format(customer.lastVisited!)
                      : 'N/A',
                ),
                buildCustomerDetail(localization.servedBy,
                    customer.servedBy ?? localization.unknown),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCustomerDetail(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget buildTabButton(String text, bool selected, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(vertical: 10),
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: selected ? Colors.white : const Color(0xFFFDDDE8),
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            style: TextStyle(
              color: Colors.pink[900],
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
            child: Text(text),
          ),
        ),
      ),
    );
  }

  Widget buildCard(String title, String value, String percent) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.pink[100]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            const Icon(Icons.location_pin, color: Colors.pink),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '+$percent%',
                style: const TextStyle(color: Colors.green, fontSize: 12),
              ),
            ),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 4),
            Text(value,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget buildChart(
      String title, Map<String, double> dataMap, List<Color> colorList) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.pink.withOpacity(0.2)), // viền chart
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          PieChart(
            dataMap: dataMap,
            colorList: colorList,
            chartType: ChartType.ring,
            ringStrokeWidth: 30,
            chartLegendSpacing: 24,
            legendOptions: const LegendOptions(
              showLegends: true,
              legendPosition: LegendPosition.bottom,
              legendShape: BoxShape.circle,
              showLegendsInRow: true,
              legendTextStyle: TextStyle(fontSize: 14),
            ),
            chartValuesOptions: const ChartValuesOptions(
              showChartValuesInPercentage: true,
              showChartValuesOutside: true,
              showChartValues: true,
              decimalPlaces: 0,
              chartValueBackgroundColor: Colors.transparent,
              chartValueStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearchBar() {
    final localization = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.pink.shade100),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: localization.searchByNameOrdeNumber,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              setState(() {
                showFilterPopup = !showFilterPopup;
              });
            },
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.pink.shade100),
              ),
              child: const Icon(Icons.swap_vert, color: Colors.pink),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    customers = customerMaps.map((map) => CustomerModel.fromJson(map)).toList();
    _pageController = PageController(initialPage: isOverview ? 0 : 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFFFEEFF4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFEEFF4),
        elevation: 0,
        title: Text(
          localization.customer,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Tab buttons
          Row(
            children: [
              buildTabButton(localization.overview, isOverview, 0),
              buildTabButton(localization.customerList, !isOverview, 1),
            ],
          ),

          // PageView content
          Expanded(
            child: Stack(
              children: [
                PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      isOverview = index == 0;
                    });
                  },
                  children: [
                    // Overview page
                    SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              buildCard('CLV', '\$341 000', '12.5'),
                              buildCard(
                                  localization.repeatPurchase, '60%', '12.5'),
                            ],
                          ),
                          // CustomDonutChart(
                          //   title: localization.skinProfile,
                          //   dataMap: skinProfileData,
                          //   colorList: skinColorList,
                          // ),
                          // CustomDonutChart(
                          //   title: localization.age,
                          //   dataMap: ageData,
                          //   colorList: skinColorList,
                          // ),
                          // CustomDonutChart(
                          //   title: localization.gender,
                          //   dataMap: genderData,
                          //   colorList: skinColorList,
                          // ),
                          buildChart(localization.skinProfile, skinProfileData,
                              skinColorList),
                          buildChart(localization.age, ageData, skinColorList),
                          buildChart(
                              localization.gender, genderData, skinColorList),
                        ],
                      ),
                    ),

                    // Customer list page
                    Column(
                      children: [
                        buildSearchBar(),
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.only(bottom: 20),
                            itemCount: customers.length,
                            itemBuilder: (context, index) {
                              return buildCustomerItem(
                                  context, customers[index]);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // 👇 Popup filter và lớp overlay
                if (!isOverview && showFilterPopup) ...[
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showFilterPopup = false;
                        });
                      },
                      child: Container(color: Colors.transparent),
                    ),
                  ),
                  buildFilterPopup(),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
