import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../utils/color_utils.dart';
import 'package:intl/intl.dart';
import '../views/account_view.dart';
import 'package:fl_chart/fl_chart.dart';
import '../widgets/sale_trend_chart.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // Custom AppBar Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return PreferredSize(
      preferredSize:
          const Size.fromHeight(kToolbarHeight), // Set the desired height
      child: AppBar(
        backgroundColor: ColorUtils.lightBackgroundSM, // Make it transparent
        elevation: 0, // Remove shadow
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    const AccountView(), // Navigate to ProfileView
              ),
            );
          },
          child: Row(
            children: [
              const SizedBox(
                width: 46,
                height: 46,
                child: CircleAvatar(
                  radius: 23,
                  backgroundImage:
                      AssetImage('assets/images/customer_avatar.png'),
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${localization.goodMorning}, Sophia', // Or get the user's name
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black, // Use your color
                    ),
                  ),
                  Text(
                    '${localization.today}, ${DateFormat('MMM dd, yyyy').format(DateTime.now())}', // Format the date
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey, // Use your color
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined,
                color: Colors.black), // Use your icon
            onPressed: () {
              // Handle notification action
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final localization = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context), // Use the custom AppBar here

      body: const Center(
        child: DashboardView(),
      ),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Alert banner
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.pink.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.warning, color: Colors.red),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text("30 products need your attention now!",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Icon(Icons.close, color: Colors.black54),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _tabButton("Shop metric"),
                  _tabButton("Recommendation"),
                ],
              ),

              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: "Today’s data",
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: ["Today’s data", "Yesterday", "Last 7 days"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (_) {},
              ),

              const SizedBox(height: 16),
              _statCardGrid(),
              const SizedBox(height: 24),

              const SaleTrendChart(),

              // const Text("Sale trend",
              //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              // const SizedBox(height: 8),
              // _chartSwitcher(),
              // SizedBox(height: 180, child: _sampleChart()),

              const SizedBox(height: 24),
              _inventoryAlerts(),
              const SizedBox(height: 24),
              _bestSelling(),
              const SizedBox(height: 24),
              _topCustomers()
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabButton(String label) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.pink,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        onPressed: () {},
        child: Text(label),
      );

  Widget _statCardGrid() => GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 2.2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        children: [
          _statCard("Total sale", "\$341 000"),
          _statCard("Avg Transaction", "200,000"),
          _statCard("Transaction", "60"),
          _statCard("New customer", "20"),
        ],
      );

  Widget _statCard(String title, String value) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.analytics, color: Colors.pink),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text("+12.5%",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                )
              ],
            ),
            Text(title),
            Text(value,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      );

  Widget _chartSwitcher() => Row(
        children: ["Day", "Week", "Month"]
            .map((label) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Chip(label: Text(label)),
                ))
            .toList(),
      );

  Widget _sampleChart() => LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: const [
                FlSpot(0, 600),
                FlSpot(1, 1000),
                FlSpot(2, 800),
                FlSpot(3, 500),
                FlSpot(4, 1100),
                FlSpot(5, 900),
                FlSpot(6, 800),
              ],
              isCurved: true,
              color: Colors.pinkAccent,
              barWidth: 3,
              belowBarData:
                  BarAreaData(show: true, color: Colors.pink.shade100),
            )
          ],
        ),
      );

  Widget _inventoryAlerts() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Inventory alerts",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          _inventoryCard("Radianté Moisturizer", "2 units", "Low stock", 29),
          _inventoryCard(
              "Radianté Moisturizer", "12 units", "Expiring Soon", 29),
          TextButton(onPressed: () {}, child: const Text("View more"))
        ],
      );

  Widget _inventoryCard(String name, String qty, String status, int price) =>
      Card(
        child: ListTile(
          leading: Image.network(
              'https://i.imgur.com/L68FtMA.png', // placeholder bottle
              width: 40),
          title: Text(name),
          subtitle: Text(qty),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("\$$price"),
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(status,
                    style: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      );

  Widget _bestSelling() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Best selling",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                  3,
                  (index) => Container(
                        width: 120,
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Image.network(
                              'https://i.imgur.com/L68FtMA.png',
                              height: 60,
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text("+12.5%",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(height: 4),
                            const Text("Radianté",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            const Text("142 units sold"),
                            const Text("\$3,500",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      )),
            ),
          )
        ],
      );

  Widget _topCustomers() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Top customers",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          Column(
            children: List.generate(
                3,
                (index) => ListTile(
                      leading: const CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://i.imgur.com/BoN9kdC.png'), // placeholder face
                      ),
                      title: const Text("Jacob"),
                      subtitle: const Text("\$600"),
                      trailing: const Text("24.5%"),
                    )),
          )
        ],
      );
}
